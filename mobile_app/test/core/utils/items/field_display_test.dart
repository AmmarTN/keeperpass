import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/field_display.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';

Field f(FieldType type, String value, {bool? secret}) =>
    Field.of(name: 'F', type: type, value: value, secret: secret);

void main() {
  setUpAll(initializeDateFormatting);

  group('fieldDisplayValue', () {
    test('hidden secrets are dots, line breaks kept (web maskValue)', () {
      expect(
        fieldDisplayValue(
          f(FieldType.password, 'ab\ncd'),
          hidden: true,
          locale: 'en',
        ),
        '••\n••',
      );
      expect(
        fieldDisplayValue(
          f(FieldType.password, 'abc'),
          hidden: false,
          locale: 'en',
        ),
        'abc',
      );
      // A field marked secret is masked whatever its type.
      expect(
        fieldDisplayValue(
          f(FieldType.text, 'note', secret: true),
          hidden: true,
          locale: 'en',
        ),
        '••••',
      );
    });

    test('card numbers in their groups, masked group by group', () {
      final Field visa = f(FieldType.credit, '4111111111111111');
      expect(
        fieldDisplayValue(visa, hidden: true, locale: 'en'),
        '•••• •••• •••• ••••',
      );
      expect(
        fieldDisplayValue(visa, hidden: false, locale: 'en'),
        '4111 1111 1111 1111',
      );
      expect(
        fieldDisplayValue(
          f(FieldType.credit, '378282246310005'),
          hidden: false,
          locale: 'en',
        ),
        '3782 822463 10005',
      );
      // Not a number: masked as typed.
      expect(
        fieldDisplayValue(
          f(FieldType.credit, 'ask Jane'),
          hidden: true,
          locale: 'en',
        ),
        '••••••••',
      );
    });

    test('dates as the medium date, months as the web, bad ones as typed', () {
      expect(
        fieldDisplayValue(
          f(FieldType.date, '1992-04-12'),
          hidden: false,
          locale: 'en',
        ),
        'Apr 12, 1992',
      );
      expect(
        fieldDisplayValue(
          f(FieldType.date, '1992-04-12'),
          hidden: false,
          locale: 'de',
        ),
        '12.04.1992',
      );
      expect(
        fieldDisplayValue(
          f(FieldType.month, '2029-08'),
          hidden: false,
          locale: 'en',
        ),
        '08/2029',
      );
      expect(
        fieldDisplayValue(
          f(FieldType.date, '2026-02-30'),
          hidden: false,
          locale: 'en',
        ),
        '2026-02-30',
      );
    });

    test('a valid IBAN in fours; anything else as typed', () {
      expect(
        fieldDisplayValue(
          f(FieldType.text, 'DE89370400440532013000'),
          hidden: false,
          locale: 'en',
        ),
        'DE89 3704 0044 0532 0130 00',
      );
      expect(
        fieldDisplayValue(
          f(FieldType.text, 'DE89370400440532013001'),
          hidden: false,
          locale: 'en',
        ),
        'DE89370400440532013001',
      );
    });
  });

  test('IBAN check digits (ISO 13616)', () {
    expect(isValidIban('DE89 3704 0044 0532 0130 00'), isTrue);
    expect(isValidIban('GB82WEST12345698765432'), isTrue);
    expect(isValidIban('gb82west12345698765432'), isTrue);
    expect(isValidIban('GB82WEST12345698765431'), isFalse);
    expect(isValidIban('COBADEFFXXX'), isFalse);
    expect(isValidIban(''), isFalse);
  });

  test('copy: an IBAN without its spaces, everything else as stored', () {
    expect(
      fieldCopyValue(f(FieldType.text, 'DE89 3704 0044 0532 0130 00')),
      'DE89370400440532013000',
    );
    expect(
      fieldCopyValue(f(FieldType.credit, '4111 1111 1111 1111')),
      '4111 1111 1111 1111',
    );
  });

  test('monospace: secrets, months and IBANs', () {
    expect(fieldIsMonospace(f(FieldType.pin, '1234')), isTrue);
    expect(fieldIsMonospace(f(FieldType.month, '2029-08')), isTrue);
    expect(
      fieldIsMonospace(f(FieldType.text, 'DE89370400440532013000')),
      isTrue,
    );
    expect(fieldIsMonospace(f(FieldType.text, 'COBADEFFXXX')), isFalse);
    expect(fieldIsMonospace(f(FieldType.date, '1992-04-12')), isFalse);
  });

  test('a country named exactly, in the app language', () {
    final Map<String, dynamic> names =
        jsonDecode(File('assets/i18n/country_names.json').readAsStringSync())
            as Map<String, dynamic>;
    expect(countryNamed('United States', 'en', names)?.iso, 'US');
    expect(countryNamed(' united states ', 'en', names)?.iso, 'US');
    expect(countryNamed('Österreich', 'de', names)?.iso, 'AT');
    expect(countryNamed('Portland, Oregon', 'en', names), isNull);
    expect(countryNamed('', 'en', names), isNull);
  });

  test('large type: revealed one-line secrets only', () {
    expect(canShowLargeType(f(FieldType.password, 'pw')), isTrue);
    expect(canShowLargeType(f(FieldType.credit, '4111')), isTrue);
    expect(canShowLargeType(f(FieldType.text, 'x', secret: true)), isTrue);
    expect(canShowLargeType(f(FieldType.password, '')), isFalse);
    expect(canShowLargeType(f(FieldType.sshKey, 'a\nb')), isFalse);
    expect(canShowLargeType(f(FieldType.username, 'jane')), isFalse);
  });

  test('recovery codes: one per non-blank line', () {
    expect(recoveryCodeLines(' a \n\nb\n  '), <String>['a', 'b']);
  });

  test('links: websites get https, phones their digits', () {
    expect(websiteUri('github.com').toString(), 'https://github.com');
    expect(websiteUri('http://x.test/a').toString(), 'http://x.test/a');
    expect(websiteUri('  '), isNull);
    expect(websiteHost('https://github.com/login'), 'github.com');
    expect(websiteHost('github.com'), 'github.com');
    expect(phoneUri('tel', '+1 503-555-0142').toString(), 'tel:+15035550142');
    expect(phoneUri('sms', '0170 123').toString(), 'sms:0170123');
    expect(phoneUri('tel', 'call me'), isNull);
  });
}
