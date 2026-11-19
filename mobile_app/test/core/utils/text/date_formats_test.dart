import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/utils/text/date_formats.dart';

void main() {
  setUpAll(initializeDateFormatting);

  final Map<String, dynamic> fixture =
      jsonDecode(File('test/fixtures/date_formats.json').readAsStringSync())
          as Map<String, dynamic>;

  test('dates, times and both together exactly as the web (Node Intl)', () {
    final Map<String, dynamic> languages =
        fixture['languages'] as Map<String, dynamic>;
    languages.forEach((String locale, Object? cases) {
      for (final Map<String, dynamic> c
          in (cases! as List<dynamic>).cast<Map<String, dynamic>>()) {
        final DateTime moment = DateTime(
          c['y'] as int,
          c['m'] as int,
          c['d'] as int,
          c['h'] as int,
          c['mi'] as int,
        );
        expect(formatMediumDate(moment, locale), c['date'], reason: locale);
        expect(formatShortTime(moment, locale), c['time'], reason: locale);
        expect(formatDateTime(moment, locale), c['dateTime'], reason: locale);
      }
    });
  });

  test('months as the web shows a month field', () {
    expect(formatFieldMonth(2029, 8, 'en'), '08/2029');
    expect(formatFieldMonth(2029, 8, 'de'), '08.2029');
    expect(formatFieldMonth(2029, 8, 'es'), '8/2029');
    expect(formatFieldMonth(2029, 8, 'fr'), '08/2029');
    expect(formatFieldMonth(2029, 8, 'pt'), '08/2029');
  });

  test('another language falls back to English', () {
    expect(formatMediumDate(DateTime(1992, 4, 12), 'it'), 'Apr 12, 1992');
  });
}
