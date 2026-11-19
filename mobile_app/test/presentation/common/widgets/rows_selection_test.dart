import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/utils/text/tag_color.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_edit_field_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_field_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_item_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_settings_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_swipe_actions.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_filter_chip.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_segmented_control.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_stepper_slider.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_switch.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_tag_chip.dart';

import '../../../helpers/component_harness.dart';

const Widget _tile = AppIconTile(AppTileLetter('G'), tone: AppTileTone.white);

void main() {
  group('AppItemRow', () {
    testWidgets('name, star, marker, tag, +N and copy; tap and long-press', (
      WidgetTester tester,
    ) async {
      final List<String> calls = <String>[];
      await inBothThemes((Brightness brightness) async {
        calls.clear();
        await pumpComponent(
          tester,
          AppItemRow(
            tile: _tile,
            name: 'Netflix',
            subtitle: 'jane.doe92@example.com · My Vault',
            favorite: true,
            findingLabel: 'Weak and reused password',
            firstTag: 'entertainment',
            moreTags: 2,
            copyLabel: 'Copy password for Netflix',
            onCopy: () => calls.add('copy'),
            onTap: () => calls.add('tap'),
            onLongPress: () => calls.add('long'),
          ),
          brightness: brightness,
        );
        expect(find.text('Netflix'), findsOneWidget);
        expect(find.text('entertainment'), findsOneWidget);
        expect(find.text('+2'), findsOneWidget);
        // The row reads as one button; the finding is part of what it says.
        expect(
          find.bySemanticsLabel(RegExp('Weak and reused password')),
          findsOneWidget,
        );
        await tester.tap(find.text('Netflix'));
        await tester.longPress(find.text('Netflix'));
        await tester.tap(find.bySemanticsLabel('Copy password for Netflix'));
        await tester.pump(const Duration(seconds: 1));
        expect(calls, <String>['tap', 'long', 'copy']);
        expect(tester.getSize(find.byType(AppItemRow)).height, 68);
      });
    });

    testWidgets('selection mode: tick instead of copy, tinted when selected', (
      WidgetTester tester,
    ) async {
      await pumpComponent(
        tester,
        const AppItemRow(
          tile: _tile,
          name: 'GitHub',
          subtitle: 'janedoe-dev · Work',
          selected: true,
        ),
      );
      expect(find.byType(AppCopyButton), findsNothing);
      expect(
        find.byWidgetPredicate((Widget w) => w is AppCheckCircle && w.checked),
        findsOneWidget,
      );
      final AppColors colors = tester.element(find.byType(AppItemRow)).colors;
      expect(
        tester
            .widget<Container>(
              find
                  .descendant(
                    of: find.byType(AppItemRow),
                    matching: find.byType(Container),
                  )
                  .first,
            )
            .color,
        colors.primary10,
      );
    });
  });

  testWidgets(
    'AppSwipeActions: a short swipe opens the actions, a full one runs the first',
    (WidgetTester tester) async {
      final List<String> calls = <String>[];
      await pumpComponent(
        tester,
        AppSwipeActions(
          actions: <AppSwipeAction>[
            AppSwipeAction(
              icon: AppIconName.copy,
              label: 'Password',
              semanticLabel: 'Copy password',
              onPressed: () => calls.add('password'),
            ),
            AppSwipeAction(
              icon: AppIconName.userRound,
              label: 'Username',
              semanticLabel: 'Copy username',
              onPressed: () => calls.add('username'),
            ),
          ],
          child: const SizedBox(
            height: 68,
            child: ColoredBox(color: Colors.white),
          ),
        ),
      );
      await tester.drag(find.byType(AppSwipeActions), const Offset(-120, 0));
      await tester.pumpAndSettle();
      expect(find.text('Username'), findsOneWidget);
      await tester.tap(find.bySemanticsLabel('Copy username'));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(AppSwipeActions), const Offset(-340, 0));
      await tester.pumpAndSettle();
      expect(calls, <String>['username', 'password']);
    },
  );

  testWidgets('AppFieldRow: copying swaps the label to “Copied” for 1 s', (
    WidgetTester tester,
  ) async {
    int copies = 0;
    await pumpComponent(
      tester,
      AppFieldRow(
        tile: const AppIconTile(
          AppTileGlyph(FaGlyphs.user),
          size: AppTileSize.field,
          tone: AppTileTone.soft,
        ),
        label: 'Username',
        value: const AppFieldText('janedoe-dev'),
        copyLabel: 'Copy username',
        onCopy: () => copies++,
      ),
    );
    expect(find.text('Username'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Copy username'));
    await tester.pump();
    expect(copies, 1);
    expect(find.text('Copied'), findsOneWidget);
    expect(find.text('Username'), findsNothing);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Username'), findsOneWidget);
  });

  testWidgets('AppFieldText.empty says “[empty]”', (WidgetTester tester) async {
    await pumpComponent(tester, const AppFieldText.empty());
    expect(find.text('[empty]'), findsOneWidget);
  });

  group('AppSettingsRow', () {
    testWidgets('a toggle row flips its switch from anywhere on the row', (
      WidgetTester tester,
    ) async {
      bool value = false;
      await pumpComponent(
        tester,
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) =>
              AppSettingsRow.toggle(
                title: 'Unlock with Face ID',
                value: value,
                onChanged: (bool v) => setState(() => value = v),
              ),
        ),
      );
      await tester.tap(find.text('Unlock with Face ID'));
      await tester.pumpAndSettle();
      expect(value, isTrue);
      expect(tester.widget<AppSwitch>(find.byType(AppSwitch)).value, isTrue);
    });

    testWidgets('choice and radio rows are one-of and checked', (
      WidgetTester tester,
    ) async {
      await pumpComponent(
        tester,
        Column(
          children: <Widget>[
            AppSettingsRow.choice(
              title: 'After 10 minutes',
              selected: true,
              onTap: () {},
            ),
            AppSettingsRow.radio(
              title: 'Work',
              subtitle: '4 items',
              selected: false,
              onTap: () {},
            ),
          ],
        ),
      );
      expect(findAppIcon(AppIconName.check), findsOneWidget);
      expect(
        tester.getSemantics(find.text('After 10 minutes')),
        isSemantics(
          isInMutuallyExclusiveGroup: true,
          hasCheckedState: true,
          isChecked: true,
          label: 'After 10 minutes',
        ),
      );
      expect(find.byType(AppRadioDot), findsOneWidget);
    });

    testWidgets('value and chevron', (WidgetTester tester) async {
      await pumpComponent(
        tester,
        AppSettingsRow(
          title: 'Auto-lock',
          value: 'After 10 minutes',
          chevron: true,
          onTap: () {},
        ),
      );
      expect(find.text('After 10 minutes'), findsOneWidget);
      expect(findAppIcon(AppIconName.chevronRight), findsOneWidget);
      expect(
        tester.getSize(find.byType(AppSettingsRow)).height,
        greaterThanOrEqualTo(52),
      );
    });
  });

  testWidgets('AppEditFieldRow wires the Secret chip, remove and change-icon', (
    WidgetTester tester,
  ) async {
    final List<String> calls = <String>[];
    await pumpComponent(
      tester,
      AppEditFieldRow(
        name: 'Password',
        glyph: FaGlyphs.lock,
        secret: true,
        onSecretChanged: (bool v) => calls.add('secret $v'),
        onRemove: () => calls.add('remove'),
        onChangeIcon: () => calls.add('icon'),
        editor: const SizedBox(height: 48),
      ),
    );
    await tester.tap(find.bySemanticsLabel('Secret: Password'));
    await tester.tap(find.bySemanticsLabel('Remove Password'));
    await tester.tap(find.bySemanticsLabel('Change the Password icon'));
    expect(calls, <String>['secret false', 'remove', 'icon']);
    expect(find.bySemanticsLabel('Reorder Password'), findsOneWidget);
  });

  testWidgets('AppTagChip uses the tag’s own colour in both themes', (
    WidgetTester tester,
  ) async {
    await inBothThemes((Brightness brightness) async {
      await pumpComponent(
        tester,
        const AppTagChip('travel'),
        brightness: brightness,
      );
      final AppColors colors = tester.element(find.byType(AppTagChip)).colors;
      expect(
        tester.widget<Text>(find.text('travel')).style!.color,
        colors.tag(tagColorFor('travel')),
      );
    });
  });

  testWidgets(
    'AppTagChip editable removes; AppFilterChip shows a check when on',
    (WidgetTester tester) async {
      int removed = 0;
      await pumpComponent(
        tester,
        Column(
          children: <Widget>[
            AppTagChip(
              'work',
              style: AppTagChipStyle.editable,
              onRemove: () => removed++,
            ),
            AppFilterChip.tag(
              tag: 'dev',
              count: 4,
              selected: true,
              onPressed: () {},
            ),
          ],
        ),
      );
      await tester.tap(find.bySemanticsLabel('Remove tag work'));
      expect(removed, 1);
      expect(findAppIcon(AppIconName.check), findsOneWidget);
      expect(find.text('4'), findsOneWidget);
    },
  );

  testWidgets('AppSwitch toggles; disabled it does not', (
    WidgetTester tester,
  ) async {
    bool value = false;
    await pumpComponent(
      tester,
      Column(
        children: <Widget>[
          AppSwitch(
            value: value,
            onChanged: (bool v) => value = v,
            semanticLabel: 'On',
          ),
          const AppSwitch(value: true, onChanged: null, semanticLabel: 'Off'),
        ],
      ),
    );
    await tester.tap(find.bySemanticsLabel('On'));
    expect(value, isTrue);
    expect(
      tester
          .widget<Opacity>(
            find.descendant(
              of: find.bySemanticsLabel('Off'),
              matching: find.byType(Opacity),
            ),
          )
          .opacity,
      0.5,
    );
  });

  testWidgets(
    'AppSegmentedControl changes the value; the chosen one is checked',
    (WidgetTester tester) async {
      String value = 'Passphrase';
      await pumpComponent(
        tester,
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) =>
              AppSegmentedControl<String>(
                segments: const <AppSegment<String>>[
                  AppSegment<String>('Passphrase', 'Passphrase'),
                  AppSegment<String>('Random', 'Random string'),
                ],
                selected: value,
                onChanged: (String v) => setState(() => value = v),
              ),
        ),
      );
      await tester.tap(find.text('Random string'));
      await tester.pumpAndSettle();
      expect(value, 'Random');
      expect(
        tester.getSemantics(find.text('Random string')),
        isSemantics(
          isInMutuallyExclusiveGroup: true,
          hasCheckedState: true,
          isChecked: true,
          label: 'Random string',
        ),
      );
    },
  );

  testWidgets(
    'AppCheckTile, AppCheckRow and AppToggleChip report their state',
    (WidgetTester tester) async {
      final List<bool> values = <bool>[];
      await pumpComponent(
        tester,
        Column(
          children: <Widget>[
            AppCheckTile(
              label: 'a–z',
              semanticLabel: 'Lowercase letters',
              checked: true,
              onChanged: values.add,
            ),
            AppCheckRow(
              label: 'I’ve written my secret down',
              checked: false,
              onChanged: values.add,
            ),
            AppToggleChip(
              value: false,
              fieldName: 'Website',
              onChanged: values.add,
            ),
          ],
        ),
      );
      await tester.tap(find.bySemanticsLabel('Lowercase letters'));
      await tester.tap(find.text('I’ve written my secret down'));
      await tester.tap(find.bySemanticsLabel('Secret: Website'));
      expect(values, <bool>[false, true, true]);
    },
  );

  testWidgets('AppStepperSlider steps within its range', (
    WidgetTester tester,
  ) async {
    int words = 4;
    await pumpComponent(
      tester,
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) =>
            AppStepperSlider(
              label: 'Words',
              value: words,
              min: 3,
              max: 12,
              decreaseLabel: 'Fewer words',
              increaseLabel: 'More words',
              onChanged: (int v) => setState(() => words = v),
            ),
      ),
    );
    await tester.tap(find.bySemanticsLabel('More words'));
    await tester.pump();
    expect(words, 5);
    for (int i = 0; i < 3; i++) {
      await tester.tap(find.bySemanticsLabel('Fewer words'));
      await tester.pump();
    }
    expect(words, 3); // never below the minimum
    final Rect track = tester.getRect(find.bySemanticsLabel('Words').last);
    await tester.tapAt(track.centerRight - const Offset(1, 0));
    await tester.pump();
    expect(words, 12);
  });
}
