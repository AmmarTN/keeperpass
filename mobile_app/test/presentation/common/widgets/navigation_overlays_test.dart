import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet_parts.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_link_button.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_date_picker.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_bars.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_tab_bar.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_dialog.dart';
import 'package:keeperpass/presentation/common/widgets/overlays/app_menu.dart';

import '../../../helpers/component_harness.dart';

const List<AppTab> _tabs = <AppTab>[
  AppTab(icon: AppIconName.layers, label: 'Vault'),
  AppTab(icon: AppIconName.timer, label: 'Codes'),
  AppTab(
    icon: AppIconName.shieldCheck,
    label: 'Security',
    badgeCount: 4,
    semanticLabel: 'Security, 4 items flagged',
  ),
];

/// A button that opens something with its own context.
Widget _opener(String label, void Function(BuildContext context) open) =>
    Builder(
      builder: (BuildContext context) =>
          AppButton(label: label, onPressed: () => open(context)),
    );

void main() {
  testWidgets('AppTabBar selects tabs, marks the active one, shows the badge', (
    WidgetTester tester,
  ) async {
    int selected = 0;
    await inBothThemes((Brightness brightness) async {
      await pumpComponent(
        tester,
        AppTabBar(
          tabs: _tabs,
          selectedIndex: 0,
          onSelected: (int i) => selected = i,
        ),
        brightness: brightness,
      );
      expect(find.text('4'), findsOneWidget);
      expect(
        tester.getSemantics(find.bySemanticsLabel('Vault')),
        isSemantics(isSelected: true, hasSelectedState: true),
      );
      await tester.tap(find.bySemanticsLabel('Security, 4 items flagged'));
      expect(selected, 2);
    });
  });

  testWidgets(
    'AppLargeTitleScrollView moves the title into the bar on scroll',
    (WidgetTester tester) async {
      await pumpComponent(
        tester,
        SizedBox(
          height: 600,
          child: AppLargeTitleScrollView(
            title: 'Tags',
            subtitle: 'Labels that cut across vaults',
            slivers: <Widget>[
              SliverList.list(
                children: <Widget>[
                  for (int i = 0; i < 40; i++)
                    SizedBox(height: 40, child: Text('row $i')),
                ],
              ),
            ],
          ),
        ),
        scroll: false,
      );
      double barTitleOpacity() => tester
          .widget<Opacity>(
            find.ancestor(
              of: find.text('Tags').first,
              matching: find.byType(Opacity),
            ),
          )
          .opacity;
      expect(barTitleOpacity(), 0);
      await tester.drag(find.text('row 3'), const Offset(0, -200));
      await tester.pumpAndSettle();
      expect(barTitleOpacity(), 1);
    },
  );

  testWidgets('A header action is a 36 pt circle that ends where the content '
      'does (your answer, 2026-11-03)', (WidgetTester tester) async {
    const Key content = Key('content');
    for (final TargetPlatform platform in <TargetPlatform>[
      TargetPlatform.iOS,
      TargetPlatform.android,
    ]) {
      await pumpComponent(
        tester,
        platform: platform,
        SizedBox(
          height: 600,
          child: AppLargeTitleScrollView(
            title: 'All Vaults',
            actions: <Widget>[
              AppIconButton(
                icon: AppIconName.lockKeyhole,
                semanticLabel: 'Lock',
                onPressed: () {},
              ),
              AppIconButton(
                icon: AppIconName.plus,
                semanticLabel: 'New item',
                onPressed: () {},
              ),
            ],
            slivers: const <Widget>[
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverToBoxAdapter(
                  child: SizedBox(key: content, height: 40),
                ),
              ),
            ],
          ),
        ),
        scroll: false,
      );
      final Finder circles = find.descendant(
        of: find.byType(AppIconButton),
        matching: find.byWidgetPredicate(
          (Widget w) =>
              w is Container &&
              w.decoration is BoxDecoration &&
              (w.decoration! as BoxDecoration).shape == BoxShape.circle,
        ),
      );
      expect(circles, findsNWidgets(2));
      expect(
        (tester.widget<Container>(circles.last).decoration! as BoxDecoration)
            .color,
        AppColors.light.secondary,
      );
      final Rect plus = tester.getRect(circles.last);
      expect(plus.size, const Size.square(36));
      expect(
        plus.right,
        moreOrLessEquals(tester.getRect(find.byKey(content)).right),
      );
    }
  });

  testWidgets('AppTabBar stays above Android’s button bar, not the handle', (
    WidgetTester tester,
  ) async {
    /// The space under the tabs for this platform and these system insets.
    Future<double> paddingFor(
      TargetPlatform platform, {
      required double inset,
      double sideGestures = 0,
    }) async {
      late double padding;
      await pumpComponent(
        tester,
        platform: platform,
        Builder(
          builder: (BuildContext context) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              padding: EdgeInsets.only(bottom: inset),
              viewPadding: EdgeInsets.only(bottom: inset),
              systemGestureInsets: EdgeInsets.fromLTRB(
                sideGestures,
                0,
                sideGestures,
                inset,
              ),
            ),
            child: Builder(
              builder: (BuildContext context) {
                padding = AppTabBar.bottomPadding(context);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
      return padding;
    }

    // The iPhone's home indicator overlaps the bar by 3 pt (the board).
    expect(await paddingFor(TargetPlatform.iOS, inset: 34), 31);
    // Android's gesture handle too: it is drawn over the app.
    expect(
      await paddingFor(TargetPlatform.android, inset: 24, sideGestures: 30),
      21,
    );
    // Android's buttons are a solid band: the tabs keep 8 pt above it.
    expect(await paddingFor(TargetPlatform.android, inset: 48), 56);
    // No inset at all: 8 pt under the labels.
    expect(await paddingFor(TargetPlatform.android, inset: 0), 8);
  });

  testWidgets('AppCompactBar: the edit bar’s Save waits for changes', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      AppCompactBar(
        title: 'Edit Item',
        leading: AppLinkButton.bar(label: 'Cancel', onPressed: () {}),
        trailing: const AppLinkButton.bar(label: 'Save', onPressed: null),
      ),
    );
    expect(find.text('Edit Item'), findsOneWidget);
    expect(
      tester.getSemantics(find.text('Save')),
      isSemantics(isEnabled: false, hasEnabledState: true, isButton: true),
    );
  });

  testWidgets('AppStepBar reads “Step 2 of 3”', (WidgetTester tester) async {
    await pumpComponent(tester, const AppStepBar(current: 2, total: 3));
    expect(find.bySemanticsLabel('Step 2 of 3'), findsOneWidget);
  });

  testWidgets('showAppSheet: title, rows, close', (WidgetTester tester) async {
    await inBothThemes((Brightness brightness) async {
      await pumpComponent(
        tester,
        _opener(
          'Open',
          (BuildContext context) => showAppSheet<void>(
            context,
            builder: (_) => AppSheet(
              title: 'Vaults',
              child: AppSheetRow(
                label: 'All Vaults',
                count: 23,
                selected: true,
                onTap: () {},
              ),
            ),
          ),
        ),
        brightness: brightness,
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Vaults'), findsOneWidget);
      expect(
        tester.getSemantics(find.text('All Vaults')),
        isSemantics(
          isChecked: true,
          hasCheckedState: true,
          isInMutuallyExclusiveGroup: true,
        ),
      );
      await tester.tap(find.bySemanticsLabel('Close'));
      await tester.pumpAndSettle();
      expect(find.text('Vaults'), findsNothing);
    });
  });

  testWidgets('showAppDialog: Cancel first, resolves to the choice', (
    WidgetTester tester,
  ) async {
    bool? result;
    await pumpComponent(
      tester,
      _opener(
        'Delete',
        (BuildContext context) async => result = await showAppDialog(
          context,
          icon: AppIconName.trash,
          title: 'Delete Item',
          message: 'This cannot be undone.',
          confirmLabel: 'Delete item',
          tone: AppDialogTone.solid,
        ),
      ),
    );
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text('Cancel')).dx,
      lessThan(tester.getTopLeft(find.text('Delete item')).dx),
    );
    await tester.tap(find.text('Delete item'));
    await tester.pumpAndSettle();
    expect(result, isTrue);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(result, isFalse);
  });

  testWidgets(
    'showAppMenu returns the chosen item and checks the current one',
    (WidgetTester tester) async {
      String? result;
      await pumpComponent(
        tester,
        _opener(
          'Sort',
          (BuildContext context) async => result = await showAppMenu<String>(
            context,
            heading: 'Sort by last update',
            selected: 'new',
            items: const <AppMenuItem<String>>[
              AppMenuItem<String>(value: 'new', label: 'Newest first'),
              AppMenuItem<String>(value: 'az', label: 'A to Z'),
            ],
          ),
        ),
      );
      await tester.tap(find.text('Sort'));
      await tester.pumpAndSettle();
      expect(find.text('Sort by last update'), findsOneWidget);
      expect(
        tester.getSemantics(find.text('Newest first')),
        isSemantics(isChecked: true, hasCheckedState: true),
      );
      await tester.tap(find.text('A to Z'));
      await tester.pumpAndSettle();
      expect(result, 'az');
    },
  );

  testWidgets(
    'showAppDatePicker uses the month wheel for months and returns the value',
    (WidgetTester tester) async {
      DateTime? picked;
      await pumpComponent(
        tester,
        _opener(
          'Pick',
          (BuildContext context) async => picked = await showAppDatePicker(
            context,
            title: 'Expires On',
            initial: DateTime(2029, 8),
            mode: AppDatePickerMode.month,
          ),
        ),
      );
      await tester.tap(find.text('Pick'));
      await tester.pumpAndSettle();
      expect(
        tester
            .widget<CupertinoDatePicker>(find.byType(CupertinoDatePicker))
            .mode,
        CupertinoDatePickerMode.monthYear,
      );
      await tester.tap(find.bySemanticsLabel('Close'));
      await tester.pumpAndSettle();
      expect(picked, DateTime(2029, 8));
    },
  );
}
