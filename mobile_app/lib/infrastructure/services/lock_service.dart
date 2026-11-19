import 'dart:async';

import 'package:injectable/injectable.dart';

/// What the auto-lock needs to know about use of the app (web
/// `AutoLockService`'s listeners): when the person last touched it, and
/// whether the app itself sent them to a system screen (a provider's
/// sign-in, a share or file sheet) — leaving for that is not leaving the
/// app, and must not lock away the vault or an unsaved change.
@lazySingleton
class LockService {
  LockService({@ignoreParam DateTime Function() now = DateTime.now})
    : _now = now,
      _lastActivity = now();

  final DateTime Function() _now;
  DateTime _lastActivity;
  int _externalUi = 0;
  final StreamController<void> _activity = StreamController<void>.broadcast(
    sync: true,
  );

  DateTime get lastActivity => _lastActivity;

  /// A system screen the app opened is in front.
  bool get inExternalUi => _externalUi > 0;

  /// Fires on every recorded use.
  Stream<void> get activity => _activity.stream;

  /// Real use: a touch, a key, coming back to the app.
  void recordActivity() {
    _lastActivity = _now();
    _activity.add(null);
  }

  /// Runs [body] while a system screen the app opened is in front.
  Future<T> duringExternalUi<T>(Future<T> Function() body) async {
    _externalUi++;
    try {
      return await body();
    } finally {
      _externalUi--;
      recordActivity();
    }
  }
}
