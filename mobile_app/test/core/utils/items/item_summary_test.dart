import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/item_summary.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

VaultItem itemWith(List<Field> fields) => VaultItem(
  id: 'i',
  vaultId: 'v',
  name: 'Item',
  fields: fields,
  updated: DateTime.utc(2026),
);

Field f(String name, FieldType type, String value, {bool? secret}) =>
    Field.of(name: name, type: type, value: value, secret: secret);

void main() {
  setUpAll(initializeDateFormatting);

  group('the copy button (your rule, Part 7)', () {
    test('a password comes first', () {
      final MainSecret? secret = mainSecretOf(
        itemWith(<Field>[
          f('Code', FieldType.totp, 'JBSWY3DP'),
          f('Password', FieldType.password, 'pw'),
        ]),
      );
      expect(secret!.kind, MainSecretKind.password);
      expect(secret.field.value, 'pw');
    });

    test('then the 2FA code, then the card number', () {
      expect(
        mainSecretOf(
          itemWith(<Field>[
            f('Card', FieldType.credit, '4111'),
            f('Code', FieldType.totp, 'JBSWY3DP'),
          ]),
        )!.kind,
        MainSecretKind.code,
      );
      expect(
        mainSecretOf(
          itemWith(<Field>[f('Card', FieldType.credit, '4111')]),
        )!.kind,
        MainSecretKind.cardNumber,
      );
    });

    test('empty fields are skipped; nothing to copy → no button', () {
      expect(
        mainSecretOf(
          itemWith(<Field>[
            f('Password', FieldType.password, ''),
            f('Card', FieldType.credit, '4111'),
          ]),
        )!.kind,
        MainSecretKind.cardNumber,
      );
      expect(
        mainSecretOf(itemWith(<Field>[f('Note', FieldType.note, 'x')])),
        isNull,
      );
    });
  });

  test('the swipe copies the username, else the email', () {
    expect(
      usernameFieldOf(
        itemWith(<Field>[
          f('Email', FieldType.email, 'a@b.c'),
          f('User', FieldType.username, 'jane'),
        ]),
      )!.value,
      'jane',
    );
    expect(
      usernameFieldOf(
        itemWith(<Field>[f('Email', FieldType.email, 'a@b.c')]),
      )!.value,
      'a@b.c',
    );
    expect(usernameFieldOf(itemWith(<Field>[])), isNull);
  });

  group('the grey line', () {
    test('the first filled field that is not hidden', () {
      expect(
        summaryOf(
          itemWith(<Field>[
            f('Password', FieldType.password, 'pw'),
            f('Code', FieldType.totp, 'JBSWY3DP'),
            f('Username', FieldType.username, ''),
            f('Network name', FieldType.text, 'Doe-Home-5G'),
          ]),
          locale: 'en',
        ),
        'Doe-Home-5G',
      );
    });

    test('a field marked secret is hidden; one marked not secret shows', () {
      expect(
        summaryOf(
          itemWith(<Field>[
            f('Hint', FieldType.text, 'hidden', secret: true),
            f('PIN', FieldType.pin, '1234', secret: false),
          ]),
          locale: 'en',
        ),
        '1234',
      );
    });

    test('multi-line values give their first line; dates are formatted', () {
      expect(
        summaryOf(
          itemWith(<Field>[
            f('Note', FieldType.note, '\n  first line\nsecond'),
          ]),
          locale: 'en',
        ),
        'first line',
      );
      expect(
        summaryOf(
          itemWith(<Field>[f('Expiry', FieldType.date, '2026-08-15')]),
          locale: 'en',
        ),
        'Aug 15, 2026',
      );
    });

    test('dates as the web medium date, months as the web (Node Intl)', () {
      const Map<String, (String, String)> web = <String, (String, String)>{
        'en': ('Aug 15, 2026', '08/2026'),
        'de': ('15.08.2026', '08.2026'),
        'es': ('15 ago 2026', '8/2026'),
        'fr': ('15 août 2026', '08/2026'),
        'pt': ('15 de ago. de 2026', '08/2026'),
      };
      web.forEach((String locale, (String, String) expected) {
        expect(
          fieldSummaryText(
            f('Date', FieldType.date, '2026-08-15'),
            locale: locale,
          ),
          expected.$1,
          reason: locale,
        );
        expect(
          fieldSummaryText(
            f('Month', FieldType.month, '2026-08'),
            locale: locale,
          ),
          expected.$2,
          reason: locale,
        );
      });
    });

    test('nothing to show → null', () {
      expect(
        summaryOf(
          itemWith(<Field>[f('Password', FieldType.password, 'pw')]),
          locale: 'en',
        ),
        isNull,
      );
    });
  });
}
