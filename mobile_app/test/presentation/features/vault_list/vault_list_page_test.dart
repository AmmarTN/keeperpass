import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/file_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_filter_chip.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_scope_switcher.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/import_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;

  Future<void> pumpVault(
    WidgetTester tester, {
    VaultSnapshot? snapshot,
    Brightness brightness = Brightness.light,
  }) async {
    world = VaultWorld(snapshot: snapshot);
    await tester.runAsync(world.open);
    addTearDown(() => tester.runAsync(world.close));
    await pumpScreen(
      tester,
      const VaultListScreen(),
      providers: world.providers,
      brightness: brightness,
    );
  }

  /// A state set from the test arrives a microtask later.
  Future<void> settle(WidgetTester tester) async {
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  /// Toasts, the copy tick and a secret's 30 s on the clipboard run on
  /// timers.
  Future<void> drainTimers(WidgetTester tester) =>
      tester.pump(const Duration(seconds: 31));

  for (final Brightness brightness in Brightness.values) {
    testWidgets('All Vaults: status, search, chips, favorites, sections '
        '(${brightness.name})', (WidgetTester tester) async {
      await pumpVault(tester, brightness: brightness);

      expect(find.byType(AppScopeSwitcher), findsOneWidget);
      expect(find.text('11 items · Saved to Google Drive'), findsOneWidget);
      expect(find.text('Search 11 items'), findsOneWidget);
      expect(find.text('dev'), findsOneWidget);
      expect(find.text('FAVORITES'), findsOneWidget);
      expect(find.text('TODAY'), findsOneWidget);
      expect(find.text('Newest first'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp('Weak password')), findsOneWidget);
      expect(find.bySemanticsLabel('Copy password for GitHub'), findsWidgets);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('the copy button copies and says so', (
    WidgetTester tester,
  ) async {
    await pumpVault(tester);

    await tester.tap(find.bySemanticsLabel('Copy password for Netflix'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(world.clipboard.copied, <String>[kWeakPassword]);
    expect(find.text('Password copied'), findsOneWidget);
    expect(find.text('From Netflix · Clears in 30 s'), findsOneWidget);
    expect(world.recent.ids, <String>['netflix']);
    await drainTimers(tester);
  });

  testWidgets('a tag chip filters in place and says how many match', (
    WidgetTester tester,
  ) async {
    await pumpVault(tester);

    await tester.tap(find.text('dev'));
    await settle(tester);

    expect(find.text('4 items tagged dev'), findsOneWidget);
    expect(find.text('FAVORITES'), findsNothing);
    expect(find.text('Netflix'), findsNothing);
  });

  testWidgets('the sort menu sits on the first section', (
    WidgetTester tester,
  ) async {
    await pumpVault(tester);

    await tester.tap(find.text('Newest first'));
    await tester.pumpAndSettle();
    expect(find.text('Sort by last update'), findsOneWidget);
    await tester.tap(find.text('A to Z').last);
    await tester.pumpAndSettle();

    expect(find.text('A TO Z'), findsOneWidget);
    expect(find.text('TODAY'), findsNothing);
  });

  testWidgets('the scope sheet picks a vault', (WidgetTester tester) async {
    await pumpVault(tester);

    await tester.tap(find.byType(AppScopeSwitcher));
    await tester.pumpAndSettle();
    expect(find.text('Vaults'), findsOneWidget);
    expect(find.text('Recently Used'), findsOneWidget);
    expect(find.text('Manage vaults'), findsOneWidget);
    expect(
      find.text(
        'All your vaults live in one encrypted file, vault.json.enc, in your '
        'Google Drive.',
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('Work'));
    await tester.pumpAndSettle();
    expect(find.text('4 items in Work'), findsOneWidget);
    expect(find.text('Search 4 items'), findsOneWidget);
    expect(find.text('FAVORITES'), findsNothing);
  });

  testWidgets('search: every word, marked; nothing found keeps the query', (
    WidgetTester tester,
  ) async {
    await pumpVault(tester);

    await tester.tap(find.text('Search 11 items'));
    await settle(tester);
    await tester.enterText(find.byType(EditableText), 'work git');
    await settle(tester);
    expect(find.text('2 RESULTS'), findsOneWidget);
    expect(
      find.text(
        'Every word has to match, in any order: names, tags, field names and '
        'values.',
      ),
      findsOneWidget,
    );

    await tester.enterText(find.byType(EditableText), 'netflix work');
    await settle(tester);
    expect(find.text('Your search did not match any items.'), findsOneWidget);
    await tester.tap(find.text('Clear search').last);
    await settle(tester);
    expect(find.text('Your search did not match any items.'), findsNothing);

    await tester.tap(find.text('Cancel'));
    await settle(tester);
    expect(find.text('11 items · Saved to Google Drive'), findsOneWidget);
  });

  testWidgets('long-press: the quick sheet with chips and actions', (
    WidgetTester tester,
  ) async {
    await pumpVault(tester);

    await tester.longPress(find.text('GitHub').last);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Authenticator Code'), findsOneWidget);
    expect(find.text('Open website'), findsOneWidget);
    expect(find.text('Remove from favorites'), findsOneWidget);
    expect(find.text('Move to vault…'), findsOneWidget);
    expect(find.text('Select'), findsOneWidget);

    await tester.tap(find.text('Username'));
    await tester.pump();
    expect(world.clipboard.copied, <String>['janedoe-dev']);
    expect(find.text('Copied'), findsOneWidget);

    await tester.tap(find.text('Open website'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(world.links.opened.single.toString(), 'https://github.com');
    await drainTimers(tester);
  });

  testWidgets('select several, then delete them, naming what goes', (
    WidgetTester tester,
  ) async {
    await pumpVault(tester);

    await tester.longPress(find.text('GitHub').last);
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    await tester.tap(find.text('Select'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.text('1 selected'), findsOneWidget);
    expect(world.bottomNav.state.barHidden, isTrue);

    await tester.tap(find.text('Slack'));
    await settle(tester);
    expect(find.text('2 selected'), findsOneWidget);

    await tester.tap(find.widgetWithText(AppButton, 'Delete 2 items'));
    await tester.pumpAndSettle();
    expect(find.text('Delete 2 items?'), findsOneWidget);
    expect(
      find.text(
        'GitHub and Slack will be deleted from Work. This cannot be undone.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Delete 2 items').last);
    await tester.pumpAndSettle();

    expect(
      world.vault.snapshot!.items.map((VaultItem i) => i.id),
      isNot(contains('github')),
    );
    expect(world.bottomNav.state.barHidden, isFalse);
    expect(find.text('9 items · Saved to Google Drive'), findsOneWidget);
  });

  testWidgets('move: the current vault is marked; a toast says where', (
    WidgetTester tester,
  ) async {
    await pumpVault(tester);
    world.list.startSelecting('github');
    world.list.toggleSelected('slack');
    await settle(tester);

    await tester.tap(find.widgetWithText(AppButton, 'Move 2 items'));
    await tester.pumpAndSettle();
    expect(find.text('Move 2 Items'), findsOneWidget);
    expect(find.text('Current'), findsOneWidget);
    expect(
      find.text('GitHub and Slack move with their history and tags.'),
      findsOneWidget,
    );

    await tester.tap(find.text('My Vault'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Moved GitHub and Slack to My Vault'), findsOneWidget);
    expect(find.text('They keep their history and tags.'), findsOneWidget);
    await drainTimers(tester);
  });

  testWidgets('New vault… checks the name, then moves into it', (
    WidgetTester tester,
  ) async {
    await pumpVault(tester);
    world.list.startSelecting('visa');
    await settle(tester);

    await tester.tap(find.widgetWithText(AppButton, 'Move 1 item'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('New vault…'));
    await tester.pumpAndSettle();
    expect(find.text('New Vault'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'Work');
    await tester.pump();
    expect(find.text('A vault with this name already exists.'), findsOneWidget);
    expect(
      tester
          .widget<AppButton>(find.widgetWithText(AppButton, 'Create vault'))
          .onPressed,
      isNull,
    );

    await tester.enterText(find.byType(EditableText), 'Travel');
    await tester.pump();
    await tester.tap(find.widgetWithText(AppButton, 'Create vault'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.text('Moved Visa to Travel'), findsOneWidget);
    expect(
      world.vault.snapshot!.vaults.map((Vault v) => v.name),
      contains('Travel'),
    );
    await drainTimers(tester);
  });

  testWidgets('with a single vault, Move explains itself', (
    WidgetTester tester,
  ) async {
    final VaultSnapshot one = sampleVault(DateTime(2026, 10, 31, 9, 41));
    await pumpVault(
      tester,
      snapshot: one.copyWith(
        vaults: <Vault>[one.vaults.first],
        items: <VaultItem>[
          for (final VaultItem i in one.items)
            i.copyWith(vaultId: kPersonalVaultId),
        ],
      ),
    );

    await tester.longPress(find.text('Netflix'));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    await tester.tap(find.text('Move to vault…'));
    await tester.pumpAndSettle();

    expect(
      find.text('There is no other vault to move this item to.'),
      findsOneWidget,
    );
    expect(find.text('Create a vault'), findsOneWidget);
  });

  testWidgets(
    'swiping left offers the copies; a full swipe copies the password',
    (WidgetTester tester) async {
      await pumpVault(tester);

      await tester.drag(find.text('Netflix'), const Offset(-150, 0));
      await tester.pumpAndSettle();
      expect(find.text('Password'), findsWidgets);
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
      await tester.tap(find.text('Username'));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(world.clipboard.copied.last, 'jane.doe92@example.com');

      await tester.drag(find.text('Home Wi-Fi').last, const Offset(-350, 0));
      await tester.pumpAndSettle(const Duration(milliseconds: 100));
      expect(world.clipboard.copied.last, 'Wifi-strong-passphrase-at-home-9');
      await drainTimers(tester);
    },
  );

  testWidgets('swiping right stars an item', (WidgetTester tester) async {
    await pumpVault(tester);

    await tester.drag(find.text('Netflix'), const Offset(150, 0));
    await tester.pumpAndSettle();

    expect(world.vault.snapshot!.favouriteIds, contains('netflix'));
  });

  testWidgets('pull to refresh re-reads the vault', (
    WidgetTester tester,
  ) async {
    await pumpVault(tester);
    world.storage.calls.clear();

    await tester.fling(find.text('TODAY'), const Offset(0, 400), 1500);
    await tester.pumpAndSettle();

    expect(world.storage.calls, contains('load:google'));
  });

  group('empty states', () {
    testWidgets('no items yet: the vault card, New item, Import from CSV', (
      WidgetTester tester,
    ) async {
      await pumpVault(
        tester,
        snapshot: VaultSnapshot.empty(vaultName: 'My Vault'),
      );

      expect(find.text('You don’t have any items yet.'), findsOneWidget);
      expect(
        find.text('Your vault is ready. Nothing in it yet.'),
        findsOneWidget,
      );
      expect(find.text('New item'), findsOneWidget);
      expect(find.text('Import from CSV'), findsOneWidget);

      // The system picker first, then Import on the chosen file.
      getIt
        ..registerSingleton<FileService>(world.files)
        ..registerFactory<ImportCubit>(world.importCubit);
      addTearDown(() async {
        await getIt.unregister<FileService>();
        await getIt.unregister<ImportCubit>();
      });
      world.files.picked = const PickedTextFile(
        name: 'export.csv',
        size: 2048,
        text: 'name,tags,Password\r\nGitHub,,hunter2',
      );
      await tester.tap(find.text('Import from CSV'));
      await tester.pumpAndSettle();
      expect(find.text('Found 1 item to import.'), findsOneWidget);
      expect(find.text('export.csv'), findsOneWidget);
    });

    testWidgets('an empty vault points to the default one', (
      WidgetTester tester,
    ) async {
      final VaultSnapshot sample = sampleVault(DateTime(2026, 10, 31, 9, 41));
      await pumpVault(
        tester,
        snapshot: sample.copyWith(
          vaults: <Vault>[
            ...sample.vaults,
            const Vault(id: 'empty', name: 'Family'),
          ],
        ),
      );
      world.list.setScope(VaultScope.vault, vaultId: 'empty');
      await settle(tester);

      expect(
        find.text('This vault does not have any items yet.'),
        findsOneWidget,
      );
      expect(
        find.text('Add one here, or move items in from My Vault.'),
        findsOneWidget,
      );
      expect(find.text('0 items in Family'), findsOneWidget);
    });

    testWidgets('a tag nothing carries yet', (WidgetTester tester) async {
      final VaultSnapshot sample = sampleVault(DateTime(2026, 10, 31, 9, 41));
      await pumpVault(
        tester,
        snapshot: sample.copyWith(
          tagRegistry: <TagRegistryEntry>[
            const TagRegistryEntry(name: 'travel'),
          ],
        ),
      );
      await tester.dragUntilVisible(
        find.text('travel'),
        find.byType(AppFilterChipBar),
        const Offset(-200, 0),
      );
      await tester.tap(find.text('travel'));
      await settle(tester);

      expect(find.text('0 items tagged travel'), findsOneWidget);
      expect(find.text('You don’t have any items yet.'), findsOneWidget);
      expect(
        find.text('Your vault is ready. Nothing in it yet.'),
        findsNothing,
      );
    });

    testWidgets('no favorites, nothing recent', (WidgetTester tester) async {
      final VaultSnapshot sample = sampleVault(DateTime(2026, 10, 31, 9, 41));
      await pumpVault(
        tester,
        snapshot: sample.copyWith(favouriteIds: <String>[]),
      );

      world.list.setScope(VaultScope.favourites);
      await settle(tester);
      expect(find.text('You don’t have any favorites yet.'), findsOneWidget);
      expect(
        find.text('Tap the star on any item to keep it here.'),
        findsOneWidget,
      );

      world.list.setScope(VaultScope.recent);
      await settle(tester);
      expect(find.text('Nothing used yet'), findsOneWidget);
      expect(find.text('0 items'), findsOneWidget);
    });

    testWidgets('a security filter that comes back clean is good news', (
      WidgetTester tester,
    ) async {
      await pumpVault(tester);
      world.list.showReport(AuditType.weakPassword);
      await settle(tester);
      // "N of M items" (board `S4-19`; your answer, Part 11).
      expect(find.text('1 of 11 items · Weak passwords'), findsOneWidget);

      await tester.tap(find.bySemanticsLabel('Copy password for Netflix'));
      await tester.runAsync(() => world.list.deleteItems(<String>['netflix']));
      await settle(tester);
      expect(find.text('0 of 10 items · Weak passwords'), findsOneWidget);

      expect(
        find.text('Every password in your vault is strong enough.'),
        findsOneWidget,
      );
      expect(find.text('Back to Security'), findsOneWidget);
      await tester.tap(find.text('Back to Security'));
      await settle(tester);
      expect(world.bottomNav.state.selectedIndex, 3);
      expect(world.list.state.report, isNull);
      await drainTimers(tester);
    });
  });

  group('the status line follows saving', () {
    testWidgets('offline', (WidgetTester tester) async {
      await pumpVault(tester);
      world.network.connected = false;
      await world.connectivity.recheck();
      await tester.pump(Duration.zero);
      await settle(tester);

      expect(find.text('Offline · 11 items'), findsOneWidget);
    });

    testWidgets('a change not saved', (WidgetTester tester) async {
      await pumpVault(tester);
      world.storage.failures['save:google'] = const Failure.networkFailure(
        NetworkFailure.sendTimeout(),
      );
      await tester.runAsync(() => world.list.toggleFavourite('netflix'));
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await settle(tester);

      expect(find.text('1 change not saved'), findsOneWidget);
    });
  });
}
