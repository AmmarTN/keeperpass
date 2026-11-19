import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/lock_reason.dart';
import 'package:keeperpass/core/usecases/settings/get_auto_lock_delay.dart';
import 'package:keeperpass/core/usecases/settings/save_auto_lock_delay.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

/// Locks the vault: on "Lock now", after the auto-lock delay without use,
/// and on leaving the app when the delay is "Immediately" (web
/// `AutoLockService`, board `Settings`). Locking wipes the decrypted vault;
/// the sign-in stays.
///
/// Only real use counts as activity (touches, keys, coming back to the app).
/// The phone suspends the app in the background, so the delay is checked
/// again when it comes back: time away counts, as a background browser tab
/// still locks on schedule.
@lazySingleton
final class LockCubit extends Cubit<AutoLockDelay> {
  LockCubit(
    this._session,
    this._lock,
    this._getAutoLockDelay,
    this._saveAutoLockDelay, {
    @ignoreParam this._now = DateTime.now,
  }) : super(AutoLockDelay.standard);

  final SessionCubit _session;
  final LockService _lock;
  final GetAutoLockDelay _getAutoLockDelay;
  final SaveAutoLockDelay _saveAutoLockDelay;
  final DateTime Function() _now;

  Timer? _timer;
  StreamSubscription<SessionState>? _sessionSubscription;
  StreamSubscription<void>? _activitySubscription;
  AppLifecycleListener? _lifecycle;

  bool get _ready => _session.state.isReady;

  /// Called once at startup.
  Future<void> start({bool watchLifecycle = true}) async {
    emit(
      (await _getAutoLockDelay(
        const NoParams(),
      )).getOrElse(() => AutoLockDelay.standard),
    );
    _sessionSubscription ??= _session.stream.listen((SessionState session) {
      if (session.isReady) {
        _schedule();
      } else {
        _cancel();
      }
    });
    _activitySubscription ??= _lock.activity.listen((_) => _schedule());
    if (watchLifecycle) {
      _lifecycle ??= AppLifecycleListener(onHide: appHidden, onShow: appShown);
      HardwareKeyboard.instance.addHandler(_onKey);
    }
    if (_ready) _lock.recordActivity();
  }

  /// Settings › Auto-lock, saved on this phone.
  Future<void> setDelay(AutoLockDelay delay) async {
    emit(delay);
    await _saveAutoLockDelay(delay);
    _schedule();
  }

  /// A touch or a key anywhere in the app.
  void recordActivity() => _lock.recordActivity();

  /// "Lock now".
  void lockNow() => _session.lock(LockReason.manual);

  /// A hardware key counts as use (web `keydown`); never consumed.
  bool _onKey(KeyEvent event) {
    if (event is KeyDownEvent) _lock.recordActivity();
    return false;
  }

  /// The app left the foreground.
  @visibleForTesting
  void appHidden() {
    _cancel();
    if (_ready && !_lock.inExternalUi && state == AutoLockDelay.immediately) {
      _session.lock(LockReason.leftApp);
    }
  }

  /// The app is back in front.
  @visibleForTesting
  void appShown() {
    if (!_ready || _lock.inExternalUi) return;
    if (_idleTooLong) {
      _session.lock(LockReason.inactivity);
    } else {
      _lock.recordActivity();
    }
  }

  bool get _idleTooLong =>
      state != AutoLockDelay.immediately &&
      _now().difference(_lock.lastActivity) >= state.duration;

  void _schedule() {
    _cancel();
    if (!_ready || state == AutoLockDelay.immediately) return;
    final Duration remaining =
        state.duration - _now().difference(_lock.lastActivity);
    _timer = Timer(remaining.isNegative ? Duration.zero : remaining, _expire);
  }

  void _expire() {
    // Coming back from a system screen records activity, which schedules
    // again.
    if (!_ready || _lock.inExternalUi) return;
    if (!_idleTooLong) {
      _schedule();
      return;
    }
    _session.lock(LockReason.inactivity);
  }

  void _cancel() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() async {
    _cancel();
    if (_lifecycle != null) HardwareKeyboard.instance.removeHandler(_onKey);
    _lifecycle?.dispose();
    await _sessionSubscription?.cancel();
    await _activitySubscription?.cancel();
    return super.close();
  }
}
