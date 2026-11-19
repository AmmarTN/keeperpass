import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';

/// The field an item's Codes card makes its code from: its first 2FA field
/// that has a setup key (your answer, Part 10: one card per item). Null when
/// it has none, so the item has no card.
Field? codeFieldOf(VaultItem item) => item.fields
    .where((Field f) => f.type == FieldType.totp && f.value.isNotEmpty)
    .firstOrNull;

/// Whether every word of [search] is in [name], in any order, ignoring case
/// (board `Codes` 03: the search matches item names; the words as the web's
/// `matchesSearch` reads them).
bool nameMatchesSearch(String name, String search) {
  final String haystack = name.toLowerCase();
  return search
      .toLowerCase()
      .split(RegExp(r'\s+'))
      .where((String word) => word.isNotEmpty)
      .every(haystack.contains);
}

/// The items a scanned site name points to (plan, Part 15 rule 5): named
/// the same, ignoring capitals and spaces at either end.
List<VaultItem> itemsNamed(Iterable<VaultItem> items, String site) {
  final String wanted = site.trim().toLowerCase();
  if (wanted.isEmpty) return const <VaultItem>[];
  return <VaultItem>[
    for (final VaultItem item in items)
      if (item.name.trim().toLowerCase() == wanted) item,
  ];
}

/// [fields] with the setup key [key] in (plan, Part 15 rule 6 — your
/// answer: a second 2FA field): the first empty 2FA field filled, else a
/// new 2FA field named [name] at the end, even when one holds [key].
List<Field> withSetupKey(
  List<Field> fields,
  String key, {
  required String name,
}) {
  final int empty = fields.indexWhere(
    (Field f) => f.type == FieldType.totp && f.value.isEmpty,
  );
  if (empty >= 0) {
    return <Field>[
      for (int i = 0; i < fields.length; i++)
        i == empty ? fields[i].copyWith(value: key) : fields[i],
    ];
  }
  return <Field>[
    ...fields,
    Field.of(name: name, type: FieldType.totp, value: key),
  ];
}
