import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_explainers.dart';
import 'package:keeperpass/presentation/features/change_secret/cubit/change_secret_cubit.dart';
import 'package:keeperpass/presentation/features/change_secret/pages/change_secret_page.dart';
import 'package:keeperpass/presentation/features/move_vault/cubit/move_vault_cubit.dart';
import 'package:keeperpass/presentation/features/move_vault/pages/move_vault_page.dart';
import 'package:keeperpass/presentation/features/settings/pages/archive_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;
  Object? popped;

  setUpAll(initializeDateFormatting);

  /// [page] pushed over a plain screen, as from Settings; [popped] is what
  /// it closed with.
  Future<void> pumpFlow(WidgetTester tester, Widget page) async {
    world = VaultWorld(now: DateTime.utc(2026, 11, 1, 9, 41));
    popped = null;
    await tester.runAsync(world.open);
    addTearDown(() => tester.runAsync(world.close));
    await pumpScreen(
      tester,
      Builder(
        builder: (BuildContext context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () async {
                popped = await Navigator.of(context).push<Object?>(
                  MaterialPageRoute<Object?>(builder: (_) => page),
                );
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
      providers: world.providers,
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  /// Lets the fake storage and cipher answer. Fixed pumps: a move that
  /// worked leaves its spinner up (the app's navigator then shows Welcome).
  Future<void> settle(WidgetTester tester) async {
    for (int i = 0; i < 4; i++) {
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pump();
    }
    await tester.pump(const Duration(milliseconds: 500));
  }

  Finder field(int index) => find.byType(EditableText).at(index);

  AppButton buttonNamed(WidgetTester tester, String label) =>
      tester.widget<AppButton>(
        find.byWidgetPredicate(
          (Widget w) => w is AppButton && w.label == label,
        ),
      );

  group('Change secret', () {
    Widget page() => BlocProvider<ChangeSecretCubit>(
      create: (_) => world.changeSecretCubit(),
      child: const ChangeSecretScreen(),
    );

    testWidgets('S5-18 → S5-22: the form, then Done', (
      WidgetTester tester,
    ) async {
      await pumpFlow(tester, Builder(builder: (_) => page()));
      expect(find.text('Change Secret'), findsOneWidget);
      expect(buttonNamed(tester, 'Change secret').onPressed, isNull);

      await tester.enterText(field(0), 'secret');
      await tester.enterText(field(1), 'new secret words');
      await tester.enterText(field(2), 'new secret words');
      await tester.pump();
      expect(find.text('The two secrets match.'), findsOneWidget);

      await tester.tap(find.text('Change secret'));
      await settle(tester);
      expect(find.text('Your secret was changed'), findsOneWidget);

      await tester.tap(find.text('Done'));
      await tester.pumpAndSettle();
      expect(popped, isTrue);
    });

    testWidgets('S5-19: a wrong current secret says so', (
      WidgetTester tester,
    ) async {
      await pumpFlow(tester, Builder(builder: (_) => page()));
      await tester.enterText(field(0), 'nope');
      await tester.enterText(field(1), 'new secret words');
      await tester.enterText(field(2), 'new secret words');
      await tester.pump();
      await tester.tap(find.text('Change secret'));
      await settle(tester);

      expect(find.text('That is not your current secret.'), findsOneWidget);
    });

    testWidgets('S5-23: not saved; Cancel leaves it unchanged', (
      WidgetTester tester,
    ) async {
      await pumpFlow(tester, Builder(builder: (_) => page()));
      world.storage.failures['save:google'] = const Failure.storageError(
        StorageError.driveSaveFailed,
      );
      world.storage.failures['reset:google'] = const Failure.storageError(
        StorageError.driveSaveFailed,
      );
      await tester.enterText(field(0), 'secret');
      await tester.enterText(field(1), 'new secret words');
      await tester.enterText(field(2), 'new secret words');
      await tester.pump();
      await tester.tap(find.text('Change secret'));
      await settle(tester);

      expect(find.text('Your vault was not saved'), findsOneWidget);
      expect(find.text('Try again'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(popped, isFalse);
    });
  });

  group('Move vault', () {
    Widget page() => BlocProvider<MoveVaultCubit>(
      create: (_) => world.moveVaultCubit()..start(ProviderId.dropbox),
      child: const MoveVaultScreen(),
    );

    testWidgets('S5-25 → S5-26: Connect, consent, Move; signed out', (
      WidgetTester tester,
    ) async {
      await pumpFlow(tester, Builder(builder: (_) => page()));
      world.storage.files[ProviderId.dropbox] = 'older vault';

      expect(find.text('Move Vault'), findsOneWidget);
      expect(find.text('Move vault to Dropbox'), findsOneWidget);
      expect(
        find.bySemanticsLabel('Your vault moves from Google Drive to Dropbox'),
        findsOneWidget,
      );
      expect(
        find.text('Sign in to Dropbox to choose where the vault goes.'),
        findsOneWidget,
      );

      await tester.tap(find.text('Connect Dropbox'));
      await settle(tester);
      expect(find.text('MOVING TO THIS ACCOUNT'), findsOneWidget);
      expect(find.text('jane@dropbox.example'), findsOneWidget);
      expect(
        find.text('This Dropbox account already has a KeeperPass vault'),
        findsOneWidget,
      );
      expect(buttonNamed(tester, 'Move vault').onPressed, isNull);

      await tester.tap(
        find.text('Replace it — the existing vault is kept as a backup'),
      );
      await tester.pump();
      expect(buttonNamed(tester, 'Move vault').onPressed, isNotNull);

      await tester.tap(find.text('Move vault'));
      await settle(tester);
      expect(world.session.state.phase, SessionPhase.signedOut);
      expect(world.session.state.farewell, isA<MovedFarewell>());
    });

    testWidgets('S5-27: a new secret, typed twice', (
      WidgetTester tester,
    ) async {
      await pumpFlow(tester, Builder(builder: (_) => page()));
      await tester.tap(find.text('Connect Dropbox'));
      await settle(tester);

      await tester.tap(find.text('Choose a new secret'));
      await tester.pump();
      expect(find.text('Only the moved vault uses it'), findsOneWidget);
      expect(buttonNamed(tester, 'Move vault').onPressed, isNull);

      await tester.enterText(field(0), 'another secret');
      await tester.enterText(field(1), 'another secret');
      await tester.pump();
      expect(find.text('The two secrets match.'), findsOneWidget);
      expect(buttonNamed(tester, 'Move vault').onPressed, isNotNull);
    });

    testWidgets('S5-31: not moved; Try again', (WidgetTester tester) async {
      await pumpFlow(tester, Builder(builder: (_) => page()));
      world.storage.failures['save:dropbox'] = const Failure.storageError(
        StorageError.dropboxSaveFailed,
      );
      await tester.tap(find.text('Connect Dropbox'));
      await settle(tester);
      await tester.tap(find.text('Move vault'));
      await settle(tester);

      expect(find.text('Your vault was not moved'), findsOneWidget);
      expect(find.text('Still in Google Drive · unchanged'), findsOneWidget);
      expect(world.session.state.phase, SessionPhase.ready);

      world.storage.failures.clear();
      await tester.tap(find.text('Try again'));
      await settle(tester);
      expect(world.session.state.phase, SessionPhase.signedOut);
    });
  });

  group('Archive', () {
    testWidgets('S5-36: type ARCHIVE, then the vault file is renamed', (
      WidgetTester tester,
    ) async {
      await pumpFlow(
        tester,
        ArchivePage(now: () => DateTime.utc(2026, 10, 29, 14, 32)),
      );
      expect(find.text('Archive Vault'), findsOneWidget);
      expect(
        find.textContaining(
          breakableFileName('vault.removed-2026-10-29T14-32-00.json.enc'),
        ),
        findsOneWidget,
      );
      expect(buttonNamed(tester, 'Archive and sign out').onPressed, isNull);

      await tester.enterText(field(0), 'ARCHIVE');
      await tester.pump();
      await tester.tap(find.text('Archive and sign out'));
      await settle(tester);

      expect(world.session.state.phase, SessionPhase.signedOut);
      expect(world.session.state.farewell, isA<ArchivedFarewell>());
    });

    testWidgets('a failed rename keeps the screen, signed in', (
      WidgetTester tester,
    ) async {
      await pumpFlow(
        tester,
        ArchivePage(now: () => DateTime.utc(2026, 10, 29, 14, 32)),
      );
      world.storage.failures['detach:google'] = const Failure.storageError(
        StorageError.driveRenameFailed,
      );
      await tester.enterText(field(0), 'ARCHIVE');
      await tester.pump();
      await tester.tap(find.text('Archive and sign out'));
      await settle(tester);

      expect(
        find.text(
          'Could not rename your vault file in Google Drive. Nothing was '
          'changed — please try again.',
        ),
        findsOneWidget,
      );
      expect(world.session.state.phase, SessionPhase.ready);
    });
  });
}
