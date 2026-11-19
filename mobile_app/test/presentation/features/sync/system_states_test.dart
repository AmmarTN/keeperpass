import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/saving_pill_host.dart';
import 'package:keeperpass/presentation/features/sync/widgets/system_prompts.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;

  setUpAll(initializeDateFormatting);

  /// [screen] under the pill host and the system prompts, as in the app.
  Future<void> pumpStates(WidgetTester tester, Widget screen) async {
    world = VaultWorld(now: DateTime(2026, 11, 1, 9, 41));
    await tester.runAsync(world.open);
    addTearDown(() => tester.runAsync(world.close));
    late BuildContext page;
    await pumpScreen(
      tester,
      SavingPillHost(
        child: SystemPrompts(
          clipboard: world.clipboardService,
          navigatorContext: () => page,
          child: Builder(
            builder: (BuildContext context) {
              page = context;
              return screen;
            },
          ),
        ),
      ),
      providers: world.providers,
    );
  }

  /// Lets the fake storage answer and the banners finish growing.
  Future<void> settle(WidgetTester tester) async {
    for (int i = 0; i < 3; i++) {
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pump();
    }
    await tester.pump(const Duration(milliseconds: 300));
  }

  group('the saving pill (S6-01, S6-02)', () {
    testWidgets('says Saved for 1.5 s, then goes', (WidgetTester tester) async {
      await pumpStates(tester, const Scaffold(body: SizedBox.expand()));
      await tester.runAsync(world.sync.saveNow);
      await settle(tester);
      expect(find.text('Saved to Google Drive'), findsOneWidget);

      await tester.pump(SavingPillHost.savedFor);
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Saved to Google Drive'), findsNothing);
    });

    testWidgets('a change waiting says so until it is saved', (
      WidgetTester tester,
    ) async {
      await pumpStates(tester, const Scaffold(body: SizedBox.expand()));
      world.storage.failures['save:google'] = const Failure.storageError(
        StorageError.driveSaveFailed,
      );
      await tester.runAsync(world.sync.saveNow);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('1 change not saved'), findsOneWidget);
    });

    testWidgets('the Vault list says it in its status line instead', (
      WidgetTester tester,
    ) async {
      await pumpStates(tester, const VaultListScreen());
      await tester.pump(const Duration(milliseconds: 400));
      await tester.runAsync(world.sync.saveNow);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Saved to Google Drive'), findsNothing);
      expect(find.textContaining('Saved to Google Drive'), findsOneWidget);
      await tester.pump(SavingPillHost.savedFor);
    });
  });

  group('the Vault list banners', () {
    testWidgets('S6-03/04: not saved, Retry saves; Dismiss hides it', (
      WidgetTester tester,
    ) async {
      await pumpStates(tester, const VaultListScreen());
      world.storage.failures['save:google'] = const Failure.storageError(
        StorageError.driveSaveFailed,
      );
      await tester.runAsync(world.sync.saveNow);
      await settle(tester);
      expect(find.text('Your vault was not saved'), findsOneWidget);
      expect(
        find.text(
          'Google Drive could not be reached. Your change is still here — '
          'retry before you close KeeperPass.',
        ),
        findsOneWidget,
      );
      expect(find.text('1 change not saved'), findsOneWidget);

      world.storage.failures.clear();
      await tester.tap(find.text('Retry'));
      await settle(tester);
      expect(find.text('Your vault was not saved'), findsNothing);
      expect(world.sync.state.pendingChanges, 0);
      await tester.pump(SavingPillHost.savedFor);

      world.storage.failures['save:google'] = const Failure.storageError(
        StorageError.driveSaveFailed,
      );
      await tester.runAsync(world.sync.saveNow);
      await settle(tester);
      await tester.tap(find.text('Dismiss'));
      await settle(tester);
      expect(find.text('Your vault was not saved'), findsNothing);
      // What waits is still counted.
      expect(find.text('1 change not saved'), findsOneWidget);
    });

    testWidgets('S6-07: an expired session; Later puts it aside', (
      WidgetTester tester,
    ) async {
      await pumpStates(tester, const VaultListScreen());
      world.storage.failures['save:google'] = const Failure.storageAuthExpired(
        ProviderId.google,
      );
      await tester.runAsync(world.sync.saveNow);
      await settle(tester);
      expect(world.sync.state.phase, SyncPhase.sessionExpired);
      expect(find.text('Reconnect to Google Drive'), findsOneWidget);
      expect(
        find.text(
          'Your Google session has expired. Please reconnect. You can keep '
          'reading; changes are saved once you are back.',
        ),
        findsOneWidget,
      );
      expect(find.text('Reconnect'), findsOneWidget);

      await tester.tap(find.text('Later'));
      await settle(tester);
      expect(find.text('Reconnect to Google Drive'), findsNothing);
    });

    testWidgets('S6-08: offline is plain information', (
      WidgetTester tester,
    ) async {
      await pumpStates(tester, const VaultListScreen());
      world.network.connected = false;
      await tester.runAsync(world.connectivity.recheck);
      await settle(tester);
      expect(find.text('You’re offline'), findsOneWidget);
      expect(
        find.text(
          'You can keep reading and copying. Saving needs a connection to '
          'Google Drive.',
        ),
        findsOneWidget,
      );
    });
  });

  group('Your Vault Changed (S6-05, S6-06)', () {
    testWidgets('an edit refused for a newer version asks to load it', (
      WidgetTester tester,
    ) async {
      await pumpStates(tester, const Scaffold(body: SizedBox.expand()));
      world.storage.newer[ProviderId.google] = VaultFileInfo(
        modifiedAt: DateTime(2026, 11, 1, 9, 37),
      );
      bool? allowed;
      await tester.runAsync(() async {
        allowed = await world.sync.checkBeforeEditing();
      });
      await tester.pumpAndSettle();
      expect(allowed, isFalse);
      expect(find.text('Your Vault Changed'), findsOneWidget);
      expect(find.text('On this phone'), findsOneWidget);
      expect(find.text('In Google Drive'), findsOneWidget);
      expect(find.text('saved 9:37 AM · newer'), findsOneWidget);
      expect(
        find.text('Until then you can read and copy, but not edit.'),
        findsOneWidget,
      );

      // Not now: reading goes on, editing waits.
      await tester.tap(find.text('Not now'));
      await tester.pumpAndSettle();
      expect(find.text('Your Vault Changed'), findsNothing);
      expect(world.sync.state.canEdit, isFalse);

      // Asked again on the next edit; this time it is loaded.
      await tester.runAsync(world.sync.checkBeforeEditing);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Load the latest version'));
      await settle(tester);
      await tester.pumpAndSettle();
      expect(find.text('Your Vault Changed'), findsNothing);
      expect(find.text('Up to date'), findsOneWidget);
      expect(find.text('Loaded the version saved at 9:37 AM'), findsOneWidget);
      expect(world.sync.state.canEdit, isTrue);
      await tester.pump(const Duration(seconds: 5));
    });
  });

  testWidgets('S6-14: Clipboard cleared, while KeeperPass is open', (
    WidgetTester tester,
  ) async {
    await pumpStates(tester, const Scaffold(body: SizedBox.expand()));
    // In the test's own time, so its 30 s can run out.
    await world.clipboardService.copy('hunter2', sensitive: true);
    await tester.pump(const Duration(seconds: 30));
    await tester.pump();
    expect(find.text('Clipboard cleared'), findsOneWidget);
    await tester.pump(const Duration(seconds: 5));
  });
}
