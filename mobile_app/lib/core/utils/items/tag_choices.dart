import 'package:keeperpass/core/utils/items/field_editing.dart';
import 'package:keeperpass/core/utils/text/fold.dart';

/// What the tag picker offers for [typed] (web `ItemView.tagOptions`,
/// `tagFilter`, `newTagName`): the vault's tags not on the item yet whose
/// folded name contains the folded text, then "Create …" for a name no tag
/// has yet (none while it is too long).
({List<String> existing, String? create}) tagChoices({
  required List<String> known,
  required List<String> onItem,
  required String typed,
}) {
  final String query = foldText(typed);
  final Set<String> taken = onItem.toSet();
  final List<String> existing = <String>[
    for (final String tag in known)
      if (!taken.contains(tag) && foldText(tag).contains(query)) tag,
  ];
  final String name = typed.trim();
  final bool isKnown = <String>[
    ...known,
    ...onItem,
  ].any((String tag) => foldText(tag) == foldText(name));
  return (
    existing: existing,
    create: name.isEmpty || !tagNameValid(name) || isKnown ? null : name,
  );
}
