import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet_parts.dart';
import 'package:keeperpass/presentation/common/widgets/navigation/app_tab_bar.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_favorites_strip.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_item_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_swipe_actions.dart';
import 'package:keeperpass/presentation/common/widgets/text/highlighted_text.dart';

import '../../../helpers/component_harness.dart';

/// Additions made for the Vault list (Part 7).
void main() {
  Widget row() => const SizedBox(
    height: 68,
    width: 393,
    child: ColoredBox(
      color: Colors.white,
      child: Center(child: Text('Row')),
    ),
  );

  group('AppSwipeActions', () {
    testWidgets('swiping right past the leading action runs it', (
      WidgetTester tester,
    ) async {
      int starred = 0;
      await pumpComponent(
        tester,
        AppSwipeActions(
          leadingAction: AppSwipeAction(
            icon: AppIconName.star,
            label: 'Favorite',
            semanticLabel: 'Add to favorites',
            onPressed: () => starred++,
          ),
          actions: <AppSwipeAction>[
            AppSwipeAction(
              icon: AppIconName.ellipsis,
              label: 'More',
              semanticLabel: 'More actions',
              onPressed: () {},
            ),
          ],
          child: row(),
        ),
      );

      await tester.drag(find.text('Row'), const Offset(40, 0));
      await tester.pumpAndSettle();
      expect(starred, 0);
      await tester.drag(find.text('Row'), const Offset(150, 0));
      await tester.pumpAndSettle();
      expect(starred, 1);
    });

    testWidgets('a full swipe runs the first action only when allowed', (
      WidgetTester tester,
    ) async {
      int more = 0;
      await pumpComponent(
        tester,
        AppSwipeActions(
          fullSwipe: false,
          actions: <AppSwipeAction>[
            AppSwipeAction(
              icon: AppIconName.ellipsis,
              label: 'More',
              semanticLabel: 'More actions',
              tone: AppSwipeTone.neutral,
              onPressed: () => more++,
            ),
          ],
          child: row(),
        ),
      );

      await tester.drag(find.text('Row'), const Offset(-380, 0));
      await tester.pumpAndSettle();
      expect(more, 0);
      expect(find.text('More'), findsOneWidget);
    });
  });

  group('search highlights', () {
    test('every match of every word, ignoring case, overlaps merged', () {
      final TextSpan span =
          highlightedSpan('GitHub Git', <String>['git', 'th']) as TextSpan;
      final List<(String, bool)> runs = <(String, bool)>[
        for (final InlineSpan child in span.children!)
          ((child as TextSpan).text!, child.style?.backgroundColor != null),
      ];
      expect(runs, <(String, bool)>[
        ('GitH', true),
        ('ub ', false),
        ('Git', true),
      ]);
    });

    test('the search reads words as the web does', () {
      expect(searchWords('  Work   GIT '), <String>['work', 'git']);
    });

    testWidgets('a row marks its name', (WidgetTester tester) async {
      await pumpComponent(
        tester,
        const AppItemRow(
          tile: AppIconTile(AppTileLetter('G')),
          name: 'GitHub',
          subtitle: 'janedoe-dev · Work',
          highlight: <String>['git'],
        ),
      );
      final RichText name = tester.widget<RichText>(
        find.byWidgetPredicate(
          (Widget w) => w is RichText && w.text.toPlainText() == 'GitHub',
        ),
      );
      expect(
        ((name.text as TextSpan).children!.single as TextSpan)
            .children!
            .first
            .style
            ?.backgroundColor,
        isNotNull,
      );
    });
  });

  testWidgets('the tab badge stays a small pill', (WidgetTester tester) async {
    await pumpComponent(
      tester,
      AppTabBar(
        tabs: const <AppTab>[
          AppTab(icon: AppIconName.layers, label: 'Vault'),
          AppTab(
            icon: AppIconName.shieldCheck,
            label: 'Security',
            badgeCount: 4,
          ),
        ],
        selectedIndex: 0,
        onSelected: (_) {},
      ),
      scroll: false,
    );
    final Size badge = tester.getSize(
      find.ancestor(of: find.text('4'), matching: find.byType(Container)).first,
    );
    expect(badge.width, lessThan(30));
  });

  testWidgets('a favorite card keeps its copy button inside', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      AppFavoritesStrip(
        children: <Widget>[
          AppFavoriteCard(
            tile: const AppIconTile(AppTileLetter('G')),
            name: 'GitHub',
            subtitle: 'jd',
            copyLabel: 'Copy password for GitHub',
            onCopy: () {},
          ),
        ],
      ),
    );
    final Rect card = tester.getRect(find.byType(AppFavoriteCard));
    final Rect copy = tester.getRect(
      find.bySemanticsLabel('Copy password for GitHub'),
    );
    expect(card.contains(copy.center), isTrue);
    expect(copy.right, lessThanOrEqualTo(card.right + 1));
  });

  testWidgets('a sheet row can be off, with a note', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      const AppSheetRow(label: 'Work', trailingText: 'Current', onTap: null),
    );
    expect(find.text('Current'), findsOneWidget);
    await tester.tap(find.text('Work'));
    await tester.pump();
  });
}
