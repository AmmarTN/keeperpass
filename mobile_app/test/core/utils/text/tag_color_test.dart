import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/text/tag_color.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';

/// test/fixtures/tag_colors.json is the output of the web's own
/// web/src/app/core/vault/tag-color.ts (bundled with esbuild, run in Node)
/// over plain, accented, non-Latin, emoji, lone-surrogate and generated names.
void main() {
  final Map<String, dynamic> fixture =
      jsonDecode(File('test/fixtures/tag_colors.json').readAsStringSync())
          as Map<String, dynamic>;
  final List<String> palette = (fixture['palette'] as List<dynamic>)
      .cast<String>();
  final List<Map<String, dynamic>> cases = (fixture['cases'] as List<dynamic>)
      .cast<Map<String, dynamic>>();

  test('every name gets the same colour as on the web', () {
    expect(cases, hasLength(greaterThan(400)));
    for (final Map<String, dynamic> c in cases) {
      final String name = c['name'] as String;
      expect(
        tagColorFor(name).index,
        c['index'],
        reason: 'name ${jsonEncode(name)} → ${c['color']}',
      );
    }
  });

  test('the enum is in the web palette order', () {
    expect(TagColor.values, hasLength(palette.length));
  });

  test('dark tag colours are the web palette as it is', () {
    for (final TagColor tag in TagColor.values) {
      final String hex = palette[tag.index].substring(1);
      expect(
        AppColors.dark.tag(tag),
        Color(int.parse('FF$hex', radix: 16)),
        reason: tag.name,
      );
    }
  });
}
