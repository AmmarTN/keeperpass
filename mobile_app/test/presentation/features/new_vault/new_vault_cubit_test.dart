import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/usecases/generator/generate_secret.dart';
import 'package:keeperpass/core/usecases/vault/encrypt_new_vault.dart';
import 'package:keeperpass/core/usecases/vault/reset_vault.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/features/new_vault/cubit/new_vault_cubit.dart';

import '../../../helpers/fake_vault_layer.dart';
import '../../../helpers/screen_states.dart';

void main() {
  const String secret = 'violet-anchor-quietly-orbit-meadow';
  final DateTime started = DateTime.utc(2026, 10, 29, 14, 32);

  late FakeAuthRepository auth;
  late FakeStorageRepository storage;
  late VaultSessionService vault;
  late CountingCipher cipher;
  late SessionCubit session;
  late NewVaultCubit cubit;
  late DateTime now;

  setUp(() async {
    auth = FakeAuthRepository();
    storage = FakeStorageRepository()..files[ProviderId.google] = 'old vault';
    vault = VaultSessionService();
    cipher = CountingCipher();
    now = DateTime.utc(2026, 10, 29, 14);
    session = buildSessionCubit(auth, storage, vault);
    await session.restore();
    cubit = NewVaultCubit(
      session,
      GenerateSecret(FakeBundledData()),
      EncryptNewVault(cipher),
      ResetVault(auth, storage, vault),
      now: () => now,
    );
  });

  tearDown(() async {
    await cubit.close();
    await session.close();
  });

  test('both fields, matching, are needed to start', () {
    expect(cubit.state.canStart, isFalse);
    cubit.setSecret(secret);
    expect(cubit.state.canStart, isFalse);
    cubit.setRepeat('violet');
    expect(cubit.state.mismatch, isTrue);
    expect(cubit.state.canStart, isFalse);
    cubit.setRepeat(secret);
    expect(cubit.state.canStart, isTrue);
  });

  test('Generate fills both fields', () async {
    await cubit.generate();

    expect(cubit.state.secret.split('-'), hasLength(5));
    expect(cubit.state.repeat, cubit.state.secret);
    expect(cubit.state.canStart, isTrue);
  });

  test('the old file is kept under a dated name', () {
    expect(cubit.state.backupName, 'vault.backup-2026-10-29T14-00-00.json.enc');
  });

  test('Start: encrypt, keep the old file, save the new one', () async {
    cubit
      ..setSecret(secret)
      ..setRepeat(secret);
    now = started;
    final List<NewVaultState> states = <NewVaultState>[];
    cubit.stream.listen(states.add);

    await cubit.start();
    // The stream hands states over a microtask later.
    await Future<void>.delayed(Duration.zero);

    expect(
      states.map((NewVaultState s) => (s.step, s.stage)),
      containsAllInOrder(<(NewVaultStep, NewVaultStage)>[
        (NewVaultStep.working, NewVaultStage.encrypting),
        (NewVaultStep.working, NewVaultStage.backingUp),
        (NewVaultStep.working, NewVaultStage.saving),
        (NewVaultStep.done, NewVaultStage.saving),
      ]),
    );
    expect(storage.backups, <DateTime>[started]);
    expect(cubit.state.backupName, 'vault.backup-2026-10-29T14-32-00.json.enc');
    expect(storage.files[ProviderId.google], isNot('old vault'));
    expect(vault.secret, secret);
    expect(session.state.phase, SessionPhase.ready);
  });

  test('a failed backup changes nothing; Try again reuses the vault', () async {
    cubit
      ..setSecret(secret)
      ..setRepeat(secret);
    storage.failures['reset:google'] = const Failure.networkFailure(
      NetworkFailure.sendTimeout(),
    );

    await cubit.start();
    expect(cubit.state.step, NewVaultStep.failed);
    expect(cubit.state.stage, NewVaultStage.backingUp);
    expect(storage.files[ProviderId.google], 'old vault');
    expect(session.state.phase, SessionPhase.awaitingSecret);

    storage.failures.clear();
    await cubit.start();
    expect(cubit.state.step, NewVaultStep.done);
    expect(cipher.encryptions, 1);
  });

  test('an expired session leaves for Welcome', () async {
    cubit
      ..setSecret(secret)
      ..setRepeat(secret);
    auth.tokenFailure = const Failure.storageAuthExpired(ProviderId.google);

    await cubit.start();

    expect(session.state.phase, SessionPhase.signedOut);
    expect(session.state.expired, isTrue);
    expect(vault.isOpen, isFalse);
  });

  test('nothing starts without a matching secret', () async {
    cubit.setSecret(secret);

    await cubit.start();

    expect(cubit.state.step, NewVaultStep.form);
    expect(storage.calls, isEmpty);
  });
}
