import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_inset_group.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_section_label.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';

import '../../../helpers/component_harness.dart';

void main() {
  group('AppPressable', () {
    testWidgets(
      'taps, plays its haptic first, and ignores taps when disabled',
      (WidgetTester tester) async {
        final List<String> calls = <String>[];
        await pumpComponent(
          tester,
          Column(
            children: <Widget>[
              AppPressable(
                onTap: () => calls.add('tap'),
                haptic: () async => calls.add('haptic'),
                semanticLabel: 'Enabled',
                child: const SizedBox(width: 80, height: 40),
              ),
              AppPressable(
                onTap: () => calls.add('disabled'),
                enabled: false,
                semanticLabel: 'Disabled',
                child: const SizedBox(width: 80, height: 40),
              ),
            ],
          ),
        );
        await tester.tap(find.bySemanticsLabel('Enabled'));
        await tester.tap(
          find.bySemanticsLabel('Disabled'),
          warnIfMissed: false,
        );
        expect(calls, <String>['haptic', 'tap']);
        expect(tester.widget<Opacity>(find.byType(Opacity)).opacity, 0.5);
      },
    );

    testWidgets('draws the 10 % pressed overlay while held', (
      WidgetTester tester,
    ) async {
      await inBothThemes((Brightness brightness) async {
        await pumpComponent(
          tester,
          AppPressable(
            onTap: () {},
            child: const SizedBox(width: 80, height: 40),
          ),
          brightness: brightness,
        );
        final TestGesture gesture = await tester.startGesture(
          tester.getCenter(find.byType(AppPressable)),
        );
        await tester.pump(const Duration(milliseconds: 200));
        final BuildContext context = tester.element(find.byType(AppPressable));
        expect(
          fillUnder(tester, find.byType(AppPressable)),
          AppFixedColors.pressedOverlay(context),
        );
        await gesture.up();
        await tester.pump();
        expect(fillUnder(tester, find.byType(AppPressable)), isNull);
      });
    });
  });

  testWidgets('AppSurface: ring and the shadow of its elevation', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      const Column(
        children: <Widget>[
          AppSurface(child: SizedBox(height: 10)),
          AppSurface(
            elevation: AppElevation.flat,
            ring: false,
            child: SizedBox(height: 10),
          ),
        ],
      ),
    );
    final List<DecoratedBox> boxes = tester
        .widgetList<DecoratedBox>(
          find.descendant(
            of: find.byType(AppSurface),
            matching: find.byType(DecoratedBox),
          ),
        )
        .toList();
    final ShapeDecoration resting = boxes.first.decoration as ShapeDecoration;
    final ShapeDecoration flat = boxes.last.decoration as ShapeDecoration;
    expect(resting.shadows, hasLength(2)); // shadow-xs + hairline ring
    expect(flat.shadows, isEmpty);
  });

  testWidgets('AppIconTile tones and the white favicon tile', (
    WidgetTester tester,
  ) async {
    await inBothThemes((Brightness brightness) async {
      await pumpComponent(
        tester,
        const Row(
          children: <Widget>[
            AppIconTile(
              AppTileIcon(AppIconName.shieldAlert),
              tone: AppTileTone.destructive,
              key: Key('bad'),
            ),
            AppIconTile(
              AppTileLetter('G'),
              tone: AppTileTone.white,
              key: Key('white'),
            ),
          ],
        ),
        brightness: brightness,
      );
      final AppColors colors = tester.element(find.byType(Row)).colors;
      expect(
        fillUnder(tester, find.byKey(const Key('bad'))),
        colors.destructiveTint,
      );
      expect(
        fillUnder(tester, find.byKey(const Key('white'))),
        AppFixedColors.tileWhite,
      );
      expect(find.text('G'), findsOneWidget);
      expect(tester.getSize(find.byKey(const Key('bad'))), const Size(40, 40));
    });
  });

  testWidgets(
    'AppPill.count turns red when flagged; the finding marker is spoken',
    (WidgetTester tester) async {
      await pumpComponent(
        tester,
        Row(
          children: <Widget>[
            AppPill.count(7, key: const Key('n')),
            AppPill.count(3, flagged: true, key: const Key('flagged')),
            AppPill.finding(semanticLabel: 'Weak password'),
          ],
        ),
      );
      final AppColors colors = tester.element(find.byType(Row).first).colors;
      expect(fillUnder(tester, find.byKey(const Key('n'))), colors.secondary);
      expect(
        fillUnder(tester, find.byKey(const Key('flagged'))),
        colors.destructiveTint,
      );
      expect(find.bySemanticsLabel('Weak password'), findsOneWidget);
    },
  );

  testWidgets('AppInsetGroup puts a hairline between rows, not around them', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      const AppInsetGroup(
        dividerInset: AppDividerInset.settings,
        children: <Widget>[
          SizedBox(height: 52),
          SizedBox(height: 52),
          SizedBox(height: 52),
        ],
      ),
    );
    final Iterable<Padding> dividers = tester.widgetList<Padding>(
      find.byWidgetPredicate(
        (Widget w) =>
            w is Padding && w.padding == const EdgeInsets.only(left: 56),
      ),
    );
    expect(dividers, hasLength(2));
  });

  testWidgets('AppSectionLabel is an uppercase header; AppFootnote is muted', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      const Column(
        children: <Widget>[
          AppSectionLabel('Security'),
          AppFootnote('Locking wipes…'),
        ],
      ),
    );
    expect(find.text('SECURITY'), findsOneWidget);
    final AppColors colors = tester.element(find.byType(Column).first).colors;
    expect(
      tester.widget<Text>(find.text('Locking wipes…')).style!.color,
      colors.mutedForeground,
    );
  });

  group('SecretText', () {
    test('classifies characters like the web', () {
      expect(secretCharKind('7'), SecretCharKind.digit);
      expect(secretCharKind('q'), SecretCharKind.letter);
      expect(secretCharKind('é'), SecretCharKind.letter);
      expect(secretCharKind('ß'), SecretCharKind.letter);
      expect(secretCharKind('-'), SecretCharKind.symbol);
      expect(secretCharKind(' '), SecretCharKind.symbol);
      expect(
        secretCharKind('٣'),
        SecretCharKind.symbol,
      ); // not 0–9, not a letter
    });

    test('tints digits accent-strong and symbols muted, in runs', () {
      final List<TextSpan> spans = secretSpans('Tq7#vR', AppColors.light);
      expect(spans.map((TextSpan s) => s.text), <String>['Tq', '7', '#', 'vR']);
      expect(spans[1].style!.color, AppColors.light.accentStrong);
      expect(spans[2].style!.color, AppColors.light.mutedForeground);
      expect(spans[0].style, isNull);
    });
  });
}
