import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_manage_row.dart';
import 'package:keeperpass/presentation/common/widgets/rows/app_swipe_actions.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vaults/cubit/my_vaults_cubit.dart';
import 'package:keeperpass/presentation/features/vaults/pages/my_vaults_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;

  setUpAll(initializeDateFormatting);

  /// My Vaults pushed over a plain page, as from the scope sheet.
  Future<void> pumpVaults(
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
                  builder: (_) => BlocProvider<MyVaultsCubit>(
                    create: (_) => world.myVaultsCubit(),
                    child: const MyVaultsScreen(backLabel: 'All Vaults'),
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

  /// A change is saved through the fake storage.
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

  VaultSnapshot onlyDefault() {
    final VaultSnapshot boards = sampleVault(DateTime(2026, 10, 31, 9, 41));
    return boards.copyWith(
      vaults: <Vault>[
        for (final Vault v in boards.vaults)
          if (v.id == kPersonalVaultId) v,
      ],
      items: <VaultItem>[
        for (final VaultItem i in boards.items)
          i.copyWith(vaultId: kPersonalVaultId),
      ],
    );
  }

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S5-01 Default (${brightness.name}): each vault with its '
        'count and date; My Vault the default, with no actions', (
      WidgetTester tester,
    ) async {
      await pumpVaults(tester, brightness: brightness);
      expect(find.text('My Vaults'), findsWidgets);
      expect(
        find.text('Separate groups of items — work, family, personal'),
        findsOneWidget,
      );
      expect(find.text('All Vaults'), findsOneWidget);
      expect(find.text('Select'), findsOneWidget);
      expect(find.bySemanticsLabel('New vault'), findsOneWidget);
      expect(find.text('Default'), findsOneWidget);
      expect(find.text('7 items · created Sep 26, 2025'), findsOneWidget);
      expect(find.text('4 items · created Jan 4, 2026'), findsOneWidget);
      expect(
        find.text('My Vault holds 7 items and cannot be renamed or deleted.'),
        findsOneWidget,
      );
      // Only Work can be swiped.
      expect(find.byType(AppSwipeActions), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('tapping a vault opens it in the Vault tab', (
    WidgetTester tester,
  ) async {
    await pumpVaults(tester);
    await tester.tap(find.text('Work'));
    await tester.pumpAndSettle();
    expect(find.byType(MyVaultsScreen), findsNothing);
    expect(world.list.state.scope, VaultScope.vault);
    expect(world.list.state.vaultId, kWorkVaultId);
  });

  testWidgets('S5-02 Swipe: Rename and Delete; a long press offers the same', (
    WidgetTester tester,
  ) async {
    await pumpVaults(tester);
    await swipe(tester, 'Work');
    expect(find.text('Rename'), findsOneWidget);
    expect(find.bySemanticsLabel('Delete Work'), findsOneWidget);

    await tester.tapAt(const Offset(200, 120));
    await tester.pumpAndSettle();
    await tester.longPress(find.text('Work'));
    await tester.pumpAndSettle();
    expect(find.text('Rename'), findsOneWidget);
    expect(find.text('Delete'), findsOneWidget);
  });

  testWidgets('S5-03 New vault: a name in use is caught as typed; Create '
      'adds it and saves', (WidgetTester tester) async {
    await pumpVaults(tester);
    await tester.tap(find.bySemanticsLabel('New vault'));
    await tester.pumpAndSettle();
    expect(find.text('New Vault'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'Work');
    await tester.pump();
    expect(find.text('A vault with this name already exists.'), findsOneWidget);
    await tester.tap(find.text('Create vault'));
    await tester.pump();
    expect(find.text('New Vault'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'Travel');
    await tester.pump();
    await tester.tap(find.text('Create vault'));
    await settle(tester);
    expect(find.text('Travel'), findsOneWidget);
    expect(find.text('0 items · created Oct 31, 2026'), findsOneWidget);
  });

  testWidgets('S5-04 Rename: the items are not affected; another vault’s '
      'name is refused', (WidgetTester tester) async {
    await pumpVaults(tester);
    await swipe(tester, 'Work');
    await tester.tap(find.text('Rename'));
    await tester.pumpAndSettle();
    expect(find.text('Rename Vault'), findsOneWidget);
    expect(find.text('The items in it are not affected.'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'My Vault');
    await tester.pump();
    expect(
      find.text('A vault named “My Vault” already exists.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(EditableText), 'Work projects');
    await tester.pump();
    // The sheet's button (the swiped row's action sits beneath it).
    await tester.tap(find.text('Rename').last);
    await settle(tester);
    expect(find.text('Work projects'), findsOneWidget);
    expect(find.text('4 items · created Jan 4, 2026'), findsOneWidget);
  });

  testWidgets('S5-05 Delete: says where the items go; they move to My Vault', (
    WidgetTester tester,
  ) async {
    await pumpVaults(tester);
    await swipe(tester, 'Work');
    await tester.tap(find.bySemanticsLabel('Delete Work'));
    await tester.pumpAndSettle();
    expect(find.text('Delete “Work”?'), findsOneWidget);
    expect(
      find.text('Its 4 items move to My Vault. This cannot be undone.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Delete vault'));
    await settle(tester);
    expect(find.text('Work'), findsNothing);
    expect(find.text('11 items · created Sep 26, 2025'), findsOneWidget);
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S5-06 Only the default (${brightness.name}): what a second '
        'vault is for; nothing to select', (WidgetTester tester) async {
      await pumpVaults(tester, snapshot: onlyDefault(), brightness: brightness);
      expect(find.text('You only have the default vault'), findsOneWidget);
      expect(
        find.text(
          'A second vault keeps a set of items apart — work from personal, '
          'or shared from private.',
        ),
        findsOneWidget,
      );
      expect(find.text('Select'), findsNothing);
      await tester.tap(find.text('New vault'));
      await tester.pumpAndSettle();
      expect(find.text('New Vault'), findsOneWidget);
    });
  }

  testWidgets('Select: My Vault cannot be chosen; Delete N vaults, then the '
      'tab bar returns', (WidgetTester tester) async {
    await pumpVaults(tester);
    await tester.tap(find.text('Select'));
    await tester.pumpAndSettle();
    expect(world.bottomNav.state.barHidden, isTrue);
    expect(find.byType(AppCheckCircle), findsOneWidget);
    expect(find.text('0 vaults selected'), findsOneWidget);

    await tester.tap(find.text('My Vault'));
    await tester.pump();
    expect(find.text('0 vaults selected'), findsOneWidget);
    await tester.tap(find.text('Select All'));
    await tester.pump();
    expect(find.text('1 vault selected'), findsOneWidget);
    expect(
      tester.widget<AppManageRow>(find.byType(AppManageRow).last).selected,
      isTrue,
    );

    await tester.tap(find.text('Delete 1 vault'));
    await tester.pumpAndSettle();
    expect(find.text('Delete 1 vault?'), findsOneWidget);
    expect(
      find.text(
        'Everything in them — 4 items — moves to My Vault. This cannot be '
        'undone.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Delete 1 vault').last);
    await settle(tester);
    expect(find.text('Work'), findsNothing);
    expect(world.bottomNav.state.barHidden, isFalse);
  });
}
