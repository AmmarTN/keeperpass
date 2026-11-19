// Date and month field values (porting trap 4, open item O3).
//
// They are stored as the web's native pickers write them: `YYYY-MM-DD` and
// `YYYY-MM`. They are calendar values, not moments: the app shows the date
// that was stored (O3 — the web's `new Date('2026-08-15')` shows the day
// before west of UTC; the app does not copy that). `DateTime.parse` throws
// on `YYYY-MM`, so both are read by hand.

final RegExp _dateValue = RegExp(r'^(\d{4})-(\d{2})-(\d{2})$');
final RegExp _monthValue = RegExp(r'^(\d{4})-(\d{2})$');

/// A stored date as a local calendar date at midnight, or null when the
/// value is not a valid `YYYY-MM-DD`.
DateTime? parseFieldDate(String value) {
  final RegExpMatch? m = _dateValue.firstMatch(value.trim());
  if (m == null) return null;
  final int year = int.parse(m[1]!);
  final int month = int.parse(m[2]!);
  final int day = int.parse(m[3]!);
  final DateTime date = DateTime(year, month, day);
  // Rejects 2026-02-30 instead of rolling it into March.
  if (date.year != year || date.month != month || date.day != day) return null;
  return date;
}

/// A stored month as (year, month), or null when the value is not a valid
/// `YYYY-MM`.
({int year, int month})? parseFieldMonth(String value) {
  final RegExpMatch? m = _monthValue.firstMatch(value.trim());
  if (m == null) return null;
  final int month = int.parse(m[2]!);
  if (month < 1 || month > 12) return null;
  return (year: int.parse(m[1]!), month: month);
}

/// The stored form of a picked date: `YYYY-MM-DD`.
String fieldDateValue(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

/// The stored form of a picked month: `YYYY-MM`.
String fieldMonthValue(int year, int month) =>
    '${year.toString().padLeft(4, '0')}-${month.toString().padLeft(2, '0')}';
