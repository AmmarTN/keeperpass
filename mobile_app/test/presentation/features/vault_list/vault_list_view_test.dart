import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/utils/items/item_sections.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';

import '../../../helpers/vault_world.dart';

void main() {
  final DateTime now = DateTime(2026, 10, 31, 9, 41);
  final VaultSnapshot snapshot = sampleVault(now);

  VaultListView build({
    VaultScope scope = VaultScope.all,
    String? vaultId,
    String? tag,
    AuditType? report,
    String search = '',
    ItemSort sort = ItemSort.newestFirst,
    List<String> recentIds = const <String>[],
    Map<String, List<AuditResult>> findings =
        const <String, List<AuditResult>>{},
    VaultSnapshot? vault,
  }) => buildVaultListView(
    snapshot: vault ?? snapshot,
    scope: scope,
    vaultId: vaultId,
    tag: tag,
    report: report,
    search: search,
    sort: sort,
    recentIds: recentIds,
    findings: findings,
    now: now,
    locale: 'en',
  );

  List<String> ids(VaultListView view) => <String>[
    for (final VaultRow row in view.rows) row.id,
  ];

  test('All Vaults: newest first, grouped by day, favorites on top', () {
    final VaultListView view = build();
    expect(view.total, 11);
    expect(view.sections.map((VaultSectionView s) => s.kind), <ItemSectionKind>[
      ItemSectionKind.today,
      ItemSectionKind.thisWeek,
      ItemSectionKind.earlier,
    ]);
    expect(ids(view).take(3), <String>['github', 'wifi', 'netflix']);
    expect(view.favourites.map((VaultRow r) => r.id), <String>[
      'github',
      'wifi',
      'paypal',
    ]);
    expect(view.searchableCount, 11);
    expect(view.vaultCounts, <String, int>{
      kWorkVaultId: 4,
      kPersonalVaultId: 7,
    });
  });

  test('a row knows its line, vault, copy and favorite', () {
    final VaultRow github = build().rows.first;
    expect(github.summary, 'janedoe-dev');
    expect(github.vaultLabel, 'Work');
    expect(github.favourite, isTrue);
    expect(github.mainSecret!.field.name, 'Password');
    expect(github.faviconUrls, isNotEmpty);
  });

  test('a tag or a security filter hides the favorites strip', () {
    final VaultListView tagged = build(tag: 'dev');
    expect(ids(tagged), <String>['github', 'slack', 'gitlab', 'docker']);
    expect(tagged.favourites, isEmpty);

    final VaultListView flagged = build(
      report: AuditType.weakPassword,
      findings: <String, List<AuditResult>>{
        'netflix': <AuditResult>[
          const AuditResult(type: AuditType.weakPassword, fieldIndex: 1),
        ],
      },
    );
    expect(ids(flagged), <String>['netflix']);
    expect(flagged.rows.single.findings, <AuditType>[AuditType.weakPassword]);
    expect(flagged.favourites, isEmpty);
  });

  test('a vault: its items, its search count, no strip', () {
    final VaultListView work = build(
      scope: VaultScope.vault,
      vaultId: kWorkVaultId,
    );
    expect(ids(work), <String>['github', 'slack', 'gitlab', 'docker']);
    expect(work.searchableCount, 4);
    expect(work.favourites, isEmpty);
  });

  test('Recently Used keeps recency order, ungrouped', () {
    final VaultListView recent = build(
      scope: VaultScope.recent,
      recentIds: <String>['paypal', 'gone', 'github'],
    );
    expect(ids(recent), <String>['paypal', 'github']);
    expect(recent.sections.single.kind, isNull);
    expect(recent.recentCount, 2);
  });

  test('search: every word, inside the vault, ungrouped', () {
    final VaultListView all = build(search: 'work git');
    expect(ids(all), <String>['github', 'gitlab']);
    expect(all.sections.single.kind, isNull);
    // Search leaves the tag and favorites filters, but not the vault.
    expect(
      ids(build(search: 'jane', tag: 'dev', scope: VaultScope.favourites)),
      hasLength(10),
    );
    expect(
      ids(
        build(search: 'jane', scope: VaultScope.vault, vaultId: kWorkVaultId),
      ),
      <String>['github', 'slack', 'gitlab', 'docker'],
    );
  });

  test('A to Z is one group in name order', () {
    final VaultListView az = build(sort: ItemSort.aToZ);
    expect(az.sections.single.kind, ItemSectionKind.aToZ);
    expect(ids(az).first, 'amazon');
  });

  test('tags: counted over all vaults, most used first, unused show 0', () {
    final VaultListView view = build(
      vault: snapshot.copyWith(
        tagRegistry: <TagRegistryEntry>[const TagRegistryEntry(name: 'travel')],
      ),
    );
    expect(view.tags.map((VaultTagCount t) => '${t.name}:${t.count}'), <String>[
      'dev:4',
      'work:4',
      'social:2',
      'entertainment:1',
      'finance:1',
      'shopping:1',
      'travel:0',
    ]);
  });
}
