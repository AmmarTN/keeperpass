import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/lock_reason.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';

import '../../../../helpers/fake_vault_layer.dart';

class ExpiredAuth extends FakeAuthRepository {
  @override
  Future<Either<Failure, RememberedSession?>> restoreSession() async =>
      const Right(RememberedSession(account: kJane, expired: true));
}

void main() {
  late FakeAuthRepository auth;
  late FakeStorageRepository storage;
  late VaultSessionService vault;
  late SessionCubit cubit;

  setUp(() {
    auth = FakeAuthRepository();
    storage = FakeStorageRepository();
    vault = VaultSessionService();
    cubit = buildSessionCubit(auth, storage, vault);
  });

  tearDown(() => cubit.close());

  Future<void> storeVault(String secret) async {
    storage.files[ProviderId.google] = await FakeVaultCipher().encrypt(
      secret,
      VaultSnapshot.empty(vaultName: 'Work').toVaultJson(),
    );
  }

  group('restore at launch (D10)', () {
    test('a remembered sign-in goes straight to the secret', () async {
      await cubit.restore();
      expect(cubit.state.phase, SessionPhase.awaitingSecret);
      expect(cubit.state.account, kJane);
      expect(cubit.state.restored, isTrue);
    });

    test('nothing remembered: signed out', () async {
      auth.current = null;
      await cubit.restore();
      expect(cubit.state.phase, SessionPhase.signedOut);
      expect(cubit.state.account, isNull);
    });

    test('an expired one greets the account (U2-Connect)', () async {
      final SessionCubit expired = buildSessionCubit(
        ExpiredAuth(),
        storage,
        vault,
      );
      await expired.restore();
      expect(expired.state.phase, SessionPhase.signedOut);
      expect(expired.state.expired, isTrue);
      expect(expired.state.account, kJane);
      await expired.close();
    });
  });

  test('signing in leads to the secret; cancelling changes nothing', () async {
    auth.current = null;
    await cubit.restore();

    auth.signInResult = const Left(Failure.signInCancelled());
    await cubit.signIn(ProviderId.dropbox);
    expect(cubit.state.phase, SessionPhase.signedOut);
    expect(cubit.state.failure, const Failure.signInCancelled());
    expect(cubit.state.status.statusType, CubitStatusType.failure);
    expect(cubit.state.signingIn, isNull);

    auth.signInResult = null;
    await cubit.signIn(ProviderId.dropbox);
    expect(cubit.state.phase, SessionPhase.awaitingSecret);
    expect(cubit.state.account?.provider, ProviderId.dropbox);
  });

  group('checking the vault', () {
    setUp(() => cubit.restore());

    test('found → unlock, not found → create', () async {
      await cubit.checkVault();
      expect(cubit.state.hasVault, isFalse);

      await storeVault('pw');
      await cubit.checkVault();
      expect(cubit.state.hasVault, isTrue);
      expect(cubit.state.vaultFile?.modifiedAt, DateTime.utc(2026, 10, 28));
    });

    test('offline keeps the session, for a retry', () async {
      storage.failures['find:google'] = const Failure.networkFailure(
        NetworkFailure.noInternetConnection(),
      );
      await cubit.checkVault();
      expect(cubit.state.phase, SessionPhase.awaitingSecret);
      expect(cubit.state.status.statusType, CubitStatusType.failure);
    });

    test('an expired session signs out but keeps who to greet', () async {
      auth.tokenFailure = const Failure.storageAuthExpired(ProviderId.google);
      await cubit.checkVault();
      expect(cubit.state.phase, SessionPhase.signedOut);
      expect(cubit.state.expired, isTrue);
      expect(cubit.state.account, kJane);
      expect(auth.expiredMarks, 1);
    });
  });

  group('the secret', () {
    setUp(() async {
      await cubit.restore();
      await storeVault('pw');
    });

    test(
      'opens the vault; a wrong one is reported and the field kept',
      () async {
        await cubit.unlock('guess');
        expect(cubit.state.phase, SessionPhase.awaitingSecret);
        expect(cubit.state.failure, const Failure.wrongSecret());
        expect(
          cubit.state.status.errorMsg,
          'Incorrect secret. Please try again.',
        );

        await cubit.unlock('pw');
        expect(cubit.state.phase, SessionPhase.ready);
        expect(vault.isOpen, isTrue);
      },
    );

    test('locking wipes the vault and says why', () async {
      await cubit.unlock('pw');
      cubit.lock(LockReason.inactivity);
      expect(cubit.state.phase, SessionPhase.awaitingSecret);
      expect(cubit.state.lockReason, LockReason.inactivity);
      expect(vault.isOpen, isFalse);
      expect(cubit.state.account, kJane);
    });

    test('a vault opened by Create or Start a new vault makes it ready', () {
      cubit.vaultOpened();
      expect(cubit.state.phase, SessionPhase.ready);
      expect(cubit.state.hasVault, isTrue);
    });

    test(
      'an expiry reported by a page signs out, greeting the account',
      () async {
        await cubit.sessionExpired(
          const Failure.storageAuthExpired(ProviderId.google),
        );
        expect(cubit.state.phase, SessionPhase.signedOut);
        expect(cubit.state.expired, isTrue);
        expect(cubit.state.account, kJane);
      },
    );
  });

  test('sign out and archive end the session', () async {
    await cubit.restore();
    await storeVault('pw');
    await cubit.unlock('pw');

    await cubit.archiveVault();
    expect(cubit.state.phase, SessionPhase.signedOut);
    expect(
      cubit.state.farewell,
      const SessionFarewell.archived(
        provider: ProviderId.google,
        renamedFile: 'vault.removed-2026-10-29T14-32-00.json.enc',
      ),
    );
    expect(auth.signOuts, 1);

    auth.current = kJane;
    await cubit.restore();
    await cubit.signOut();
    expect(cubit.state.phase, SessionPhase.signedOut);
    expect(cubit.state.account, isNull);
  });
  test('a moved vault signs out at once, saying where it went', () async {
    await cubit.restore();
    await storeVault('pw');
    await cubit.unlock('pw');

    const SessionFarewell moved = SessionFarewell.moved(
      from: ProviderId.google,
      to: ProviderId.dropbox,
    );
    await cubit.vaultMoved(moved);
    expect(cubit.state.phase, SessionPhase.signedOut);
    expect(cubit.state.farewell, moved);
    expect(auth.signOuts, 1);
  });
}
