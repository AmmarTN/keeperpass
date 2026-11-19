import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';

import '../../../helpers/design_size.dart';

void main() {
  test('stroke follows size (Iconography board)', () {
    expect(AppIconSizes.strokeFor(AppIconSizes.xs), 2.25);
    expect(AppIconSizes.strokeFor(AppIconSizes.sm), 2);
    expect(AppIconSizes.strokeFor(AppIconSizes.md), 1.75);
    expect(AppIconSizes.strokeFor(AppIconSizes.lg), 1.75);
  });

  test('design strokes round down to the package weights', () {
    const AppIconName icon = AppIconName.copy;
    expect(icon.forStroke(1.5), icon.w300);
    expect(icon.forStroke(1.75), icon.w300);
    expect(icon.forStroke(2), icon.w400);
    expect(icon.forStroke(2.25), icon.w400);
    expect(icon.forStroke(2.5), icon.w500);
    expect(icon.forStroke(2.75), icon.w500);
    expect(icon.forStroke(3), icon.w600);
  });

  testWidgets('AppIcon draws the weight for its size', (
    WidgetTester tester,
  ) async {
    await pumpAtDesignSize(
      tester,
      const Column(
        children: <Widget>[
          AppIcon(AppIconName.search, size: AppIconSizes.xs),
          AppIcon(AppIconName.search),
        ],
      ),
    );
    final List<Icon> icons = tester
        .widgetList<Icon>(find.byType(Icon))
        .toList();
    expect(icons[0].icon, AppIconName.search.w400);
    expect(icons[0].size, AppIconSizes.xs);
    expect(icons[1].icon, AppIconName.search.w300);
    expect(icons[1].size, AppIconSizes.lg);
  });

  testWidgets('FaGlyph draws the code point as text in Font Awesome', (
    WidgetTester tester,
  ) async {
    await pumpAtDesignSize(
      tester,
      Column(
        children: <Widget>[
          const FaGlyph(FaGlyphs.tag, semanticLabel: 'Tag'),
          FaGlyph.hex('f005', weight: FaWeight.solid),
        ],
      ),
    );
    final List<Text> glyphs = tester
        .widgetList<Text>(find.byType(Text))
        .toList();

    expect(glyphs[0].data, String.fromCharCode(0xf02b));
    expect(glyphs[0].style!.fontFamily, FaGlyph.fontFamily);
    expect(glyphs[0].style!.fontWeight, FontWeight.w300);
    expect(glyphs[0].textScaler, TextScaler.noScaling);
    expect(find.bySemanticsLabel('Tag'), findsOneWidget);

    expect(glyphs[1].data, String.fromCharCode(0xf005));
    expect(glyphs[1].style!.fontWeight, FontWeight.w900);
  });
}
