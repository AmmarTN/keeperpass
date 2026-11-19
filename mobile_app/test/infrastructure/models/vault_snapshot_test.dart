import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/infrastructure/models/general/vault_json.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

/// test/fixtures/vault_snapshot.json: a snapshot with fields "from the future"
/// at every level, and what the web's own `VaultStore.hydrate()` →
/// `snapshot()` writes back.
void main() {
  final Map<String, dynamic> fixture =
      jsonDecode(File('test/fixtures/vault_snapshot.json').readAsStringSync())
          as Map<String, dynamic>;
  final Map<String, dynamic> input = fixture['input'] as Map<String, dynamic>;
  final Map<String, dynamic> web =
      fixture['webRoundTrip'] as Map<String, dynamic>;

  test(
    'load → save writes what the web writes, plus the keys the web drops (X9)',
    () {
      final Map<String, dynamic> saved = _json(
        VaultSnapshot.fromJson(_copy(input)).toVaultJson(),
      );

      // The web keeps unknown keys on items, fields, history, vaults,
      // organizations and exports; it drops them at the top level and in tag
      // registry entries. The app keeps them there too.
      final Map<String, dynamic> expected = _copy(web);
      expected['futureTopLevel'] = input['futureTopLevel'];
      final List<dynamic> tags = expected['tagRegistry'] as List<dynamic>;
      (tags.last as Map<String, dynamic>)['futureTagProp'] = 'x';

      expect(saved, expected);
    },
  );

  test('history is trimmed to 5, exports to 10, newest first', () {
    final VaultSnapshot snapshot = VaultSnapshot.fromJson(_copy(input));
    expect(snapshot.items.first.history, hasLength(5));
    expect(snapshot.items.first.history.first.name, 'GitHub v7');
    expect(snapshot.exportHistory, hasLength(kExportHistoryLimit));
  });

  test('an unknown field type survives and reads as text', () {
    final Field future = VaultSnapshot.fromJson(
      _copy(input),
    ).items.first.fields.last;
    expect(future.typeValue, 'future_field_type');
    expect(future.hasKnownType, isFalse);
    expect(future.type, FieldType.text);
    expect(future.toVaultJson()['type'], 'future_field_type');
  });

  test(
    'dates are UTC with milliseconds; legacy registry strings read as entries',
    () {
      final VaultSnapshot snapshot = VaultSnapshot.fromJson(_copy(input));
      expect(
        snapshot.items.first.updated,
        DateTime.utc(2026, 10, 30, 9, 41, 12, 345),
      );
      expect(
        webDateString(DateTime.utc(2026, 1, 2, 3, 4, 5, 6, 789)),
        '2026-01-02T03:04:05.006Z',
      );
      expect(snapshot.tagRegistry.first.name, 'legacy-tag');
      expect(snapshot.tagRegistry.first.created, isNull);
      expect(snapshot.items[1].created, isNull);
      expect(
        snapshot.items[1].createdOrUpdated,
        DateTime.utc(2024, 2, 29, 23, 59, 59, 999).millisecondsSinceEpoch,
      );
    },
  );

  test('a new account’s vault', () {
    final VaultSnapshot empty = VaultSnapshot.empty(
      vaultName: 'My Vault',
      now: DateTime.utc(2026, 10, 30),
    );
    expect(_json(empty.toVaultJson()), <String, Object>{
      'vaults': <Object>[
        <String, Object>{
          'id': kPersonalVaultId,
          'name': 'My Vault',
          'created': '2026-10-30T00:00:00.000Z',
        },
      ],
      'items': <Object>[],
      'organizations': <Object>[],
      'favouriteIds': <Object>[],
      'tagRegistry': <Object>[],
      'exportHistory': <Object>[],
    });
  });

  test(
    'field helpers: secret by type or override, masking keeps line breaks',
    () {
      expect(
        Field.of(name: 'p', type: FieldType.password, value: 'x').isSecret,
        isTrue,
      );
      expect(
        Field.of(
          name: 'p',
          type: FieldType.password,
          value: 'x',
          secret: false,
        ).isSecret,
        isFalse,
      );
      expect(
        Field.of(
          name: 'u',
          type: FieldType.username,
          value: 'x',
          secret: true,
        ).isSecret,
        isTrue,
      );
      expect(maskFieldValue('ab\ncd'), '••\n••');
    },
  );
}

Map<String, dynamic> _copy(Map<String, dynamic> json) =>
    jsonDecode(jsonEncode(json)) as Map<String, dynamic>;

Map<String, dynamic> _json(Map<String, dynamic> json) =>
    jsonDecode(jsonEncode(json)) as Map<String, dynamic>;
