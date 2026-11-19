import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/core/enums/lock_reason.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/settings/get_auto_lock_delay.dart';
import 'package:keeperpass/core/usecases/settings/save_auto_lock_delay.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/lock_settings_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/lock/lock_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

import '../../../../helpers/fake_vault_layer.dart';

class FakeLockSettings implements ILockSettingsRepository {
  AutoLockDelay? saved;

  @override
  Future<Either<Failure, AutoLockDelay>> getAutoLockDelay() async =>
      Right(saved ?? AutoLockDelay.standard);

  @override
  Future<Either<Failure, Unit>> saveAutoLockDelay(AutoLockDelay delay) async {
    saved = delay;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, ClipboardClearDelay>> getClipboardClearDelay() async =>
      const Right(ClipboardClearDelay.standard);

  @override
  Future<Either<Failure, Unit>> saveClipboardClearDelay(
    ClipboardClearDelay delay,
  ) async => const Right(unit);

  @override
  Future<Either<Failure, bool>> getHideInSwitcher() async => const Right(true);

  @override
  Future<Either<Failure, Unit>> saveHideInSwitcher(bool hide) async =>
      const Right(unit);

  @override
  Future<Either<Failure, bool>> getBlockScreenshots() async =>
      const Right(true);

  @override
  Future<Either<Failure, Unit>> saveBlockScreenshots(bool block) async =>
      const Right(unit);
}

/// The web's `AutoLockService`, with the phone's lifecycle (board
/// `Settings`: immediately on leaving, or after 1, 5 or 10 minutes).
void main() {
  late DateTime clock;
  late FakeLockSettings settings;
  late VaultSessionService vault;
  late LockService lock;
  late SessionCubit session;
  late LockCubit cubit;

  Future<void> setUpReady(WidgetTester tester, {AutoLockDelay? delay}) async {
    clock = DateTime.utc(2026, 10, 30, 9);
    settings = FakeLockSettings()..saved = delay;
    vault = VaultSessionService();
    lock = LockService(now: () => clock);
    final FakeStorageRepository storage = FakeStorageRepository();
    storage.files[ProviderId.google] = await FakeVaultCipher().encrypt(
      'pw',
      VaultSnapshot.empty(vaultName: 'Work').toVaultJson(),
    );
    session = buildSessionCubit(
      FakeAuthRepository(),
      storage,
      vault,
      lock: lock,
    );
    cubit = LockCubit(
      session,
      lock,
      GetAutoLockDelay(settings),
      SaveAutoLockDelay(settings),
      now: () => clock,
    );
    await cubit.start(watchLifecycle: false);
    await session.restore();
    await session.unlock('pw');
    await tester.pump();
  }

  Future<void> pass(WidgetTester tester, Duration duration) async {
    clock = clock.add(duration);
    await tester.pump(duration);
  }

  /// Closing awaits stream shutdown, which only completes outside the
  /// fake clock.
  Future<void> tearDownCubits(WidgetTester tester) => tester.runAsync(() async {
    await cubit.close();
    await session.close();
  });

  testWidgets('locks after 10 minutes without use, the default', (
    WidgetTester tester,
  ) async {
    await setUpReady(tester);
    expect(cubit.state, AutoLockDelay.tenMinutes);

    await pass(tester, const Duration(minutes: 9));
    expect(session.state.phase, SessionPhase.ready);

    cubit.recordActivity();
    await pass(tester, const Duration(minutes: 9));
    expect(session.state.phase, SessionPhase.ready);

    await pass(tester, const Duration(minutes: 1));
    expect(session.state.phase, SessionPhase.awaitingSecret);
    expect(session.state.lockReason, LockReason.inactivity);
    expect(vault.isOpen, isFalse);
    await tearDownCubits(tester);
  });

  testWidgets('"Immediately" locks on leaving the app', (
    WidgetTester tester,
  ) async {
    await setUpReady(tester, delay: AutoLockDelay.immediately);
    await pass(tester, const Duration(hours: 1));
    expect(session.state.phase, SessionPhase.ready);

    cubit.appHidden();
    expect(session.state.lockReason, LockReason.leftApp);
    expect(session.state.phase, SessionPhase.awaitingSecret);
    await tearDownCubits(tester);
  });

  testWidgets(
    'leaving for a screen the app opened (a provider sign-in) never locks',
    (WidgetTester tester) async {
      await setUpReady(tester, delay: AutoLockDelay.immediately);
      final Completer<void> browser = Completer<void>();
      final Future<void> signIn = lock.duringExternalUi(() => browser.future);

      cubit.appHidden();
      await pass(tester, const Duration(minutes: 20));
      cubit.appShown();
      browser.complete();
      await signIn;

      expect(session.state.phase, SessionPhase.ready);
      await tearDownCubits(tester);
    },
  );

  testWidgets('time away counts: back after the delay locks', (
    WidgetTester tester,
  ) async {
    await setUpReady(tester, delay: AutoLockDelay.fiveMinutes);

    cubit.appHidden();
    await pass(tester, const Duration(minutes: 2));
    cubit.appShown();
    expect(session.state.phase, SessionPhase.ready);

    cubit.appHidden();
    clock = clock.add(const Duration(minutes: 6));
    cubit.appShown();
    expect(session.state.phase, SessionPhase.awaitingSecret);
    expect(session.state.lockReason, LockReason.inactivity);
    await tearDownCubits(tester);
  });

  testWidgets('the choice is saved; Lock now locks at once', (
    WidgetTester tester,
  ) async {
    await setUpReady(tester);
    await cubit.setDelay(AutoLockDelay.oneMinute);
    expect(settings.saved, AutoLockDelay.oneMinute);

    await pass(tester, const Duration(minutes: 1));
    expect(session.state.lockReason, LockReason.inactivity);

    await session.unlock('pw');
    await tester.pump();
    cubit.lockNow();
    expect(session.state.lockReason, LockReason.manual);
    await tearDownCubits(tester);
  });
}
