import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// The list's sort menu (board `U3-Vault-home` 02: "Newest first, Oldest
/// first, A to Z"). Newest first is the default, as on the web.
enum ItemSort { newestFirst, oldestFirst, aToZ }

/// The list's groups (design only: the web has one flat list).
enum ItemSectionKind { today, thisWeek, earlier, aToZ }

class ItemSection {
  const ItemSection(this.kind, this.items);

  final ItemSectionKind kind;
  final List<VaultItem> items;
}

/// [items] (already in name order, from `filterItems`) sorted by [sort]:
/// by last update, stably — same-time items keep their name order, as the
/// web's `Array.sort` does.
List<VaultItem> sortItems(List<VaultItem> items, ItemSort sort) {
  if (sort == ItemSort.aToZ) return List<VaultItem>.of(items);
  final int direction = sort == ItemSort.newestFirst ? -1 : 1;
  final List<(int, VaultItem)> indexed = <(int, VaultItem)>[
    for (int i = 0; i < items.length; i++) (i, items[i]),
  ];
  indexed.sort(((int, VaultItem) a, (int, VaultItem) b) {
    final int byTime = a.$2.updated.compareTo(b.$2.updated) * direction;
    return byTime != 0 ? byTime : a.$1.compareTo(b.$1);
  });
  return <VaultItem>[for (final (int, VaultItem) entry in indexed) entry.$2];
}

/// Your rule (Part 7): Today = changed today; This week = the 6 days before;
/// Earlier = older. Oldest first shows Earlier, This week, Today; A to Z is
/// one group. Empty groups are left out. [items] must already be sorted.
List<ItemSection> sectionItems(
  List<VaultItem> items,
  ItemSort sort, {
  required DateTime now,
}) {
  if (sort == ItemSort.aToZ) {
    return items.isEmpty
        ? const <ItemSection>[]
        : <ItemSection>[ItemSection(ItemSectionKind.aToZ, items)];
  }
  final Map<ItemSectionKind, List<VaultItem>> groups =
      <ItemSectionKind, List<VaultItem>>{};
  for (final VaultItem item in items) {
    (groups[sectionOf(item.updated, now: now)] ??= <VaultItem>[]).add(item);
  }
  final List<ItemSectionKind> order = sort == ItemSort.newestFirst
      ? const <ItemSectionKind>[
          ItemSectionKind.today,
          ItemSectionKind.thisWeek,
          ItemSectionKind.earlier,
        ]
      : const <ItemSectionKind>[
          ItemSectionKind.earlier,
          ItemSectionKind.thisWeek,
          ItemSectionKind.today,
        ];
  return <ItemSection>[
    for (final ItemSectionKind kind in order)
      if (groups[kind] != null) ItemSection(kind, groups[kind]!),
  ];
}

/// Which date group [updated] falls in, by the phone's calendar days. A
/// time ahead of the phone's clock counts as today.
ItemSectionKind sectionOf(DateTime updated, {required DateTime now}) {
  final int days = _calendarDay(now) - _calendarDay(updated);
  if (days <= 0) return ItemSectionKind.today;
  if (days <= 6) return ItemSectionKind.thisWeek;
  return ItemSectionKind.earlier;
}

/// Days since the epoch of [time]'s local calendar date (free of daylight
/// saving: counted on UTC midnights).
int _calendarDay(DateTime time) {
  final DateTime local = time.toLocal();
  return DateTime.utc(
        local.year,
        local.month,
        local.day,
      ).millisecondsSinceEpoch ~/
      Duration.millisecondsPerDay;
}
