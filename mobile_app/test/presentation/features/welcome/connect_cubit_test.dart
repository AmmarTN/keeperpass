import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/usecases/common/get_relative_time_formatter.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/features/welcome/cubit/connect_cubit.dart';

import '../../../helpers/fake_vault_layer.dart';
import '../../../helpers/screen_states.dart';

void main() {
  late FakeAuthRepository auth;
  late FakeStorageRepository storage;
  late SessionCubit session;
  late ConnectCubit cubit;
  late List<ConnectState> states;

  setUp(() async {
    auth = FakeAuthRepository()..current = null;
    storage = FakeStorageRepository();
    session = buildSessionCubit(auth, storage, VaultSessionService());
    await session.restore();
    cubit = ConnectCubit(
      session,
      GetRelativeTimeFormatter(FakeBundledData()),
      LinkService(),
      now: () => DateTime.utc(2026, 10, 30),
      foundBeat: Duration.zero,
    );
    states = <ConnectState>[];
    cubit.stream.listen(states.add);
  });

  tearDown(() async {
    await cubit.close();
    await session.close();
  });

  test('a vault on the drive: found, then Unlock (U2-Connect)', () async {
    storage.files[ProviderId.google] = 'stored';

    await cubit.signIn(ProviderId.google);

    expect(
      states.map((ConnectState s) => s.stage),
      containsAllInOrder(<ConnectStage>[
        ConnectStage.signingIn,
        ConnectStage.checking,
        ConnectStage.found,
      ]),
    );
    expect(states.first.signingIn, ProviderId.google);
    expect(cubit.state.foundMeta, 'Found in Google Drive · updated 2 days ago');
    expect(cubit.state.destination, ConnectDestination.unlock);
    expect(session.state.phase, SessionPhase.awaitingSecret);

    cubit.destinationHandled();
    expect(cubit.state.destination, isNull);
  });

  test('no vault yet: straight to Create', () async {
    await cubit.signIn(ProviderId.dropbox);

    expect(cubit.state.destination, ConnectDestination.create);
    expect(
      states.map((ConnectState s) => s.stage),
      isNot(contains(ConnectStage.found)),
    );
    expect(session.state.hasVault, isFalse);
  });

  test('a closed provider page counts a cancel, nothing else', () async {
    auth.signInResult = const Left(Failure.signInCancelled());

    await cubit.signIn(ProviderId.google);

    expect(cubit.state.stage, ConnectStage.idle);
    expect(cubit.state.cancelled, 1);
    expect(cubit.state.signInFailure, isNull);
    expect(cubit.state.signingIn, isNull);
    expect(session.state.phase, SessionPhase.signedOut);
  });

  test('a failed sign-in is kept for the banner', () async {
    auth.signInResult = const Left(Failure.signInFailed(ProviderId.dropbox));

    await cubit.signIn(ProviderId.dropbox);

    expect(cubit.state.stage, ConnectStage.idle);
    expect(
      cubit.state.signInFailure,
      const Failure.signInFailed(ProviderId.dropbox),
    );
    expect(cubit.state.cancelled, 0);
  });

  test('an unreadable drive offers Try again, which checks again', () async {
    storage.failures['find:google'] = const Failure.networkFailure(
      NetworkFailure.noInternetConnection(),
    );

    await cubit.signIn(ProviderId.google);
    expect(cubit.state.stage, ConnectStage.checkFailed);
    expect(cubit.state.destination, isNull);

    storage.failures.clear();
    await cubit.retryCheck();
    expect(cubit.state.destination, ConnectDestination.create);
  });

  test('an expired session while checking greets the account again', () async {
    await cubit.signIn(ProviderId.google);
    cubit.destinationHandled();
    auth.tokenFailure = const Failure.storageAuthExpired(ProviderId.google);

    await cubit.retryCheck();

    expect(cubit.state, const ConnectState());
    expect(session.state.phase, SessionPhase.signedOut);
    expect(session.state.expired, isTrue);
    expect(session.state.account, kJane);
  });

  test('Use another account signs out and shows both providers', () async {
    storage.failures['find:google'] = const Failure.networkFailure(
      NetworkFailure.noInternetConnection(),
    );
    await cubit.signIn(ProviderId.google);

    await cubit.useAnotherAccount();

    expect(cubit.state, const ConnectState());
    expect(auth.signOuts, 1);
    expect(session.state.phase, SessionPhase.signedOut);
  });

  test('a second tap while signing in is ignored', () async {
    final Future<void> first = cubit.signIn(ProviderId.google);
    await cubit.signIn(ProviderId.dropbox);
    await first;

    expect(auth.current?.provider, ProviderId.google);
  });
}
