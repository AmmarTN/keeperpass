import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/item_codes.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

void main() {
  Field f(FieldType type, String value) =>
      Field.of(name: type.name, type: type, value: value);
  VaultItem item(List<Field> fields) => VaultItem(
    id: 'i',
    vaultId: 'v',
    name: 'Item',
    fields: fields,
    updated: DateTime.utc(2026),
  );

  group('codeFieldOf (your answer, Part 10: one card per item)', () {
    test('the first 2FA field that has a setup key', () {
      final Field first = f(FieldType.totp, 'JBSWY3DPEHPK3PXP');
      final Field second = f(FieldType.totp, 'GEZDGNBVGY3TQOJQ');
      expect(
        codeFieldOf(
          item(<Field>[f(FieldType.username, 'jane'), first, second]),
        ),
        first,
      );
    });

    test('an empty 2FA field is skipped', () {
      final Field keyed = f(FieldType.totp, 'JBSWY3DPEHPK3PXP');
      expect(codeFieldOf(item(<Field>[f(FieldType.totp, ''), keyed])), keyed);
    });

    test('no setup key, no card; an invalid key still has one', () {
      expect(codeFieldOf(item(<Field>[f(FieldType.totp, '')])), isNull);
      expect(codeFieldOf(item(<Field>[f(FieldType.password, 'x')])), isNull);
      expect(
        codeFieldOf(item(<Field>[f(FieldType.totp, 'not a key!')]))?.value,
        'not a key!',
      );
    });
  });

  group('nameMatchesSearch (board Codes 03)', () {
    test('any case, part of a word', () {
      expect(nameMatchesSearch('Cloudflare', 'cloud'), isTrue);
      expect(nameMatchesSearch('Cloudflare', 'FLARE'), isTrue);
      expect(nameMatchesSearch('GitHub', 'cloud'), isFalse);
    });

    test('every word, in any order (web matchesSearch)', () {
      expect(nameMatchesSearch('AWS Console', 'console aws'), isTrue);
      expect(nameMatchesSearch('AWS Console', 'aws  prod'), isFalse);
    });

    test('nothing typed matches everything', () {
      expect(nameMatchesSearch('GitHub', '   '), isTrue);
    });
  });
  group('itemsNamed (Part 15 rule 5)', () {
    VaultItem named(String id, String name) => VaultItem(
      id: id,
      vaultId: 'v',
      name: name,
      fields: const <Field>[],
      updated: DateTime.utc(2026),
    );

    test('the same name, ignoring capitals and spaces at either end', () {
      final List<VaultItem> items = <VaultItem>[
        named('a', 'Dropbox'),
        named('b', ' dropbox '),
        named('c', 'Dropbox Business'),
        named('d', 'DROPBOX'),
      ];
      expect(itemsNamed(items, 'Dropbox').map((VaultItem i) => i.id), <String>[
        'a',
        'b',
        'd',
      ]);
      expect(itemsNamed(items, 'Drop'), isEmpty);
      expect(itemsNamed(items, '  '), isEmpty);
    });
  });

  group('withSetupKey (Part 15 rule 6, your answer: a second 2FA field)', () {
    const String key = 'JBSWY3DPEHPK3PXP';

    test('the first empty 2FA field is filled', () {
      final List<Field> fields = withSetupKey(
        <Field>[
          f(FieldType.username, 'jane'),
          f(FieldType.totp, ''),
          f(FieldType.totp, ''),
        ],
        key,
        name: 'Authenticator Code',
      );
      expect(fields.map((Field x) => x.value), <String>['jane', key, '']);
      expect(fields[1].name, 'totp');
    });

    test('otherwise a new 2FA field at the end, even for the same key', () {
      final List<Field> fields = withSetupKey(
        <Field>[f(FieldType.username, 'jane'), f(FieldType.totp, key)],
        key,
        name: 'Authenticator Code',
      );
      expect(fields, hasLength(3));
      expect(fields.last.type, FieldType.totp);
      expect(fields.last.name, 'Authenticator Code');
      expect(fields.last.value, key);
      expect(fields[1].value, key);
    });
  });
}
