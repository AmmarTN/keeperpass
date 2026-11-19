import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/utils/items/item_filter.dart';
import 'package:keeperpass/core/utils/text/collation.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

Map<String, dynamic> _fixture(String name) =>
    jsonDecode(File('test/fixtures/$name.json').readAsStringSync())
        as Map<String, dynamic>;

void main() {
  test('names sort like the web’s localeCompare (1 580 names)', () {
    final Map<String, dynamic> fixture = _fixture('collation');
    final List<String> names = (fixture['names'] as List<dynamic>)
        .cast<String>();
    final List<String> expected = (fixture['sorted'] as List<dynamic>)
        .cast<String>();
    final List<String> sorted = <String>[...names]..sort(compareNames);
    final List<String> diffs = <String>[
      for (int i = 0; i < sorted.length; i++)
        if (sorted[i] != expected[i]) '$i: ${sorted[i]} ≠ ${expected[i]}',
    ];
    expect(diffs, isEmpty, reason: diffs.take(20).join('\n'));
  });

  test('filters and orders items like item-filter.ts', () {
    final Map<String, dynamic> fixture = _fixture('item_filter');
    final List<VaultItem> items = <VaultItem>[
      for (final Object? json in fixture['items'] as List<dynamic>)
        VaultItem.fromJson(json! as Map<String, dynamic>),
    ];
    final Map<String, dynamic> findings =
        fixture['findings'] as Map<String, dynamic>;
    final ItemFilterContext context = ItemFilterContext(
      favouriteIds: (fixture['favouriteIds'] as List<dynamic>)
          .cast<String>()
          .toSet(),
      recentIds: (fixture['recentIds'] as List<dynamic>).cast<String>(),
      hasFinding: (String id, AuditType type) =>
          id.endsWith(findings['suffix'] as String) &&
          type.value == findings['type'],
    );

    for (final Map<String, dynamic> c
        in (fixture['cases'] as List<dynamic>).cast<Map<String, dynamic>>()) {
      final Map<String, dynamic> f = c['filter'] as Map<String, dynamic>;
      final ItemFilter filter = ItemFilter(
        vaultId: f['vaultId'] as String?,
        tag: f['tag'] as String?,
        favourites: f['favourites'] as bool,
        recent: f['recent'] as bool,
        report: AuditType.tryParse(f['report'] as String?),
        search: f['search'] as String,
      );
      expect(
        filterItems(items, filter, context).map((VaultItem i) => i.id).toList(),
        c['ids'],
        reason: c['label'] as String,
      );
    }
  });
}
