import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/icons/icon_catalog.dart';

/// Every code point a TrueType font maps (its `cmap`, formats 4 and 12).
Set<int> fontCodePoints(Uint8List bytes) {
  final ByteData data = ByteData.sublistView(bytes);
  final int tables = data.getUint16(4);
  int cmap = -1;
  for (int i = 0; i < tables; i++) {
    final int record = 12 + i * 16;
    final String tag = String.fromCharCodes(bytes.sublist(record, record + 4));
    if (tag == 'cmap') cmap = data.getUint32(record + 8);
  }
  final Set<int> points = <int>{};
  final int subtables = data.getUint16(cmap + 2);
  for (int i = 0; i < subtables; i++) {
    final int offset = cmap + data.getUint32(cmap + 4 + i * 8 + 4);
    final int format = data.getUint16(offset);
    if (format == 12) {
      final int groups = data.getUint32(offset + 12);
      for (int g = 0; g < groups; g++) {
        final int at = offset + 16 + g * 12;
        final int start = data.getUint32(at);
        final int end = data.getUint32(at + 4);
        for (int c = start; c <= end; c++) {
          points.add(c);
        }
      }
    } else if (format == 4) {
      final int segments = data.getUint16(offset + 6) ~/ 2;
      final int ends = offset + 14;
      final int starts = ends + segments * 2 + 2;
      final int deltas = starts + segments * 2;
      final int ranges = deltas + segments * 2;
      for (int s = 0; s < segments; s++) {
        final int end = data.getUint16(ends + s * 2);
        final int start = data.getUint16(starts + s * 2);
        final int delta = data.getInt16(deltas + s * 2);
        final int rangeOffset = data.getUint16(ranges + s * 2);
        for (int c = start; c <= end && c != 0xffff; c++) {
          final int glyph = rangeOffset == 0
              ? (c + delta) & 0xffff
              : data.getUint16(ranges + s * 2 + rangeOffset + (c - start) * 2);
          if (glyph != 0) points.add(c);
        }
      }
    }
  }
  return points;
}

void main() {
  final List<CatalogIcon> catalog = parseIconCatalog(
    jsonDecode(File('assets/i18n/icon_catalog.json').readAsStringSync())
        as Map<String, dynamic>,
  );

  test('the whole web catalogue (web icon-catalog.ts)', () {
    expect(catalog, hasLength(1402));
    final CatalogIcon lock = catalog.firstWhere(
      (CatalogIcon i) => i.name == 'lock',
    );
    expect(lock.label, 'Lock');
    expect(lock.unicode, 'f023');
    expect(lock.terms, contains('padlock'));
  });

  test('every catalogue icon exists in the Light face (plan O9)', () {
    final Set<int> light = fontCodePoints(
      File('assets/fonts/fontawesome/FontAwesome-Light.ttf').readAsBytesSync(),
    );
    final List<String> missing = <String>[
      for (final CatalogIcon icon in catalog)
        if (!light.contains(icon.codePoint)) icon.name,
    ];
    expect(missing, isEmpty);
  });

  test('search as the web: folded, name, label or term, in order, ≤ 120', () {
    final List<String> bank = <String>[
      for (final CatalogIcon i in searchIconCatalog(catalog, 'bank')) i.name,
    ];
    expect(bank, contains('building-columns'));
    expect(bank, contains('piggy-bank'));
    expect(
      searchIconCatalog(catalog, 'PADLOCK').map((CatalogIcon i) => i.name),
      contains('lock'),
    );
    expect(searchIconCatalog(catalog, 'a'), hasLength(kIconSearchLimit));
    expect(searchIconCatalog(catalog, '  '), isEmpty);
    expect(searchIconCatalog(catalog, 'zzzzqq'), isEmpty);
  });

  test('the board\'s Popular set, in its order', () {
    expect(popularIcons(catalog).map((CatalogIcon i) => i.name), <String>[
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
    ]);
  });
}
