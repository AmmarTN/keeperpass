import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/features/unlock/cubit/unlock_cubit.dart';

import '../../../helpers/fake_vault_layer.dart';

void main() {
  late FakeAuthRepository auth;
  late FakeStorageRepository storage;
  late VaultSessionService vault;
  late SessionCubit session;
  late UnlockCubit cubit;

  setUp(() async {
    auth = FakeAuthRepository();
    storage = FakeStorageRepository();
    vault = VaultSessionService();
    storage.files[ProviderId.google] = await FakeVaultCipher().encrypt(
      'correct horse',
      VaultSnapshot.empty(vaultName: 'Personal').toVaultJson(),
    );
    session = buildSessionCubit(auth, storage, vault);
    await session.restore();
    cubit = UnlockCubit(session);
  });

  tearDown(() async {
    await cubit.close();
    await session.close();
  });

  test('the right secret opens the vault', () async {
    await cubit.unlock('correct horse');

    expect(cubit.state.status, UnlockStatus.idle);
    expect(session.state.phase, SessionPhase.ready);
    expect(vault.isOpen, isTrue);
  });

  test('a wrong secret rings red each time', () async {
    await cubit.unlock('wrong');
    expect(cubit.state.status, UnlockStatus.wrongSecret);
    expect(cubit.state.failure, const Failure.wrongSecret());
    expect(cubit.state.wrongAttempts, 1);

    await cubit.unlock('still wrong');
    expect(cubit.state.wrongAttempts, 2);
    expect(session.state.phase, SessionPhase.awaitingSecret);
  });

  test('an unreachable file offers Retry', () async {
    storage.failures['load:google'] = const Failure.networkFailure(
      NetworkFailure.receiveTimeout(),
    );

    await cubit.unlock('correct horse');
    expect(cubit.state.status, UnlockStatus.unreachable);

    storage.failures.clear();
    await cubit.unlock('correct horse');
    expect(session.state.phase, SessionPhase.ready);
  });

  test('a damaged file is a plain failure', () async {
    storage.files[ProviderId.google] = '"not a vault"';

    await cubit.unlock('correct horse');

    expect(cubit.state.status, UnlockStatus.failed);
    expect(cubit.state.failure, const Failure.corruptVault());
  });

  test('an empty secret does nothing', () async {
    await cubit.unlock('');

    expect(cubit.state, const UnlockState());
    expect(storage.calls, isEmpty);
  });

  test('an expired session leaves for Welcome', () async {
    auth.tokenFailure = const Failure.storageAuthExpired(ProviderId.google);

    await cubit.unlock('correct horse');

    expect(cubit.state.status, UnlockStatus.idle);
    expect(session.state.phase, SessionPhase.signedOut);
    expect(session.state.expired, isTrue);
  });

  test('Disconnect forgets the sign-in', () async {
    await cubit.disconnect();

    expect(auth.signOuts, 1);
    expect(session.state.phase, SessionPhase.signedOut);
  });
}
