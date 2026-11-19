import 'package:intl/intl.dart';

// Dates as the web shows them (`features/items/format-date.ts`,
// `core/models/field.ts`), per app language. The patterns are pinned rather
// than taken from Dart's locale data, which differs from the browser's in
// places (German medium dates); `test/fixtures/date_formats.json` holds
// Node's `Intl` output for every language and the tests compare against it.

/// `Intl.DateTimeFormat(locale, {dateStyle: 'medium'})`: "Apr 12, 1992".
const Map<String, String> _mediumDate = <String, String>{
  'en': 'MMM d, y',
  'de': 'dd.MM.y',
  'es': 'd MMM y',
  'fr': 'd MMM y',
  'pt': "d 'de' MMM 'de' y",
};

/// `Intl.DateTimeFormat(locale, {timeStyle: 'short'})`: "9:41 AM".
const Map<String, String> _shortTime = <String, String>{
  'en': 'h:mm a',
  'de': 'HH:mm',
  'es': 'H:mm',
  'fr': 'HH:mm',
  'pt': 'HH:mm',
};

/// A month field (`toLocaleDateString` with numeric year and 2-digit
/// month): "08/2026".
const Map<String, String> _month = <String, String>{
  'en': 'MM/y',
  'de': 'MM.y',
  'es': 'M/y',
  'fr': 'MM/y',
  'pt': 'MM/y',
};

String _language(String locale) =>
    _mediumDate.containsKey(locale) ? locale : 'en';

/// Formats with [language]'s data; until it is loaded (the app's
/// localizations load it), with the built-in English data.
String _format(Map<String, String> patterns, String language, DateTime at) {
  try {
    return DateFormat(patterns[language], language).format(at);
  } on Exception {
    return DateFormat(patterns['en']).format(at);
  }
}

/// "Apr 12, 1992" (web `formatDate`); date fields use it too (your answer,
/// Part 8).
String formatMediumDate(DateTime date, String locale) =>
    _format(_mediumDate, _language(locale), date);

/// "9:41 AM".
String formatShortTime(DateTime time, String locale) =>
    _format(_shortTime, _language(locale), time);

/// "Oct 21, 2026, 6:54 PM" (web `formatDateTime`).
String formatDateTime(DateTime moment, String locale) =>
    '${formatMediumDate(moment, locale)}, ${formatShortTime(moment, locale)}';

/// "08/2026" (web `formatFieldValue` for a month field).
String formatFieldMonth(int year, int month, String locale) =>
    _format(_month, _language(locale), DateTime(year, month));
