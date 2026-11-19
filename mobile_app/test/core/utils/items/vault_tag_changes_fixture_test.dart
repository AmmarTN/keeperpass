import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/items/tag_changes.dart';
import 'package:keeperpass/core/utils/vaults/vault_changes.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

/// Vault and tag changes against `test/fixtures/vaults_tags.json`: the
/// web's own `VaultStore` run in Node with its clock pinned (plan Part 12).
void main() {
  final Map<String, dynamic> fixture =
      jsonDecode(File('test/fixtures/vaults_tags.json').readAsStringSync())
          as Map<String, dynamic>;
  final DateTime now = DateTime.parse(fixture['now'] as String);
  String? iso(DateTime? at) => at?.toUtc().toIso8601String();

  Map<String, dynamic> project(VaultSnapshot s) => <String, dynamic>{
    'vaults': <dynamic>[
      for (final Vault v in s.vaults)
        <String, dynamic>{'id': v.id, 'name': v.name},
    ],
    'items': <dynamic>[
      for (final VaultItem i in s.items)
        <String, dynamic>{
          'id': i.id,
          'vaultId': i.vaultId,
          'tags': i.tags,
          'updated': iso(i.updated),
          'history': i.history.length,
          'historyTags': i.history.firstOrNull?.tags,
          'historyUpdated': iso(i.history.firstOrNull?.updated),
        },
    ],
    'tagRegistry': <dynamic>[
      for (final TagRegistryEntry t in s.tagRegistry)
        <String, dynamic>{'name': t.name, 'created': iso(t.created)},
    ],
    'favouriteIds': s.favouriteIds,
    'tags': <dynamic>[
      for (final TagInfo t in tagInfos(s))
        <String, dynamic>{
          'name': t.name,
          'count': t.count,
          'created': iso(t.created),
        },
    ],
    'ownVaults': <String>[for (final Vault v in ownVaults(s)) v.id],
  };

  for (final Map<String, dynamic> c
      in (fixture['cases'] as List<dynamic>).cast<Map<String, dynamic>>()) {
    test(c['name'], () {
      VaultSnapshot snapshot = VaultSnapshot.fromJson(
        fixture['input'] as Map<String, dynamic>,
      );
      final List<Object?> returns = <Object?>[];
      for (final Map<String, dynamic> op
          in (c['ops'] as List<dynamic>).cast<Map<String, dynamic>>()) {
        final List<dynamic> args = op['args'] as List<dynamic>;
        switch (op['op']) {
          case 'renameVault':
            snapshot = renameVault(
              snapshot,
              args[0] as String,
              args[1] as String,
            );
            returns.add(null);
          case 'deleteVault':
            final VaultSnapshot? after = deleteVault(
              snapshot,
              args[0] as String,
            );
            returns.add(after != null);
            snapshot = after ?? snapshot;
          case 'createTag':
            snapshot = addTag(snapshot, args[0] as String, now);
            returns.add(null);
          case 'renameTag':
            snapshot = renameTag(
              snapshot,
              args[0] as String,
              args[1] as String,
              now,
            );
            returns.add(null);
          case 'deleteTags':
            snapshot = deleteTags(
              snapshot,
              (args[0] as List<dynamic>).cast<String>(),
              now,
            );
            returns.add(null);
        }
      }
      expect(returns, c['returns']);
      expect(project(snapshot), c['result']);
    });
  }
}
