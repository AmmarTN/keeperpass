import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/utils/audit/report.dart';
import 'package:keeperpass/core/utils/items/item_filter.dart';
import 'package:keeperpass/core/utils/items/item_icon.dart';
import 'package:keeperpass/core/utils/items/item_sections.dart';
import 'package:keeperpass/core/utils/items/item_summary.dart';
import 'package:keeperpass/core/utils/items/vault_label.dart';
import 'package:keeperpass/core/utils/text/collation.dart';
import 'package:keeperpass/infrastructure/models/audit/audit_result.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

/// What the scope switcher shows (board `U3-Vault-home` 01, the "Vaults"
/// sheet): everything, a smart scope, or one vault.
enum VaultScope { all, favourites, recent, vault }

/// One row of the list, with everything it draws worked out once.
class VaultRow {
  const VaultRow({
    required this.item,
    required this.vaultLabel,
    required this.favourite,
    required this.findings,
    required this.mainSecret,
    required this.username,
    required this.summary,
    required this.faviconUrls,
  });

  final VaultItem item;

  /// `Organization / Vault`, or the vault's name (web `labelForVault`).
  final String vaultLabel;
  final bool favourite;

  /// The audit's finding types on this item, in the web's order.
  final List<AuditType> findings;
  final MainSecret? mainSecret;
  final Field? username;

  /// The grey line's first part; null when nothing can be shown.
  final String? summary;
  final List<String> faviconUrls;

  String get id => item.id;
}

class VaultTagCount {
  const VaultTagCount(this.name, this.count);

  final String name;
  final int count;
}

/// A group of rows; [kind] is null for search results and Recently Used,
/// which are not grouped by date.
class VaultSectionView {
  const VaultSectionView(this.kind, this.rows);

  final ItemSectionKind? kind;
  final List<VaultRow> rows;
}

/// The list as the screen draws it.
class VaultListView {
  const VaultListView({
    this.rows = const <VaultRow>[],
    this.sections = const <VaultSectionView>[],
    this.favourites = const <VaultRow>[],
    this.tags = const <VaultTagCount>[],
    this.vaults = const <Vault>[],
    this.vaultCounts = const <String, int>{},
    this.total = 0,
    this.favouriteCount = 0,
    this.recentCount = 0,
    this.searchableCount = 0,
    this.reusedPasswords = 0,
  });

  /// Every listed row, in display order.
  final List<VaultRow> rows;
  final List<VaultSectionView> sections;

  /// The Favorites strip: All Vaults with no tag or security filter, and
  /// only when there are any (board `U3-Vault-home` 01).
  final List<VaultRow> favourites;
  final List<VaultTagCount> tags;
  final List<Vault> vaults;

  /// Items per vault id, for the scope and Move sheets.
  final Map<String, int> vaultCounts;
  final int total;
  final int favouriteCount;
  final int recentCount;

  /// How many items a search looks through: the vault's in a vault scope,
  /// otherwise all (web `filterItems`: search stays inside the vault).
  final int searchableCount;

  /// Filtered by Reused passwords: how many different passwords the listed
  /// items share (one: "These 3 share one password", board `S4-19`).
  final int reusedPasswords;
}

/// Works out the list (web `ItemsList`, with the design's groups): the
/// filter decides what is listed (web `filterItems`), then [sort] orders it.
VaultListView buildVaultListView({
  required VaultSnapshot snapshot,
  required VaultScope scope,
  required String? vaultId,
  required String? tag,
  required AuditType? report,
  required String search,
  required ItemSort sort,
  required List<String> recentIds,
  required Map<String, List<AuditResult>> findings,
  required DateTime now,
  required String locale,
}) {
  final List<VaultItem> items = snapshot.items;
  final Set<String> favouriteIds = snapshot.favouriteIds.toSet();
  final Set<String> itemIds = <String>{
    for (final VaultItem item in items) item.id,
  };
  final ItemFilter filter = ItemFilter(
    vaultId: scope == VaultScope.vault ? vaultId : null,
    tag: tag,
    favourites: scope == VaultScope.favourites,
    recent: scope == VaultScope.recent,
    report: report,
    search: search,
  );
  final List<VaultItem> matching = filterItems(
    items,
    filter,
    ItemFilterContext(
      favouriteIds: favouriteIds,
      recentIds: recentIds,
      hasFinding: (String itemId, AuditType type) =>
          findings[itemId]?.any((AuditResult r) => r.type == type) ?? false,
    ),
  );

  final Map<String, VaultRow> rowCache = <String, VaultRow>{};
  VaultRow rowOf(VaultItem item) => rowCache[item.id] ??= buildVaultRow(
    snapshot: snapshot,
    item: item,
    favourite: favouriteIds.contains(item.id),
    findings: findings,
    locale: locale,
  );

  final List<VaultSectionView> sections;
  final List<VaultItem> ordered;
  if (search.isEmpty && scope == VaultScope.recent) {
    // Recently Used keeps recency order and has no sort (board
    // `U3-Vault-empty` 08).
    ordered = matching;
    sections = <VaultSectionView>[
      if (ordered.isNotEmpty)
        VaultSectionView(null, <VaultRow>[
          for (final VaultItem i in ordered) rowOf(i),
        ]),
    ];
  } else {
    ordered = sortItems(matching, sort);
    // A finding's list is one section under its name, in the list's order
    // (board `S4-19`).
    sections = search.isNotEmpty || report != null
        ? <VaultSectionView>[
            if (ordered.isNotEmpty)
              VaultSectionView(null, <VaultRow>[
                for (final VaultItem i in ordered) rowOf(i),
              ]),
          ]
        : <VaultSectionView>[
            for (final ItemSection section in sectionItems(
              ordered,
              sort,
              now: now,
            ))
              VaultSectionView(section.kind, <VaultRow>[
                for (final VaultItem i in section.items) rowOf(i),
              ]),
          ];
  }

  final Map<String, int> vaultCounts = vaultCountsOf(snapshot);

  final bool showFavourites =
      scope == VaultScope.all && tag == null && report == null;
  final List<VaultItem> favouriteItems =
      items.where((VaultItem item) => favouriteIds.contains(item.id)).toList()
        ..sort(compareItemsByNameThenAge);

  return VaultListView(
    rows: <VaultRow>[for (final VaultItem i in ordered) rowOf(i)],
    sections: sections,
    favourites: showFavourites
        ? <VaultRow>[for (final VaultItem i in favouriteItems) rowOf(i)]
        : const <VaultRow>[],
    tags: tagCounts(snapshot),
    vaults: snapshot.vaults,
    vaultCounts: vaultCounts,
    total: items.length,
    favouriteCount: favouriteItems.length,
    recentCount: recentIds.where(itemIds.contains).length,
    searchableCount: scope == VaultScope.vault
        ? (vaultCounts[vaultId] ?? 0)
        : items.length,
    reusedPasswords: report == AuditType.reusedPassword
        ? PasswordUse(items).reusedPasswords(ordered.map((VaultItem i) => i.id))
        : 0,
  );
}

/// Everything a row draws for [item] (also the item screen's header).
VaultRow buildVaultRow({
  required VaultSnapshot snapshot,
  required VaultItem item,
  required bool favourite,
  required Map<String, List<AuditResult>> findings,
  required String locale,
}) => VaultRow(
  item: item,
  vaultLabel: labelForVault(snapshot, item.vaultId),
  favourite: favourite,
  findings: <AuditType>[
    for (final AuditType type in AuditType.values)
      if (findings[item.id]?.any((AuditResult r) => r.type == type) ?? false)
        type,
  ],
  mainSecret: mainSecretOf(item),
  username: usernameFieldOf(item),
  summary: summaryOf(item, locale: locale),
  faviconUrls: itemFaviconUrls(item),
);

/// How many items each vault holds.
Map<String, int> vaultCountsOf(VaultSnapshot snapshot) {
  final Map<String, int> counts = <String, int>{};
  for (final VaultItem item in snapshot.items) {
    counts[item.vaultId] = (counts[item.vaultId] ?? 0) + 1;
  }
  return counts;
}

/// Every known tag with how many items carry it, across all vaults, most
/// used first, then by name; tags registered but not used yet count 0 (web
/// `VaultStore.tags`).
List<VaultTagCount> tagCounts(VaultSnapshot snapshot) {
  final Map<String, int> counts = <String, int>{};
  for (final VaultItem item in snapshot.items) {
    for (final String tag in item.tags) {
      counts[tag] = (counts[tag] ?? 0) + 1;
    }
  }
  final Set<String> names = <String>{
    for (final TagRegistryEntry entry in snapshot.tagRegistry) entry.name,
    ...counts.keys,
  };
  return <VaultTagCount>[
    for (final String name in names) VaultTagCount(name, counts[name] ?? 0),
  ]..sort((VaultTagCount a, VaultTagCount b) {
    final int byCount = b.count.compareTo(a.count);
    return byCount != 0 ? byCount : compareNames(a.name, b.name);
  });
}
