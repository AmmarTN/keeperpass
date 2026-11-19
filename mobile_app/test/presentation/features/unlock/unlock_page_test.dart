import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/lock_reason.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/features/unlock/cubit/unlock_cubit.dart';
import 'package:keeperpass/presentation/features/unlock/pages/unlock_page.dart';

import '../../../helpers/fake_vault_layer.dart';
import '../../../helpers/screen_harness.dart';
import '../../../helpers/screen_states.dart';

void main() {
  late ScreenWorld world;

  setUp(() async {
    world = ScreenWorld();
    world.storage.files[ProviderId.google] = await FakeVaultCipher().encrypt(
      'correct horse',
      VaultSnapshot.empty(vaultName: 'Personal').toVaultJson(),
    );
    await world.restore();
  });

  Future<void> pumpUnlock(
    WidgetTester tester, {
    Brightness brightness = Brightness.light,
  }) async {
    addTearDown(() => tester.runAsync(world.close));
    await pumpScreen(
      tester,
      const UnlockPage(),
      providers: world.providers,
      brightness: brightness,
    );
  }

  AppButton unlockButton(WidgetTester tester) =>
      tester.widget<AppButton>(find.widgetWithText(AppButton, 'Unlock'));

  for (final Brightness brightness in Brightness.values) {
    testWidgets('shows who is unlocking (${brightness.name})', (
      WidgetTester tester,
    ) async {
      await pumpUnlock(tester, brightness: brightness);

      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('jane@example.com · Google Drive'), findsOneWidget);
      expect(find.text('Not you?'), findsOneWidget);
      expect(find.text('Forgot your secret?'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('Unlock wakes up once there is a secret, and opens the vault', (
    WidgetTester tester,
  ) async {
    await pumpUnlock(tester);
    expect(unlockButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(EditableText), 'correct horse');
    await tester.pump();
    expect(unlockButton(tester).onPressed, isNotNull);

    await tester.tap(find.widgetWithText(AppButton, 'Unlock'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(world.session.state.phase, SessionPhase.ready);
  });

  testWidgets('a wrong secret says so and keeps what was typed', (
    WidgetTester tester,
  ) async {
    await pumpUnlock(tester);

    await tester.enterText(find.byType(EditableText), 'wrong');
    await tester.testTextInput.receiveAction(TextInputAction.go);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));

    expect(find.text('Incorrect secret. Please try again.'), findsOneWidget);
    expect(world.unlock.state.wrongAttempts, 1);
    expect(
      tester.widget<EditableText>(find.byType(EditableText)).controller.text,
      'wrong',
    );
  });

  testWidgets('an unreachable file offers Retry', (WidgetTester tester) async {
    await pumpUnlock(tester);
    world.unlock.show(
      const UnlockState(
        status: UnlockStatus.unreachable,
        failure: Failure.networkFailure(NetworkFailure.receiveTimeout()),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Could not reach Google Drive'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('while unlocking: the status line and the slow note', (
    WidgetTester tester,
  ) async {
    await pumpUnlock(tester);
    world.unlock.show(const UnlockState(status: UnlockStatus.unlocking));
    await tester.pump();
    await tester.pump();

    expect(find.text('Unlocking on this phone…'), findsOneWidget);
    expect(find.text('Unlocking…'), findsOneWidget);
    expect(
      find.text(
        'A few seconds, on purpose: it makes guessing your secret slow.',
      ),
      findsOneWidget,
    );
    expect(find.text('Not you?'), findsNothing);
  });

  testWidgets('offline: a banner, and Unlock waits', (
    WidgetTester tester,
  ) async {
    await pumpUnlock(tester);
    await tester.enterText(find.byType(EditableText), 'correct horse');

    await world.goOffline();
    // Fires the cubit's confirmation timer, then rebuilds.
    await tester.pump(Duration.zero);
    await tester.pump();

    expect(find.text('You’re offline'), findsOneWidget);
    expect(
      find.text(
        'Unlocking needs a connection to Google Drive. '
        'Unlock wakes up when you’re back online.',
      ),
      findsOneWidget,
    );
    expect(unlockButton(tester).onPressed, isNull);

    // S6-10: Try again checks the connection; the secret typed is kept.
    world.network.connected = true;
    await tester.tap(find.text('Try again'));
    await tester.pump(Duration.zero);
    await tester.pump();
    expect(find.text('You’re offline'), findsNothing);
    expect(find.text('correct horse'), findsOneWidget);
    expect(unlockButton(tester).onPressed, isNotNull);
  });

  group('why it locked', () {
    Future<void> lockWith(WidgetTester tester, LockReason reason) async {
      await tester.runAsync(() => world.session.unlock('correct horse'));
      world.session.lock(reason);
      await pumpUnlock(tester);
    }

    testWidgets('after inactivity, with the delay', (
      WidgetTester tester,
    ) async {
      await lockWith(tester, LockReason.inactivity);

      expect(
        find.text('Locked after 10 minutes of inactivity'),
        findsOneWidget,
      );
    });

    testWidgets('one minute is singular', (WidgetTester tester) async {
      await world.lock.setDelay(AutoLockDelay.oneMinute);
      await lockWith(tester, LockReason.inactivity);

      expect(find.text('Locked after 1 minute of inactivity'), findsOneWidget);
    });

    testWidgets('after leaving the app', (WidgetTester tester) async {
      await lockWith(tester, LockReason.leftApp);

      expect(find.text('Locked when you left KeeperPass'), findsOneWidget);
    });

    testWidgets('Lock now: no line', (WidgetTester tester) async {
      await lockWith(tester, LockReason.manual);

      expect(find.textContaining('Locked'), findsNothing);
    });
  });
}
