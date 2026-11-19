import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/clipboard_local_data_source.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/repositories/lock_settings_repository_impl.dart';

/// A copy that went through; [clearsIn] is when it leaves the clipboard
/// (null: it stays).
typedef Copied = ({Duration? clearsIn});

/// Whether copying [field] puts a secret on the clipboard: a hidden field or
/// a 2FA code (your answer, Part 14).
bool copiesSecret(Field field) =>
    field.isSecret || field.type == FieldType.totp;

/// The only door to the system clipboard (web `ClipboardService`): every
/// copy in the app goes through here. A secret — a password or another
/// hidden field, a 2FA code, a generated password — is cleared after the
/// Settings delay, only if nothing else was copied since (board
/// `Lock-privacy`; your answer, Part 14: secrets only). The clear happens
/// only while KeeperPass is open (your answer: Android cannot look at the
/// clipboard from the background); iOS also lets the copy expire by itself.
@singleton
class ClipboardService {
  ClipboardService(
    this._clipboard,
    this._settings, {
    @ignoreParam bool Function()? isOpen,
  }) : _isOpen = isOpen ?? _appInFront;

  final IClipboardLocalDataSource _clipboard;
  final ILockSettingsRepository _settings;
  final bool Function() _isOpen;
  final StreamController<void> _cleared = StreamController<void>.broadcast();
  Timer? _timer;

  /// iOS's own expiry comes a moment after the in-app clear, so the
  /// "Clipboard cleared" toast can still tell.
  static const Duration _expirySlack = Duration(seconds: 1);

  static bool _appInFront() =>
      WidgetsBinding.instance.lifecycleState == AppLifecycleState.resumed;

  /// Each clear KeeperPass made while open ("Clipboard cleared").
  Stream<void> get cleared => _cleared.stream;

  /// Copies [value]; a [sensitive] one is cleared after the Settings delay.
  /// The result is that delay — what the toast counts down — or null when
  /// it stays.
  Future<Duration?> copy(String value, {bool sensitive = false}) async {
    _timer?.cancel();
    if (!sensitive) {
      await _clipboard.copy(value, sensitive: false);
      return null;
    }
    final Duration? delay = (await _settings.getClipboardClearDelay())
        .getOrElse(() => ClipboardClearDelay.standard)
        .duration;
    final String? marker = await _clipboard.copy(
      value,
      sensitive: true,
      expiresIn: delay == null ? null : delay + _expirySlack,
    );
    if (delay != null && marker != null) {
      _timer = Timer(delay, () => unawaited(_expire(marker)));
    }
    return delay;
  }

  Future<void> _expire(String marker) async {
    if (!_isOpen()) return;
    if (await _clipboard.clearIfOurs(marker)) _cleared.add(null);
  }
}
