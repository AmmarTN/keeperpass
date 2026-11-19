import 'package:keeperpass/core/utils/text/collation_table.dart';
import 'package:unorm_dart/unorm_dart.dart' as unorm;

/// Compares names the way the web's `localeCompare` sorts them (porting
/// trap 2), without `intl4x` (open item O7): a three-level comparison over a
/// table generated from the same ICU data the browser uses —
///
/// 1. letters, digits and punctuation, ignoring case and accents (ß sorts as
///    "ss", æ as "ae");
/// 2. then accents (plain before accented);
/// 3. then case (lowercase first).
///
/// Latin text, digits and punctuation follow the web exactly; other scripts
/// fall back to code-point order within their script.
int compareNames(String a, String b) {
  if (identical(a, b) || a == b) return 0;
  final _CollationKey ka = _CollationKey.of(a);
  final _CollationKey kb = _CollationKey.of(b);
  return _compareLists(ka.primary, kb.primary) ??
      _compareLists(ka.secondary, kb.secondary) ??
      _compareLists(ka.tertiary, kb.tertiary) ??
      0;
}

/// Weights for characters outside the table: after every table character,
/// in code-point order of their lowercase form.
const int _unknownBase = 0x100000;

/// The accent weight that marks an expanded letter (ß, æ, œ …): above every
/// combining mark.
const int _expansionSecondary = 1000;

class _CollationKey {
  _CollationKey(this.primary, this.secondary, this.tertiary);

  factory _CollationKey.of(String text) {
    final List<int> primary = <int>[];
    final List<int> secondary = <int>[];
    final List<int> tertiary = <int>[];

    for (final int rune in unorm.nfd(text).runes) {
      final int? mark = kCollationMarks[rune];
      if (mark != null) {
        secondary.add(mark);
        continue;
      }
      if (kCollationIgnorable.contains(rune)) continue;

      final String char = String.fromCharCode(rune);
      final int caseWeight = char != char.toLowerCase() ? 1 : 0;
      final String? expansion = kCollationExpansions[rune];
      if (expansion != null) {
        for (int i = 0; i < expansion.length; i++) {
          primary.add(_primary(expansion.codeUnitAt(i)));
          // ICU tells a ligature from its spelled-out letters at the accent
          // level, after every accent: Strasse < STRASSE < Straße.
          secondary.add(i == expansion.length - 1 ? _expansionSecondary : 0);
          tertiary.add(caseWeight);
        }
        continue;
      }
      primary.add(_primary(rune));
      secondary.add(kCollationSecondary[rune] ?? 0);
      tertiary.add(caseWeight);
    }
    return _CollationKey(primary, secondary, tertiary);
  }

  final List<int> primary;
  final List<int> secondary;
  final List<int> tertiary;

  static int _primary(int rune) {
    final int? known = kCollationPrimary[rune];
    if (known != null) return known;
    final int lower = String.fromCharCode(rune).toLowerCase().runes.first;
    return kCollationPrimary[lower] ?? _unknownBase + lower;
  }
}

int? _compareLists(List<int> a, List<int> b) {
  final int n = a.length < b.length ? a.length : b.length;
  for (int i = 0; i < n; i++) {
    if (a[i] != b[i]) return a[i] < b[i] ? -1 : 1;
  }
  if (a.length != b.length) return a.length < b.length ? -1 : 1;
  return null;
}
