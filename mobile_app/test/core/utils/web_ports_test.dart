import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/generator/generator.dart';
import 'package:keeperpass/core/utils/import_export/csv.dart';
import 'package:keeperpass/core/utils/text/country_codes.dart';
import 'package:keeperpass/core/utils/text/field_dates.dart';
import 'package:keeperpass/core/utils/text/relative_time.dart';
import 'package:keeperpass/core/utils/validation/card_number.dart';
import 'package:keeperpass/core/utils/validation/email.dart';
import 'package:keeperpass/core/utils/validation/password_strength.dart';
import 'package:keeperpass/core/utils/validation/text_safety.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// Vectors from the web's own TypeScript (each fixture names its source).
Map<String, dynamic> _fixture(String name) =>
    jsonDecode(File('test/fixtures/$name.json').readAsStringSync())
        as Map<String, dynamic>;

List<Map<String, dynamic>> _list(Map<String, dynamic> json, String key) =>
    (json[key] as List<dynamic>).cast<Map<String, dynamic>>();

List<List<String>> _rows(Object? json) => <List<String>>[
  for (final Object? row in json! as List<dynamic>)
    (row! as List<dynamic>).cast<String>(),
];

/// Replays the exact bytes the web drew, and checks none are left over.
class _Tape {
  _Tape(String hex)
    : _bytes = <int>[
        for (int i = 0; i < hex.length; i += 2)
          int.parse(hex.substring(i, i + 2), radix: 16),
      ];

  final List<int> _bytes;
  int _at = 0;

  Uint8List call(int length) {
    final Uint8List out = Uint8List.fromList(_bytes.sublist(_at, _at + length));
    _at += length;
    return out;
  }

  bool get consumed => _at == _bytes.length;
}

void main() {
  group('validation (core/validation)', () {
    final Map<String, dynamic> fixture = _fixture('validation');

    test('password strength: score and entropy', () {
      for (final Map<String, dynamic> c in _list(fixture, 'strength')) {
        final PasswordStrength s = estimatePasswordStrength(
          c['password'] as String,
        );
        expect(s.score, c['score'], reason: jsonEncode(c['password']));
        expect(
          s.entropy,
          closeTo((c['entropy'] as num).toDouble(), 1e-9),
          reason: jsonEncode(c['password']),
        );
      }
    });

    test('card numbers: brand, completeness, Luhn, grouping', () {
      for (final Map<String, dynamic> c in _list(fixture, 'cards')) {
        final CardNumberInfo info = inspectCardNumber(c['value'] as String);
        expect(
          <Object?>[
            info.digits,
            info.brand?.id,
            info.complete,
            info.valid,
            info.formatted,
          ],
          <Object?>[
            c['digits'],
            c['brand'],
            c['complete'],
            c['valid'],
            c['formatted'],
          ],
          reason: c['value'] as String,
        );
        expect(
          passesLuhn(info.digits),
          c['luhn'],
          reason: c['value'] as String,
        );
      }
    });

    test('emails', () {
      for (final Map<String, dynamic> c in _list(fixture, 'emails')) {
        expect(normalizeEmail(c['value'] as String), c['normalized']);
        expect(
          isValidEmail(c['value'] as String),
          c['valid'],
          reason: jsonEncode(c['value']),
        );
      }
    });

    test('text safety', () {
      for (final Map<String, dynamic> c in _list(fixture, 'safety')) {
        final String v = c['value'] as String;
        expect(
          <Object>[
            hasControlCharacters(v),
            hasBidiControl(v),
            hasInvisibleCharacters(v),
            hasLineBreak(v),
            isDisplaySafe(v),
            stripUnsafeCharacters(v),
          ],
          <Object?>[
            c['control'],
            c['bidi'],
            c['invisible'],
            c['lineBreak'],
            c['safe'],
            c['stripped'],
          ],
          reason: jsonEncode(v),
        );
      }
    });
  });

  group(
    'generator (core/generator/generator.ts), same bytes in, same output',
    () {
      final Map<String, dynamic> fixture = _fixture('generator');

      test('alphabets', () {
        final Map<String, dynamic> a =
            fixture['alphabets'] as Map<String, dynamic>;
        expect(
          <String>[
            GeneratorAlphabets.digits,
            GeneratorAlphabets.lowercase,
            GeneratorAlphabets.uppercase,
            GeneratorAlphabets.symbols,
          ],
          <Object?>[a['digits'], a['lowercase'], a['uppercase'], a['symbols']],
        );
      });

      test('random strings', () {
        for (final Map<String, dynamic> c in _list(fixture, 'strings')) {
          final _Tape tape = _Tape(c['tape'] as String);
          expect(
            randomString(
              c['length'] as int,
              c['alphabet'] as String,
              random: tape.call,
            ),
            c['value'],
            reason: '${c['label']} ${c['length']}',
          );
          expect(tape.consumed, isTrue);
        }
      });

      test('random integers', () {
        for (final Map<String, dynamic> c in _list(fixture, 'ints')) {
          final _Tape tape = _Tape(c['tape'] as String);
          expect(
            randomInt(c['min'] as int, c['max'] as int, random: tape.call),
            c['value'],
          );
          expect(tape.consumed, isTrue);
        }
      });

      test(
        'passphrases, with the English fallback for an unknown language',
        () {
          for (final Map<String, dynamic> c in _list(fixture, 'passphrases')) {
            final File list = File('assets/wordlists/${c['language']}.json');
            final List<String> words =
                ((jsonDecode(
                          (list.existsSync()
                                  ? list
                                  : File('assets/wordlists/en.json'))
                              .readAsStringSync(),
                        ))
                        as List<dynamic>)
                    .cast<String>();
            final _Tape tape = _Tape(c['tape'] as String);
            expect(
              generatePassphrase(
                words,
                c['count'] as int,
                c['separator'] as String,
                random: tape.call,
              ),
              c['value'],
            );
            expect(tape.consumed, isTrue);
          }
        },
      );
    },
  );

  group('CSV (core/import-export/csv.ts)', () {
    final Map<String, dynamic> fixture = _fixture('csv');

    test('encode', () {
      final Map<String, dynamic> e = fixture['encode'] as Map<String, dynamic>;
      expect(encodeCsv(_rows(e['rows'])), e['csv']);
    });

    test('parse', () {
      for (final Map<String, dynamic> c in _list(fixture, 'parse')) {
        expect(
          parseCsv(c['text'] as String),
          c['rows'],
          reason: jsonEncode(c['text']),
        );
      }
    });

    test('items to CSV', () {
      final Map<String, dynamic> e =
          fixture['itemsToCsv'] as Map<String, dynamic>;
      final List<VaultItem> items = <VaultItem>[
        for (final Map<String, dynamic> i in _list(e, 'items'))
          VaultItem(
            id: i['name'] as String,
            vaultId: 'v',
            name: i['name'] as String,
            tags: (i['tags'] as List<dynamic>).cast<String>(),
            fields: <Field>[
              for (final Map<String, dynamic> f in _list(i, 'fields'))
                Field.fromJson(f),
            ],
            updated: DateTime.utc(2026),
          ),
      ];
      expect(itemsToCsv(items), e['csv']);
    });

    test('CSV rows to item drafts, and heading types', () {
      for (final Map<String, dynamic> c in _list(fixture, 'drafts')) {
        final List<Map<String, Object>> drafts = <Map<String, Object>>[
          for (final ItemDraft d in csvToItemDrafts(_rows(c['rows'])))
            <String, Object>{
              'name': d.name,
              'tags': d.tags,
              'fields': <Map<String, Object>>[
                for (final Field f in d.fields)
                  <String, Object>{
                    'name': f.name,
                    'type': f.typeValue,
                    'value': f.value,
                  },
              ],
            },
        ];
        expect(drafts, c['drafts']);
      }
      for (final Map<String, dynamic> c in _list(fixture, 'headings')) {
        expect(
          inferFieldType(c['heading'] as String).value,
          c['type'],
          reason: c['heading'] as String,
        );
      }
    });
  });

  test('relative time in five languages (format-date.ts)', () {
    final RelativeTimeFormatter formatter = RelativeTimeFormatter(
      jsonDecode(File('assets/i18n/relative_time.json').readAsStringSync())
          as Map<String, dynamic>,
    );
    for (final Map<String, dynamic> c in _list(
      _fixture('relative_time'),
      'cases',
    )) {
      expect(
        formatter.format(
          DateTime.fromMillisecondsSinceEpoch(c['date'] as int, isUtc: true),
          now: DateTime.fromMillisecondsSinceEpoch(
            c['now'] as int,
            isUtc: true,
          ),
          locale: c['locale'] as String,
        ),
        c['text'],
        reason: '${c['locale']} ${(c['date'] as int) - (c['now'] as int)} ms',
      );
    }
  });

  group('countries (core/models/country-codes.ts)', () {
    final Map<String, dynamic> fixture = _fixture('countries');

    test('the same list, the same guesses from a number', () {
      expect(
        kCountries
            .map(
              (Country c) => <String, String>{
                'iso': c.iso,
                'dial': c.dial,
                'name': c.name,
              },
            )
            .toList(),
        fixture['codes'],
      );
      for (final Map<String, dynamic> c in _list(fixture, 'fromNumber')) {
        expect(
          countryFromNumber(c['value'] as String)?.iso,
          c['iso'],
          reason: c['value'] as String,
        );
      }
      expect(countryByIso('FR')!.flag, '🇫🇷');
    });

    test('names in the app language, English as the fallback', () {
      final Map<String, dynamic> names =
          jsonDecode(File('assets/i18n/country_names.json').readAsStringSync())
              as Map<String, dynamic>;
      final Country de = countryByIso('DE')!;
      expect(countryName(de, 'de', names), 'Deutschland');
      expect(countryName(de, 'fr', names), 'Allemagne');
      expect(countryName(de, 'xx', names), 'Germany');
      for (final String locale in <String>['en', 'de', 'es', 'fr', 'pt']) {
        expect(
          (names[locale] as Map<String, dynamic>).length,
          kCountries.length,
        );
      }
    });
  });

  test('date and month fields read as calendar values (traps 4, O3)', () {
    expect(parseFieldDate('2026-08-15'), DateTime(2026, 8, 15));
    expect(parseFieldDate('2026-02-30'), isNull);
    expect(parseFieldDate('2026-08'), isNull);
    expect(parseFieldMonth('2029-08'), (year: 2029, month: 8));
    expect(parseFieldMonth('2029-13'), isNull);
    expect(fieldDateValue(DateTime(1992, 4, 12)), '1992-04-12');
    expect(fieldMonthValue(2029, 8), '2029-08');
  });
}
