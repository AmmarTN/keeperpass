import 'package:keeperpass/core/utils/text/fold.dart';

/// One icon of the picker's catalogue (web `CatalogIcon`): every icon Font
/// Awesome ships free, with the name, label and search terms
/// fontawesome.com searches. Drawn in the Light face like every item tile
/// (plan O9); the code point is the same in every face.
class CatalogIcon {
  CatalogIcon({
    required this.name,
    required this.label,
    required this.unicode,
    required this.terms,
  }) : _folded = <String>[
         foldText(name),
         foldText(label),
         for (final String term in terms) foldText(term),
       ];

  /// `[name, label, unicode, [terms]]`, as `assets/i18n/icon_catalog.json`
  /// stores them.
  factory CatalogIcon.fromJson(List<dynamic> json) => CatalogIcon(
    name: json[0] as String,
    label: json[1] as String,
    unicode: json[2] as String,
    terms: (json[3] as List<dynamic>).cast<String>(),
  );

  /// Font Awesome's own name, e.g. `lock`.
  final String name;

  /// "Lock" — also what a screen reader says.
  final String label;

  /// The hex code point stored as an item's or field's `iconGlyph`.
  final String unicode;

  /// Aliases, e.g. `padlock` for `lock`.
  final List<String> terms;

  /// Name, label and terms, folded once.
  final List<String> _folded;

  int get codePoint => int.parse(unicode, radix: 16);
}

/// The whole catalogue from the bundled file.
List<CatalogIcon> parseIconCatalog(Map<String, dynamic> json) => <CatalogIcon>[
  for (final Object? icon in json['icons'] as List<dynamic>)
    CatalogIcon.fromJson(icon! as List<dynamic>),
];

/// At most this many results (web `MAX_RESULTS`).
const int kIconSearchLimit = 120;

/// Searches the catalogue as the web does (`searchIconCatalog`): the folded
/// query inside the folded name, label or any term, in catalogue order, at
/// most [kIconSearchLimit]. An empty query gives nothing here — the picker
/// shows the Popular set instead (board `U3-Edit-item`).
List<CatalogIcon> searchIconCatalog(List<CatalogIcon> catalog, String query) {
  final String folded = foldText(query);
  if (folded.isEmpty) return const <CatalogIcon>[];
  final List<CatalogIcon> results = <CatalogIcon>[];
  for (final CatalogIcon icon in catalog) {
    if (icon._folded.any((String text) => text.contains(folded))) {
      results.add(icon);
      if (results.length >= kIconSearchLimit) break;
    }
  }
  return results;
}

/// The picker's "Popular" set before anything is typed (board
/// `U3-Edit-item`): key, padlock, bank, card, Wi-Fi, envelope, phone,
/// laptop, code, cart, house, passport. The board's padlock is Font Awesome
/// Pro's `lock-keyhole`, not in the free catalogue — `lock` stands in.
const List<String> kPopularIconNames = <String>[
  'key',
  'lock',
  'building-columns',
  'credit-card',
  'wifi',
  'envelope',
  'phone',
  'laptop',
  'code',
  'cart-shopping',
  'house',
  'passport',
];

/// The Popular set from [catalog], in the board's order.
List<CatalogIcon> popularIcons(List<CatalogIcon> catalog) {
  final Map<String, CatalogIcon> byName = <String, CatalogIcon>{
    for (final CatalogIcon icon in catalog) icon.name: icon,
  };
  return <CatalogIcon>[
    for (final String name in kPopularIconNames) ?byName[name],
  ];
}
