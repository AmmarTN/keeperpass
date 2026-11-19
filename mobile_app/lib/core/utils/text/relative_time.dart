/// "3 days ago", "in 2 months" (web `features/items/format-date.ts`
/// `formatRelativeToNow`), from tables generated once from Node's
/// `Intl.RelativeTimeFormat(locale, {numeric: 'auto'})` into
/// `assets/i18n/relative_time.json` (open item O7: no `intl4x`).
///
/// The table maps locale → unit → whole number → text, covering every value
/// the units below can produce (years up to ±150; beyond that the 150 entry
/// is reused with the number replaced).
class RelativeTimeFormatter {
  const RelativeTimeFormatter(this._table);

  /// The decoded asset.
  final Map<String, dynamic> _table;

  static const int _minute = 60 * 1000;
  static const int _hour = 60 * _minute;
  static const int _day = 24 * _hour;

  /// Largest unit first, as on the web.
  static const List<(String, int)> _units = <(String, int)>[
    ('year', 365 * _day),
    ('month', 30 * _day),
    ('week', 7 * _day),
    ('day', _day),
    ('hour', _hour),
    ('minute', _minute),
  ];

  /// [date] relative to [now], in the app language [locale] (`en`, `de`,
  /// `es`, `fr`, `pt`; others fall back to English).
  String format(
    DateTime date, {
    required DateTime now,
    required String locale,
  }) {
    final int elapsed =
        date.millisecondsSinceEpoch - now.millisecondsSinceEpoch;
    final int magnitude = elapsed.abs();
    for (final (String unit, int ms) in _units) {
      if (magnitude >= ms) return _text(locale, unit, _jsRound(elapsed / ms));
    }
    return _text(locale, 'second', _jsRound(elapsed / 1000));
  }

  String _text(String locale, String unit, int value) {
    final Map<String, dynamic> units =
        (_table[locale] ?? _table['en']) as Map<String, dynamic>;
    final Map<String, dynamic> values = units[unit] as Map<String, dynamic>;
    final String? exact = values['$value'] as String?;
    if (exact != null) return exact;
    // Beyond the table (only years can be): reuse the furthest entry.
    final int edge = value.isNegative ? -150 : 150;
    return (values['$edge'] as String).replaceFirst('150', '${value.abs()}');
  }
}

/// JavaScript's `Math.round`: halves round up, toward +∞ (Dart's `round`
/// rounds them away from zero).
int _jsRound(double value) => (value + 0.5).floor();
