/// Settings › Clear clipboard (board `S5-16`): copied passwords and codes
/// leave the clipboard after 30 s, 1 or 2 minutes, or never. The clearing
/// itself comes with Part 14.
enum ClipboardClearDelay {
  thirtySeconds('30s', Duration(seconds: 30)),
  oneMinute('1m', Duration(minutes: 1)),
  twoMinutes('2m', Duration(minutes: 2)),
  never('never', null);

  const ClipboardClearDelay(this.value, this.duration);

  /// What the phone stores.
  final String value;

  /// Null: never cleared.
  final Duration? duration;

  /// The board's choice (the web never clears).
  static const ClipboardClearDelay standard = ClipboardClearDelay.thirtySeconds;

  static ClipboardClearDelay? tryParse(String? value) {
    for (final ClipboardClearDelay delay in values) {
      if (delay.value == value) return delay;
    }
    return null;
  }
}
