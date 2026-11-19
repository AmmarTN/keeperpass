import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/features/new_vault/cubit/new_vault_cubit.dart';
import 'package:keeperpass/presentation/features/new_vault/pages/new_vault_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/screen_states.dart';

void main() {
  const String secret = 'violet-anchor-quietly-orbit-meadow';
  const String backup = 'vault.backup-2026-10-29T14-32-00.json.enc';

  late ScreenWorld world;

  Future<void> pumpNewVault(
    WidgetTester tester, {
    Brightness brightness = Brightness.light,
  }) async {
    world = ScreenWorld();
    world.storage.files[ProviderId.google] = 'old vault';
    await world.restore();
    addTearDown(() => tester.runAsync(world.close));
    await pumpScreen(
      tester,
      const NewVaultPage(),
      providers: world.providers,
      brightness: brightness,
    );
  }

  Future<void> show(WidgetTester tester, NewVaultState state) async {
    world.newVault.show(state);
    // The state arrives a microtask later; then the switcher cross-fades.
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  Finder startButton() => find.widgetWithText(AppButton, 'Start a new vault');

  for (final Brightness brightness in Brightness.values) {
    testWidgets('names what it does, and what is kept (${brightness.name})', (
      WidgetTester tester,
    ) async {
      await pumpNewVault(tester, brightness: brightness);

      expect(find.text('Start a New Vault'), findsOneWidget);
      expect(find.text('Old vault · locked under the old secret'), findsOne);
      expect(find.text('New vault · empty'), findsOneWidget);
      // On the old card, and in the second point.
      expect(find.textContaining(backup, findRichText: true), findsNWidgets(2));
      expect(
        find.textContaining('jane@example.com', findRichText: true),
        findsOneWidget,
      );
      expect(tester.widget<AppButton>(startButton()).onPressed, isNull);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('confirm, then the old file is kept and the new vault opens', (
    WidgetTester tester,
  ) async {
    await pumpNewVault(tester);

    final Finder fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), secret);
    await tester.pump();
    await tester.enterText(fields.at(1), 'violet');
    await tester.pump();
    expect(find.text('The two secrets do not match.'), findsOneWidget);

    await tester.enterText(fields.at(1), secret);
    await tester.pump();
    await tester.ensureVisible(startButton());
    await tester.tap(startButton());
    await tester.pumpAndSettle();

    expect(find.text('Start a New Vault?'), findsOneWidget);
    expect(find.text('Cancel'), findsOneWidget);
    await tester.tap(startButton().last);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(world.newVault.state.step, NewVaultStep.done);
    expect(world.storage.backups, hasLength(1));
    expect(world.storage.files[ProviderId.google], isNot('old vault'));
    expect(world.session.state.phase, SessionPhase.ready);
    expect(find.text('New vault started'), findsOneWidget);
    expect(
      find.text('Your old vault is kept as a backup in Google Drive.'),
      findsOneWidget,
    );
    await tester.pump(const Duration(seconds: 5));
  });

  testWidgets('Cancel changes nothing', (WidgetTester tester) async {
    await pumpNewVault(tester);
    final Finder fields = find.byType(EditableText);
    await tester.enterText(fields.at(0), secret);
    await tester.enterText(fields.at(1), secret);
    await tester.pump();
    await tester.ensureVisible(startButton());
    await tester.tap(startButton());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(world.newVault.state.step, NewVaultStep.form);
    expect(world.storage.calls, isEmpty);
  });

  testWidgets('keeping the old vault: its card is renamed', (
    WidgetTester tester,
  ) async {
    await pumpNewVault(tester);

    await show(
      tester,
      NewVaultState(
        backupAt: DateTime.utc(2026, 10, 29, 14, 32),
        step: NewVaultStep.working,
        stage: NewVaultStage.backingUp,
      ),
    );

    expect(find.text('Starting a new vault'), findsOneWidget);
    // The step, and the old card's line.
    expect(find.text('Keeping your old vault as a backup…'), findsNWidgets(2));
    expect(find.text('Renaming it in Google Drive.'), findsOneWidget);
    expect(find.text(backup), findsOneWidget);
  });

  testWidgets('a failed backup: nothing was changed', (
    WidgetTester tester,
  ) async {
    await pumpNewVault(tester, brightness: Brightness.dark);

    await show(
      tester,
      NewVaultState(
        backupAt: DateTime.utc(2026, 10, 29, 14, 32),
        step: NewVaultStep.failed,
        stage: NewVaultStage.backingUp,
        failure: const Failure.storageError(StorageError.driveBackupFailed),
      ),
    );

    expect(find.text('Nothing was changed'), findsOneWidget);
    expect(
      find.text(
        'Could not back up your existing vault in Google Drive. '
        'Nothing was changed.',
      ),
      findsOneWidget,
    );
    expect(find.text('Try again'), findsOneWidget);
    expect(find.text('Back to unlock'), findsOneWidget);
  });
}
