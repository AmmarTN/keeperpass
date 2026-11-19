import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';

import '../../../helpers/design_size.dart';

/// test/fixtures/design_tokens.json holds the CSS variables of the canvas's
/// shared stylesheet (C1-Buttons-fields `<helmet>`, .kp-light / .kp-dark), the
/// plan's token source of truth.
const List<String> _shadowNames = <String>[
  'shadow-xs',
  'shadow-float',
  'lift',
  'dock-shadow',
  'focus',
  'error',
];

Map<String, dynamic> _fixture() =>
    jsonDecode(File('test/fixtures/design_tokens.json').readAsStringSync())
        as Map<String, dynamic>;

/// `#RRGGBB` or `rgb(r g b / a%)`, the two forms the stylesheet uses.
Color _cssColor(String value) {
  final RegExpMatch? hex = RegExp(r'^#([0-9a-fA-F]{6})$').firstMatch(value);
  if (hex != null) return Color(int.parse('FF${hex[1]}', radix: 16));

  final RegExpMatch? rgb = RegExp(
    r'^rgb\((\d+) (\d+) (\d+) / (\d+(?:\.\d+)?)%\)$',
  ).firstMatch(value);
  if (rgb == null) throw FormatException('unsupported colour', value);
  return Color.from(
    alpha: double.parse(rgb[4]!) / 100,
    red: int.parse(rgb[1]!) / 255,
    green: int.parse(rgb[2]!) / 255,
    blue: int.parse(rgb[3]!) / 255,
  );
}

/// One CSS box-shadow at scale 1; [blur] is the CSS blur, not Flutter's.
typedef _CssShadow = ({Offset offset, double blur, double spread, Color color});

/// A CSS box-shadow list (`x y blur [spread] colour, …`).
List<_CssShadow> _cssShadows(String value) {
  return value.split(RegExp(r',(?![^(]*\))')).map((String part) {
    final RegExpMatch? m = RegExp(
      r'^(-?[\d.]+)(?:px)? (-?[\d.]+)(?:px)? (-?[\d.]+)(?:px)?(?: (-?[\d.]+)(?:px)?)? (.+)$',
    ).firstMatch(part.trim());
    if (m == null) throw FormatException('unsupported shadow', part);
    return (
      offset: Offset(double.parse(m[1]!), double.parse(m[2]!)),
      blur: double.parse(m[3]!),
      spread: double.parse(m[4] ?? '0'),
      color: _cssColor(m[5]!),
    );
  }).toList();
}

void main() {
  final Map<String, dynamic> fixture = _fixture();

  for (final (String theme, AppColors colors) in <(String, AppColors)>[
    ('light', AppColors.light),
    ('dark', AppColors.dark),
  ]) {
    test('$theme colours match the stylesheet, token for token', () {
      final Map<String, dynamic> css = fixture[theme] as Map<String, dynamic>;
      final Map<String, Color> expected = <String, Color>{
        for (final MapEntry<String, dynamic> e in css.entries)
          if (!_shadowNames.contains(e.key))
            e.key: _cssColor(e.value as String),
      };

      expect(colors.tokens.keys.toSet(), expected.keys.toSet());
      for (final MapEntry<String, Color> e in expected.entries) {
        expect(colors.tokens[e.key], e.value, reason: '--${e.key}');
      }
    });
  }

  for (final (String theme, AppShadows shadows) in <(String, AppShadows)>[
    ('light', AppShadows.light),
    ('dark', AppShadows.dark),
  ]) {
    testWidgets('$theme shadows match the stylesheet at the design size', (
      WidgetTester tester,
    ) async {
      await designContext(tester);
      final Map<String, dynamic> css = fixture[theme] as Map<String, dynamic>;

      expect(shadows.tokens.keys.toList(), _shadowNames);
      for (final String name in _shadowNames) {
        final List<BoxShadow> actual = shadows.tokens[name]!;
        final List<_CssShadow> expected = _cssShadows(css[name] as String);
        expect(actual, hasLength(expected.length), reason: '--$name');
        for (int i = 0; i < expected.length; i++) {
          final String reason = '--$name #$i';
          expect(actual[i].offset, expected[i].offset, reason: reason);
          expect(actual[i].spreadRadius, expected[i].spread, reason: reason);
          expect(actual[i].color, expected[i].color, reason: reason);
          // As soft as in a browser: CSS blurs with σ = blur / 2 (O8).
          expect(
            actual[i].blurSigma,
            closeTo(expected[i].blur / 2, 1e-9),
            reason: reason,
          );
        }
      }
    });
  }

  test('a CSS blur of 1 or less is a hard edge', () {
    expect(AppShadows.cssBlurToBlurRadius(0), 0);
    expect(AppShadows.cssBlurToBlurRadius(1), 0);
  });

  testWidgets('context.colors and context.shadows follow the theme', (
    WidgetTester tester,
  ) async {
    BuildContext context = await designContext(tester);
    expect(context.colors, AppColors.light);
    expect(context.shadows, AppShadows.light);

    context = await designContext(tester, brightness: Brightness.dark);
    expect(context.colors, AppColors.dark);
    expect(context.shadows, AppShadows.dark);
  });
}
