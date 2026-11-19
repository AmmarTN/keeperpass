import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/utils/text/collation.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// Which part of the vault the item list shows (web
/// `features/items/item-filter.ts`).
class ItemFilter {
  const ItemFilter({
    this.vaultId,
    this.tag,
    this.favourites = false,
    this.recent = false,
    this.report,
    this.search = '',
  });

  final String? vaultId;
  final String? tag;
  final bool favourites;
  final bool recent;
  final AuditType? report;
  final String search;

  /// No narrowing: the list shows every vault.
  bool get isUnfiltered =>
      vaultId == null &&
      tag == null &&
      report == null &&
      !favourites &&
      !recent;
}

/// What the filter needs from outside the items.
class ItemFilterContext {
  const ItemFilterContext({
    required this.favouriteIds,
    required this.recentIds,
    required this.hasFinding,
  });

  final Set<String> favouriteIds;

  /// Ids opened recently, most recent first.
  final List<String> recentIds;

  /// Whether an item carries a finding (findings live in the audit, not in
  /// the vault).
  final bool Function(String itemId, AuditType type) hasFinding;
}

/// Every word of the query must appear somewhere in the item — name, tags,
/// field names or values — in any order.
bool _matchesSearch(VaultItem item, String search) {
  final List<String> words = search
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((String w) => w.isNotEmpty)
      .toList();
  if (words.isEmpty) return true;
  final String haystack = <String>[
    item.name,
    ...item.tags,
    for (final Field field in item.fields) ...<String>[field.name, field.value],
  ].join(' ').toLowerCase();
  return words.every(haystack.contains);
}

bool _matchesFilter(
  VaultItem item,
  ItemFilter filter,
  ItemFilterContext context,
) {
  if (filter.vaultId != null && item.vaultId != filter.vaultId) return false;
  if (filter.tag != null && !item.tags.contains(filter.tag)) return false;
  if (filter.favourites && !context.favouriteIds.contains(item.id)) {
    return false;
  }
  if (filter.recent && !context.recentIds.contains(item.id)) return false;
  if (filter.report != null && !context.hasFinding(item.id, filter.report!)) {
    return false;
  }
  return true;
}

/// Name first, then oldest first, then id — a total order, so the list never
/// reshuffles between two renders.
int compareItemsByNameThenAge(VaultItem a, VaultItem b) {
  final int byName = compareNames(a.name, b.name);
  if (byName != 0) return byName;
  final int byAge = a.createdOrUpdated - b.createdOrUpdated;
  if (byAge != 0) return byAge;
  return compareNames(a.id, b.id);
}

/// The items to show, in order. A search replaces the tag, favourites,
/// recent and report filters but stays inside the selected vault. Sorted by
/// name — except "Recently Used", where the order is the point.
List<VaultItem> filterItems(
  List<VaultItem> items,
  ItemFilter filter,
  ItemFilterContext context,
) {
  final List<VaultItem> matches = filter.search.isNotEmpty
      ? items
            .where(
              (VaultItem item) =>
                  (filter.vaultId == null || item.vaultId == filter.vaultId) &&
                  _matchesSearch(item, filter.search),
            )
            .toList()
      : items
            .where((VaultItem item) => _matchesFilter(item, filter, context))
            .toList();

  if (filter.search.isEmpty && filter.recent) {
    final Map<String, int> rank = <String, int>{
      for (int i = 0; i < context.recentIds.length; i++)
        context.recentIds[i]: i,
    };
    int rankOf(VaultItem item) => rank[item.id] ?? 0x7fffffffffffffff;
    return matches..sort((VaultItem a, VaultItem b) {
      final int byRank = rankOf(a).compareTo(rankOf(b));
      return byRank != 0 ? byRank : compareItemsByNameThenAge(a, b);
    });
  }
  return matches..sort(compareItemsByNameThenAge);
}
