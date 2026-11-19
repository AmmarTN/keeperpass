import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/usecases/generator/generate_secret.dart';
import 'package:keeperpass/core/usecases/vault/create_vault.dart';
import 'package:keeperpass/core/usecases/vault/encrypt_new_vault.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/features/create_vault/cubit/create_vault_cubit.dart';

import '../../../helpers/fake_vault_layer.dart';
import '../../../helpers/screen_states.dart';

void main() {
  const String strong = 'violet-anchor-quietly-orbit-meadow';

  late FakeAuthRepository auth;
  late FakeStorageRepository storage;
  late VaultSessionService vault;
  late CountingCipher cipher;
  late SessionCubit session;
  late CreateVaultCubit cubit;

  setUp(() async {
    auth = FakeAuthRepository();
    storage = FakeStorageRepository();
    vault = VaultSessionService();
    cipher = CountingCipher();
    session = buildSessionCubit(auth, storage, vault);
    await session.restore();
    cubit = CreateVaultCubit(
      session,
      GenerateSecret(FakeBundledData()),
      EncryptNewVault(cipher),
      CreateVault(auth, storage, vault),
    );
  });

  tearDown(() async {
    await cubit.close();
    await session.close();
  });

  Future<void> reachStep3() async {
    cubit
      ..setSecret(strong)
      ..next()
      ..setRepeat(strong)
      ..next();
  }

  test('a typed secret: choose, type again, write down', () async {
    expect(cubit.state.canContinue, isFalse);
    cubit.setSecret(strong);
    expect(cubit.state.stepNumber, 1);
    expect(cubit.state.weak, isFalse);

    cubit.next();
    expect(cubit.state.step, CreateStep.repeat);
    expect(cubit.state.stepNumber, 2);

    cubit.setRepeat('violet');
    expect(cubit.state.mismatch, isTrue);
    expect(cubit.state.canContinue, isFalse);
    cubit.next();
    expect(cubit.state.step, CreateStep.repeat);

    cubit
      ..setRepeat(strong)
      ..next();
    expect(cubit.state.step, CreateStep.writeDown);
    expect(cubit.state.stepNumber, 3);
    expect(cubit.state.canContinue, isFalse);

    cubit.setAcknowledged(true);
    expect(cubit.state.canContinue, isTrue);
  });

  test('a weak secret warns but never blocks', () {
    cubit.setSecret('abc');

    expect(cubit.state.weak, isTrue);
    expect(cubit.state.canContinue, isTrue);
  });

  test('a generated secret is five words and skips typing it again', () async {
    await cubit.generate();

    final List<String> words = cubit.state.secret.split('-');
    expect(words, hasLength(GenerateSecret.wordCount));
    expect(cubit.state.generated, isTrue);
    expect(cubit.state.repeat, cubit.state.secret);
    expect(cubit.state.generation, 1);

    cubit.next();
    expect(cubit.state.step, CreateStep.writeDown);
    cubit.back();
    expect(cubit.state.step, CreateStep.secret);
  });

  test('editing the secret starts the later steps over', () async {
    await cubit.generate();
    cubit
      ..next()
      ..setAcknowledged(true)
      ..back()
      ..setSecret('something else');

    expect(cubit.state.generated, isFalse);
    expect(cubit.state.repeat, isEmpty);
    expect(cubit.state.acknowledged, isFalse);
  });

  test('Back from step 3 of a typed secret returns to step 2', () async {
    await reachStep3();

    cubit.back();

    expect(cubit.state.step, CreateStep.repeat);
  });

  test('Create vault encrypts, saves and opens the vault', () async {
    await reachStep3();
    cubit.setAcknowledged(true);
    final List<CreateVaultState> states = <CreateVaultState>[];
    cubit.stream.listen(states.add);

    await cubit.create();
    // The stream hands states over a microtask later.
    await Future<void>.delayed(Duration.zero);

    expect(
      states.map((CreateVaultState s) => (s.step, s.stage)),
      containsAllInOrder(<(CreateStep, CreateStage)>[
        (CreateStep.working, CreateStage.encrypting),
        (CreateStep.working, CreateStage.saving),
        (CreateStep.done, CreateStage.saving),
      ]),
    );
    expect(storage.files[ProviderId.google], isNotNull);
    expect(vault.secret, strong);
    expect(session.state.phase, SessionPhase.ready);
    expect(session.state.hasVault, isTrue);
  });

  test('Try again after a failed save only uploads', () async {
    await reachStep3();
    cubit.setAcknowledged(true);
    storage.failures['save:google'] = const Failure.networkFailure(
      NetworkFailure.sendTimeout(),
    );

    await cubit.create();
    expect(cubit.state.step, CreateStep.failed);
    expect(cubit.state.failure, isNotNull);
    expect(session.state.phase, SessionPhase.awaitingSecret);

    storage.failures.clear();
    await cubit.create();
    expect(cubit.state.step, CreateStep.done);
    expect(cipher.encryptions, 1);
  });

  test('a new secret after a failure is encrypted again', () async {
    await reachStep3();
    cubit.setAcknowledged(true);
    storage.failures['save:google'] = const Failure.networkFailure(
      NetworkFailure.sendTimeout(),
    );
    await cubit.create();

    cubit
      ..backToSecret()
      ..setSecret('$strong-two');
    expect(cubit.state.step, CreateStep.secret);
    storage.failures.clear();
    await cubit.create();

    expect(cipher.encryptions, 2);
    expect(vault.secret, '$strong-two');
  });

  test('an expired session while saving leaves for Welcome', () async {
    await reachStep3();
    cubit.setAcknowledged(true);
    auth.tokenFailure = const Failure.storageAuthExpired(ProviderId.google);

    await cubit.create();

    expect(session.state.phase, SessionPhase.signedOut);
    expect(session.state.expired, isTrue);
    expect(vault.isOpen, isFalse);
  });

  test('Disconnect forgets the sign-in', () async {
    await cubit.disconnect();

    expect(auth.signOuts, 1);
    expect(session.state.phase, SessionPhase.signedOut);
  });
}
