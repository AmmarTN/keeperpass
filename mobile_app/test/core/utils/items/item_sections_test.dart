import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/items/item_sections.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

void main() {
  final DateTime now = DateTime(2026, 10, 31, 9, 41);

  VaultItem item(String name, DateTime updated) =>
      VaultItem(id: name, vaultId: 'v', name: name, updated: updated.toUtc());

  group('date groups (your rule, Part 7)', () {
    test('today, the 6 days before, then earlier', () {
      expect(
        sectionOf(DateTime(2026, 10, 31, 0, 1), now: now),
        ItemSectionKind.today,
      );
      expect(
        sectionOf(DateTime(2026, 10, 30, 23, 59), now: now),
        ItemSectionKind.thisWeek,
      );
      expect(
        sectionOf(DateTime(2026, 10, 25), now: now),
        ItemSectionKind.thisWeek,
      );
      expect(
        sectionOf(DateTime(2026, 10, 24, 23, 59), now: now),
        ItemSectionKind.earlier,
      );
    });

    test('a time ahead of the phone counts as today', () {
      expect(sectionOf(DateTime(2026, 11, 2), now: now), ItemSectionKind.today);
    });
  });

  group('sorting', () {
    final List<VaultItem> byName = <VaultItem>[
      item('Amazon', DateTime(2026, 10, 20)),
      item('GitHub', DateTime(2026, 10, 31, 8)),
      item('Netflix', DateTime(2026, 10, 31, 8)),
      item('Slack', DateTime(2026, 10, 28)),
    ];

    test('newest first is stable: same times keep name order', () {
      expect(
        sortItems(byName, ItemSort.newestFirst).map((VaultItem i) => i.name),
        <String>['GitHub', 'Netflix', 'Slack', 'Amazon'],
      );
      expect(
        sortItems(byName, ItemSort.oldestFirst).map((VaultItem i) => i.name),
        <String>['Amazon', 'Slack', 'GitHub', 'Netflix'],
      );
      expect(sortItems(byName, ItemSort.aToZ), byName);
    });

    test('newest first groups Today, This week, Earlier', () {
      final List<ItemSection> sections = sectionItems(
        sortItems(byName, ItemSort.newestFirst),
        ItemSort.newestFirst,
        now: now,
      );
      expect(sections.map((ItemSection s) => s.kind), <ItemSectionKind>[
        ItemSectionKind.today,
        ItemSectionKind.thisWeek,
        ItemSectionKind.earlier,
      ]);
      expect(sections.first.items.map((VaultItem i) => i.name), <String>[
        'GitHub',
        'Netflix',
      ]);
    });

    test('oldest first shows Earlier, This week, Today', () {
      expect(
        sectionItems(
          sortItems(byName, ItemSort.oldestFirst),
          ItemSort.oldestFirst,
          now: now,
        ).map((ItemSection s) => s.kind),
        <ItemSectionKind>[
          ItemSectionKind.earlier,
          ItemSectionKind.thisWeek,
          ItemSectionKind.today,
        ],
      );
    });

    test('A to Z is one group; nothing listed, no groups', () {
      final List<ItemSection> sections = sectionItems(
        byName,
        ItemSort.aToZ,
        now: now,
      );
      expect(sections.single.kind, ItemSectionKind.aToZ);
      expect(
        sectionItems(const <VaultItem>[], ItemSort.aToZ, now: now),
        isEmpty,
      );
      expect(
        sectionItems(const <VaultItem>[], ItemSort.newestFirst, now: now),
        isEmpty,
      );
    });
  });
}
