import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/features/create_vault/cubit/create_vault_cubit.dart';
import 'package:keeperpass/presentation/features/create_vault/pages/create_vault_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/screen_states.dart';

void main() {
  const String strong = 'violet-anchor-quietly-orbit-meadow';
  const String words = 'eggplant-twenty-oboe-decree-daringly';

  late ScreenWorld world;

  Future<void> pumpCreate(
    WidgetTester tester, {
    Brightness brightness = Brightness.light,
  }) async {
    world = ScreenWorld();
    await world.restore();
    addTearDown(() => tester.runAsync(world.close));
    await pumpScreen(
      tester,
      const CreateVaultPage(),
      providers: world.providers,
      brightness: brightness,
    );
  }

  Future<void> show(WidgetTester tester, CreateVaultState state) async {
    world.create.show(state);
    // The state arrives a microtask later; then the switcher cross-fades.
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  AppButton button(WidgetTester tester, String label) =>
      tester.widget<AppButton>(find.widgetWithText(AppButton, label));

  Future<void> tapButton(WidgetTester tester, String label) async {
    await tester.ensureVisible(find.widgetWithText(AppButton, label));
    await tester.tap(find.widgetWithText(AppButton, label));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
  }

  for (final Brightness brightness in Brightness.values) {
    testWidgets('step 1 asks for a secret (${brightness.name})', (
      WidgetTester tester,
    ) async {
      await pumpCreate(tester, brightness: brightness);

      expect(find.text('STEP 1 OF 3'), findsOneWidget);
      expect(find.text('Choose Your Secret'), findsOneWidget);
      expect(
        find.textContaining('jane@example.com', findRichText: true),
        findsOneWidget,
      );
      expect(find.text('Disconnect'), findsOneWidget);
      expect(find.text('Choosing a good secret'), findsOneWidget);
      expect(button(tester, 'Continue').onPressed, isNull);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a typed secret: three steps, then the vault is made', (
    WidgetTester tester,
  ) async {
    await pumpCreate(tester);

    await tester.enterText(find.byType(EditableText), strong);
    await tester.pump();
    await tapButton(tester, 'Continue');
    expect(find.text('Type It Again'), findsOneWidget);
    expect(find.text('STEP 2 OF 3'), findsOneWidget);

    await tester.enterText(find.byType(EditableText), 'violet');
    await tester.pump();
    expect(find.text('The two secrets do not match.'), findsOneWidget);
    expect(button(tester, 'Continue').onPressed, isNull);

    await tester.enterText(find.byType(EditableText), strong);
    await tester.pump();
    await tapButton(tester, 'Continue');
    expect(find.text('Write It Down'), findsOneWidget);
    expect(find.text('YOUR SECRET'), findsOneWidget);
    expect(find.text(strong), findsNothing);
    expect(button(tester, 'Create vault').onPressed, isNull);

    await tester.ensureVisible(find.text('I’ve written my secret down'));
    await tester.tap(find.text('I’ve written my secret down'));
    await tester.pump();
    await tapButton(tester, 'Create vault');
    await tester.pump(const Duration(milliseconds: 400));

    expect(world.create.state.step, CreateStep.done);
    expect(world.storage.files[ProviderId.google], isNotNull);
    expect(world.session.state.phase, SessionPhase.ready);
  });

  testWidgets('a generated secret skips step 2 and shows its words', (
    WidgetTester tester,
  ) async {
    await pumpCreate(tester);

    await tapButton(tester, 'Generate a secret');
    expect(find.text('Generate another'), findsOneWidget);
    expect(
      find.text('Generated secrets skip the retype step.'),
      findsOneWidget,
    );

    await tapButton(tester, 'Continue');
    expect(find.text('STEP 3 OF 3'), findsOneWidget);
    expect(find.text('YOUR SECRET · 5 WORDS'), findsOneWidget);
    expect(find.text('••••••'), findsNWidgets(5));

    await tester.tap(find.text('Show'));
    await tester.pump();
    for (final String word in world.create.state.secret.split('-')) {
      expect(find.text(word), findsWidgets);
    }

    await tester.tap(find.text('Back'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('STEP 1 OF 3'), findsOneWidget);
  });

  testWidgets('a weak secret warns, and Continue stays live', (
    WidgetTester tester,
  ) async {
    await pumpCreate(tester);

    await tester.enterText(find.byType(EditableText), 'jane1992');
    await tester.pump();

    expect(find.textContaining('This secret is weak'), findsOneWidget);
    expect(button(tester, 'Continue').onPressed, isNotNull);
  });

  testWidgets('making the vault: encrypting, then saving', (
    WidgetTester tester,
  ) async {
    await pumpCreate(tester);

    await show(tester, const CreateVaultState(step: CreateStep.working));
    expect(find.text('Creating your vault'), findsOneWidget);
    expect(find.text('Encrypting your vault…'), findsOneWidget);
    expect(find.text('Encrypting on this phone…'), findsOneWidget);

    await show(
      tester,
      const CreateVaultState(
        step: CreateStep.working,
        stage: CreateStage.saving,
      ),
    );
    expect(find.text('Saving to Google Drive…'), findsWidgets);
    expect(
      find.text('One encrypted file, in the keeperpass folder.'),
      findsOneWidget,
    );
  });

  testWidgets('a failed save keeps the secret: Back to your secret', (
    WidgetTester tester,
  ) async {
    await pumpCreate(tester, brightness: Brightness.dark);

    await show(
      tester,
      const CreateVaultState(
        step: CreateStep.failed,
        stage: CreateStage.saving,
        secret: words,
        generated: true,
        repeat: words,
        failure: Failure.networkFailure(NetworkFailure.sendTimeout()),
      ),
    );
    expect(find.text('Could not save your vault'), findsOneWidget);
    expect(find.text('Not saved'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);

    await tapButton(tester, 'Back to your secret');
    expect(find.text('STEP 1 OF 3'), findsOneWidget);
    expect(world.create.state.secret, words);
  });
}
