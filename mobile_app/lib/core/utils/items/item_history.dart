import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/history_entry.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';

/// Applies a change to an item's name, fields and/or tags (web
/// `VaultStore.withHistorySnapshot`): its state before the change goes to
/// the front of its history, the oldest version past [kItemHistoryLimit]
/// drops off, and `updated` becomes [now].
VaultItem withHistorySnapshot(
  VaultItem item, {
  required DateTime now,
  String? name,
  List<Field>? fields,
  List<String>? tags,
}) {
  final HistoryEntry snapshot = HistoryEntry(
    updated: item.updated,
    name: item.name,
    fields: List<Field>.of(item.fields),
    tags: List<String>.of(item.tags),
  );
  return item.copyWith(
    name: name ?? item.name,
    fields: fields ?? item.fields,
    tags: tags ?? item.tags,
    updated: now.toUtc(),
    history: <HistoryEntry>[
      snapshot,
      ...item.history,
    ].take(kItemHistoryLimit).toList(),
  );
}

/// Makes tag names known in the registry (web `registerTags`): trimmed,
/// blank and already-known names skipped, new ones dated [now].
List<TagRegistryEntry> registerTags(
  List<TagRegistryEntry> registry,
  Iterable<String> names,
  DateTime now,
) {
  final Set<String> known = <String>{
    for (final TagRegistryEntry entry in registry) entry.name,
  };
  final List<String> missing = <String>{
    for (final String name in names)
      if (name.trim().isNotEmpty) name.trim(),
  }.where((String name) => !known.contains(name)).toList();
  if (missing.isEmpty) return registry;
  return <TagRegistryEntry>[
    ...registry,
    for (final String name in missing)
      TagRegistryEntry(name: name, created: now.toUtc()),
  ];
}

/// Whether the field an earlier version had at [index] is different now —
/// gone, renamed or holding another value. Fields are paired by position,
/// as the web's history view does (fields have no identity of their own).
bool historyFieldChanged(List<Field> current, List<Field> earlier, int index) {
  if (index >= current.length) return true;
  final Field now = current[index];
  final Field then = earlier[index];
  return now.name != then.name || now.value != then.value;
}
