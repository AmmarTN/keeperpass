import 'dart:convert';

import 'package:crypto/crypto.dart';

/// SHA-1 of [value]'s UTF-8 bytes as lower-case hex (web `audit.ts`
/// `sha1Hex`) — the hash the breach check sends the first five characters
/// of. Lone surrogates become U+FFFD, as the web's `TextEncoder` makes them.
String sha1Hex(String value) =>
    sha1.convert(utf8.encode(toWellFormed(value))).toString();

/// [value] with every unpaired surrogate replaced by U+FFFD
/// (`String.prototype.toWellFormed`).
String toWellFormed(String value) {
  final List<int> units = value.codeUnits;
  StringBuffer? out;
  for (int i = 0; i < units.length; i++) {
    final int unit = units[i];
    final bool high = unit >= 0xD800 && unit <= 0xDBFF;
    final bool low = unit >= 0xDC00 && unit <= 0xDFFF;
    final bool paired =
        high &&
        i + 1 < units.length &&
        units[i + 1] >= 0xDC00 &&
        units[i + 1] <= 0xDFFF;
    if ((high && !paired) ||
        (low && !(i > 0 && units[i - 1] >= 0xD800 && units[i - 1] <= 0xDBFF))) {
      out ??= StringBuffer(String.fromCharCodes(units.sublist(0, i)));
      out.write('\uFFFD');
      continue;
    }
    out?.writeCharCode(unit);
    if (paired) {
      out?.writeCharCode(units[i + 1]);
      i++;
    }
  }
  return out?.toString() ?? value;
}
