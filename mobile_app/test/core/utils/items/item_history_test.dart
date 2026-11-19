import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/items/item_history.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/history_entry.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';

Field f(String name, String value) =>
    Field.of(name: name, type: FieldType.text, value: value);

void main() {
  final DateTime now = DateTime.utc(2026, 10, 29, 9, 41);

  test('the state before a change goes first; at most five are kept', () {
    VaultItem item = VaultItem(
      id: 'i',
      vaultId: 'v',
      name: 'v0',
      fields: <Field>[f('A', '0')],
      tags: const <String>['t0'],
      updated: DateTime.utc(2026),
      iconGlyph: 'f005',
    );
    for (int i = 1; i <= 8; i++) {
      item = withHistorySnapshot(
        item,
        now: now.add(Duration(minutes: i)),
        name: 'v$i',
        fields: <Field>[f('A', '$i')],
      );
    }
    expect(item.name, 'v8');
    expect(item.updated, now.add(const Duration(minutes: 8)));
    expect(item.iconGlyph, 'f005');
    expect(item.tags, <String>['t0']);
    expect(item.history, hasLength(kItemHistoryLimit));
    expect(
      <String>[for (final HistoryEntry e in item.history) e.name],
      <String>['v7', 'v6', 'v5', 'v4', 'v3'],
    );
    expect(item.history.first.updated, now.add(const Duration(minutes: 7)));
    expect(item.history.first.fields.single.value, '7');
  });

  test('tags are registered once, trimmed, blanks skipped (web)', () {
    final List<TagRegistryEntry> registry = <TagRegistryEntry>[
      const TagRegistryEntry(name: 'work'),
    ];
    final List<TagRegistryEntry> next = registerTags(registry, <String>[
      'work',
      ' dev ',
      '',
      'dev',
    ], now);
    expect(
      <String>[for (final TagRegistryEntry e in next) e.name],
      <String>['work', 'dev'],
    );
    expect(next.last.created, now);
    expect(identical(registerTags(next, <String>['dev'], now), next), isTrue);
  });

  test('changed since: paired by position, name or value (web)', () {
    final List<Field> now = <Field>[f('A', '1'), f('B', '2')];
    final List<Field> then = <Field>[f('A', '1'), f('B', 'x'), f('C', '3')];
    expect(historyFieldChanged(now, then, 0), isFalse);
    expect(historyFieldChanged(now, then, 1), isTrue);
    expect(historyFieldChanged(now, then, 2), isTrue);
    expect(historyFieldChanged(<Field>[f('Z', '1')], then, 0), isTrue);
  });
}
