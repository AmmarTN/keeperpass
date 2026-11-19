import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_manage_row.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';
import 'package:keeperpass/presentation/features/tags/cubit/tags_cubit.dart';
import 'package:keeperpass/presentation/features/tags/pages/tags_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;

  setUpAll(initializeDateFormatting);

  /// Tags pushed over a plain page, as from the chip strip.
  Future<void> pumpTags(
    WidgetTester tester, {
    VaultSnapshot? snapshot,
    Brightness brightness = Brightness.light,
  }) async {
    world = VaultWorld(snapshot: snapshot);
    await tester.runAsync(world.open);
    addTearDown(() => tester.runAsync(world.close));
    await pumpScreen(
      tester,
      Builder(
        builder: (BuildContext context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BlocProvider<TagsCubit>(
                    create: (_) => world.tagsCubit(),
                    child: const TagsScreen(backLabel: 'All Vaults'),
                  ),
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
      providers: world.providers,
      brightness: brightness,
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  Future<void> settle(WidgetTester tester) async {
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pumpAndSettle();
  }

  Future<void> swipe(WidgetTester tester, String name) async {
    await tester.drag(find.text(name), const Offset(-200, 0));
    await tester.pumpAndSettle();
  }

  VaultItem item(String id) =>
      world.vault.snapshot!.items.firstWhere((VaultItem i) => i.id == id);

  List<String> rows(WidgetTester tester) => <String>[
    for (final AppManageRow r in tester.widgetList<AppManageRow>(
      find.byType(AppManageRow),
    ))
      r.title,
  ];

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S5-07 Default (${brightness.name}): each tag in its colour, '
        'with its count and “since” date, most used first', (
      WidgetTester tester,
    ) async {
      await pumpTags(tester, brightness: brightness);
      expect(find.text('Tags'), findsWidgets);
      expect(
        find.text('Labels that cut across vaults, for finding things fast'),
        findsOneWidget,
      );
      expect(rows(tester), <String>[
        'dev',
        'work',
        'social',
        'entertainment',
        'finance',
        'shopping',
      ]);
      expect(find.text('since Sep 26, 2025'), findsNWidgets(6));
      // Each row reads as one: name, date and "4 items".
      expect(
        find.bySemanticsLabel(RegExp(r'^dev\n.*\n4 items$')),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel(RegExp(r'\n1 item$')), findsNWidgets(3));
      expect(
        find.text('Tap a tag to see its items in the Vault tab.'),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('tapping a tag opens the Vault tab filtered by it', (
    WidgetTester tester,
  ) async {
    await pumpTags(tester);
    await tester.tap(find.text('social'));
    await tester.pumpAndSettle();
    expect(find.byType(TagsScreen), findsNothing);
    expect(world.list.state.tag, 'social');
  });

  testWidgets('S5-08 Select: checkboxes, the count, one counted action', (
    WidgetTester tester,
  ) async {
    await pumpTags(tester);
    await tester.tap(find.text('Select'));
    await tester.pumpAndSettle();
    expect(world.bottomNav.state.barHidden, isTrue);
    expect(find.byType(AppCheckCircle), findsNWidgets(6));
    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Select All'), findsOneWidget);

    await tester.tap(find.text('finance'));
    await tester.tap(find.text('shopping'));
    await tester.pump();
    expect(find.text('2 tags selected'), findsOneWidget);
    await tester.tap(find.text('Delete 2 tags'));
    await tester.pumpAndSettle();
    expect(find.text('Delete 2 tags?'), findsOneWidget);
    expect(
      find.text(
        'Each one is removed from every item that has it. The items '
        'themselves are kept. This cannot be undone.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Delete 2 tags').last);
    await settle(tester);
    expect(rows(tester), isNot(contains('finance')));
    expect(item('paypal').tags, isEmpty);
    expect(item('paypal').history.first.tags, <String>['finance']);
    expect(world.bottomNav.state.barHidden, isFalse);
  });

  testWidgets('S5-09 Add: the colour it gets from its name; a taken name is '
      'refused', (WidgetTester tester) async {
    await pumpTags(tester);
    await tester.tap(find.bySemanticsLabel('Add tag'));
    await tester.pumpAndSettle();
    expect(find.text('Add Tag'), findsOneWidget);
    expect(
      find.text(
        'A tag with no items yet. Put it on an item from that item’s '
        'own page.',
      ),
      findsOneWidget,
    );

    await tester.enterText(find.byType(EditableText), 'work');
    await tester.pump();
    expect(find.text('A tag with this name already exists.'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'travel');
    await tester.pump();
    expect(find.text('Its color comes from its name.'), findsOneWidget);
    await tester.tap(find.text('Add tag').last);
    await settle(tester);
    expect(rows(tester).last, 'travel');
    expect(find.text('since Oct 31, 2026'), findsOneWidget);
  });

  testWidgets('S5-10 Rename: every item carrying it; a name in use says they '
      'would merge — and, as the web, cannot be used', (
    WidgetTester tester,
  ) async {
    await pumpTags(tester);
    await swipe(tester, 'work');
    await tester.tap(find.text('Rename'));
    await tester.pumpAndSettle();
    expect(find.text('Rename Tag'), findsOneWidget);
    expect(find.text('Every item carrying it is updated.'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'dev');
    await tester.pump();
    expect(
      find.text('‘dev’ already exists — renaming will merge them.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Rename').last);
    await tester.pump();
    expect(find.text('Rename Tag'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'job');
    await tester.pump();
    await tester.tap(find.text('Rename').last);
    await settle(tester);
    expect(rows(tester), contains('job'));
    expect(item('github').tags, <String>['dev', 'job']);
  });

  testWidgets('S5-11 Delete: names the count and promises the items stay', (
    WidgetTester tester,
  ) async {
    await pumpTags(tester);
    await swipe(tester, 'dev');
    await tester.tap(find.bySemanticsLabel('Delete dev'));
    await tester.pumpAndSettle();
    expect(find.text('Delete “dev”?'), findsOneWidget);
    expect(
      find.text(
        'It will be removed from 4 items. The items themselves are kept. '
        'This cannot be undone.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Delete tag'));
    await settle(tester);
    expect(rows(tester), isNot(contains('dev')));
    expect(world.vault.snapshot!.items, hasLength(11));
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S5-12 No tags yet (${brightness.name}): where tags come from; '
        'nothing to select', (WidgetTester tester) async {
      final VaultSnapshot boards = sampleVault(DateTime(2026, 10, 31, 9, 41));
      await pumpTags(
        tester,
        brightness: brightness,
        snapshot: boards.copyWith(
          items: <VaultItem>[
            for (final VaultItem i in boards.items)
              i.copyWith(tags: const <String>[]),
          ],
        ),
      );
      expect(find.text('No tags yet'), findsOneWidget);
      expect(
        find.text(
          'Tags are created from an item, or here — either way they group '
          'items across vaults.',
        ),
        findsOneWidget,
      );
      expect(find.text('Select'), findsNothing);
      await tester.tap(find.text('Add tag'));
      await tester.pumpAndSettle();
      expect(find.text('Add Tag'), findsOneWidget);
    });
  }
}
