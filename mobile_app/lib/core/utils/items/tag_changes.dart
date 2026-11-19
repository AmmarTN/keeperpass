import 'package:keeperpass/core/utils/items/item_history.dart';
import 'package:keeperpass/core/utils/text/collation.dart';
import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

/// A known tag (web `TagInfo`): on an item, registered, or both.
class TagInfo {
  const TagInfo({required this.name, required this.count, this.created});

  final String name;

  /// Items carrying it; 0 for a tag only registered.
  final int count;

  /// When it was registered, else when the first item carrying it was
  /// created; null when neither is known.
  final DateTime? created;
}

/// Every known tag, most used first, then by name (web `VaultStore.tags`).
List<TagInfo> tagInfos(VaultSnapshot snapshot) {
  final Map<String, int> counts = <String, int>{};
  final Map<String, DateTime> firstUsed = <String, DateTime>{};
  for (final VaultItem item in snapshot.items) {
    for (final String tag in item.tags) {
      counts[tag] = (counts[tag] ?? 0) + 1;
      final DateTime? created = item.created;
      if (created == null) continue;
      final DateTime? earliest = firstUsed[tag];
      if (earliest == null || created.isBefore(earliest)) {
        firstUsed[tag] = created;
      }
    }
  }
  final Map<String, DateTime?> registered = <String, DateTime?>{
    for (final TagRegistryEntry entry in snapshot.tagRegistry)
      entry.name: entry.created,
  };
  return <TagInfo>[
    for (final String name in <String>{...registered.keys, ...counts.keys})
      TagInfo(
        name: name,
        count: counts[name] ?? 0,
        created: registered[name] ?? firstUsed[name],
      ),
  ]..sort((TagInfo a, TagInfo b) {
    final int byCount = b.count.compareTo(a.count);
    return byCount != 0 ? byCount : compareNames(a.name, b.name);
  });
}

/// Registers a tag ahead of use (web `createTag`): blank and known names
/// change nothing.
VaultSnapshot addTag(VaultSnapshot snapshot, String name, DateTime now) =>
    snapshot.copyWith(
      tagRegistry: registerTags(snapshot.tagRegistry, <String>[name], now),
    );

/// Renames a tag on every item and in the registry (web `renameTag`): each
/// item changed keeps its earlier version in history; an item that already
/// has [newName] keeps it once (a merge). The registry keeps the renamed
/// tag's date, or, merging, the date of the tag that stays. A blank or
/// unchanged name changes nothing.
VaultSnapshot renameTag(
  VaultSnapshot snapshot,
  String oldName,
  String newName,
  DateTime now,
) {
  final String trimmed = jsTrim(newName);
  if (trimmed.isEmpty || trimmed == oldName) return snapshot;

  final List<TagRegistryEntry> withoutOld = <TagRegistryEntry>[
    for (final TagRegistryEntry entry in snapshot.tagRegistry)
      if (entry.name != oldName) entry,
  ];
  final DateTime? renamedDate = snapshot.tagRegistry
      .where((TagRegistryEntry entry) => entry.name == oldName)
      .firstOrNull
      ?.created;
  return snapshot.copyWith(
    items: <VaultItem>[
      for (final VaultItem item in snapshot.items)
        if (!item.tags.contains(oldName))
          item
        else
          withHistorySnapshot(
            item,
            now: now,
            tags: <String>[
              for (final String tag in item.tags)
                if (tag != oldName) tag,
              if (!item.tags.contains(trimmed)) trimmed,
            ],
          ),
    ],
    tagRegistry:
        withoutOld.any((TagRegistryEntry entry) => entry.name == trimmed)
        ? withoutOld
        : <TagRegistryEntry>[
            ...withoutOld,
            TagRegistryEntry(name: trimmed, created: renamedDate),
          ],
  );
}

/// Removes tags from every item that carries them and from the registry
/// (web `deleteTags`); each item changed keeps its earlier version in
/// history. The items themselves stay.
VaultSnapshot deleteTags(
  VaultSnapshot snapshot,
  Iterable<String> names,
  DateTime now,
) {
  final Set<String> gone = names.toSet();
  if (gone.isEmpty) return snapshot;
  return snapshot.copyWith(
    items: <VaultItem>[
      for (final VaultItem item in snapshot.items)
        if (!item.tags.any(gone.contains))
          item
        else
          withHistorySnapshot(
            item,
            now: now,
            tags: <String>[
              for (final String tag in item.tags)
                if (!gone.contains(tag)) tag,
            ],
          ),
    ],
    tagRegistry: <TagRegistryEntry>[
      for (final TagRegistryEntry entry in snapshot.tagRegistry)
        if (!gone.contains(entry.name)) entry,
    ],
  );
}
