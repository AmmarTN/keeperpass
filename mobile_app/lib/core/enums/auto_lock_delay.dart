/// Settings › Auto-lock (board `Settings`): "Immediately on leaving the app",
/// or after 1, 5 or 10 minutes without use; 10 matches the web app.
enum AutoLockDelay {
  immediately('immediately', Duration.zero),
  oneMinute('1m', Duration(minutes: 1)),
  fiveMinutes('5m', Duration(minutes: 5)),
  tenMinutes('10m', Duration(minutes: 10));

  const AutoLockDelay(this.value, this.duration);

  /// What the phone stores.
  final String value;

  /// How long the app may sit untouched; zero locks on leaving the app.
  final Duration duration;

  /// The web's `AUTO_LOCK_AFTER_MS`.
  static const AutoLockDelay standard = AutoLockDelay.tenMinutes;

  static AutoLockDelay? tryParse(String? value) {
    for (final AutoLockDelay delay in values) {
      if (delay.value == value) return delay;
    }
    return null;
  }
}
