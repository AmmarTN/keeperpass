import 'package:unorm_dart/unorm_dart.dart' as unorm;

/// Lower-cased and stripped of accents, for matching what someone types
/// against what is stored (web `core/text/fold.ts`). Query side only —
/// nothing folded is ever saved.
String foldText(String value) =>
    jsTrim(unorm.nfd(value).replaceAll(_diacritic, '')).toLowerCase();

final RegExp _diacritic = RegExp(r'\p{Diacritic}', unicode: true);

/// JavaScript's `String.prototype.trim`: Dart's `trim` also strips U+0085
/// (NEL), which JavaScript keeps.
String jsTrim(String value) {
  int start = 0;
  int end = value.length;
  while (start < end && _isJsWhitespace(value.codeUnitAt(start))) {
    start++;
  }
  while (end > start && _isJsWhitespace(value.codeUnitAt(end - 1))) {
    end--;
  }
  return value.substring(start, end);
}

/// ECMAScript WhiteSpace and LineTerminator.
bool _isJsWhitespace(int unit) =>
    (unit >= 0x09 && unit <= 0x0D) ||
    unit == 0x20 ||
    unit == 0xA0 ||
    unit == 0x1680 ||
    (unit >= 0x2000 && unit <= 0x200A) ||
    unit == 0x2028 ||
    unit == 0x2029 ||
    unit == 0x202F ||
    unit == 0x205F ||
    unit == 0x3000 ||
    unit == 0xFEFF;
