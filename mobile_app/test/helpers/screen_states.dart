import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/network/network_info.dart';
import 'package:keeperpass/core/usecases/common/get_relative_time_formatter.dart';
import 'package:keeperpass/core/usecases/generator/generate_secret.dart';
import 'package:keeperpass/core/usecases/settings/get_auto_lock_delay.dart';
import 'package:keeperpass/core/usecases/settings/save_auto_lock_delay.dart';
import 'package:keeperpass/core/usecases/vault/create_vault.dart';
import 'package:keeperpass/core/usecases/vault/encrypt_new_vault.dart';
import 'package:keeperpass/core/usecases/vault/reset_vault.dart';
import 'package:keeperpass/core/utils/icons/icon_catalog.dart';
import 'package:keeperpass/core/utils/text/relative_time.dart';
import 'package:keeperpass/infrastructure/repositories/bundled_data_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/lock_settings_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/link_service.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/lock/lock_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/features/create_vault/cubit/create_vault_cubit.dart';
import 'package:keeperpass/presentation/features/new_vault/cubit/new_vault_cubit.dart';
import 'package:keeperpass/presentation/features/unlock/cubit/unlock_cubit.dart';
import 'package:keeperpass/presentation/features/welcome/cubit/connect_cubit.dart';

import 'fake_vault_layer.dart';

/// Test-only cubits that can be put straight into any state, so a screen's
/// look and wording can be checked without walking the whole flow.

class FakeBundledData implements IBundledDataRepository {
  @override
  Future<Either<Failure, RelativeTimeFormatter>> relativeTime() async => Right(
    RelativeTimeFormatter(<String, dynamic>{
      'en': <String, dynamic>{
        'day': <String, dynamic>{'-2': '2 days ago'},
      },
    }),
  );

  @override
  Future<Either<Failure, List<String>>> wordList(String language) async =>
      const Right(<String>['eggplant', 'twenty', 'oboe', 'decree', 'daringly']);

  @override
  Future<Either<Failure, Map<String, dynamic>>> countryNames() async =>
      const Right(<String, dynamic>{
        'en': <String, dynamic>{'US': 'United States'},
      });

  @override
  Future<Either<Failure, List<CatalogIcon>>> iconCatalog() async =>
      const Right(<CatalogIcon>[]);
}

class StubConnectCubit extends ConnectCubit {
  StubConnectCubit(SessionCubit session)
    : super(
        session,
        GetRelativeTimeFormatter(FakeBundledData()),
        LinkService(),
      );

  void show(ConnectState state) => emit(state);
}

class StubUnlockCubit extends UnlockCubit {
  StubUnlockCubit(super.session);

  void show(UnlockState state) => emit(state);
}

class StubCreateVaultCubit extends CreateVaultCubit {
  StubCreateVaultCubit(
    SessionCubit session,
    FakeAuthRepository auth,
    FakeStorageRepository storage,
    VaultSessionService vault,
  ) : super(
        session,
        GenerateSecret(FakeBundledData()),
        EncryptNewVault(FakeVaultCipher()),
        CreateVault(auth, storage, vault),
      );

  void show(CreateVaultState state) => emit(state);
}

class StubNewVaultCubit extends NewVaultCubit {
  StubNewVaultCubit(
    SessionCubit session,
    FakeAuthRepository auth,
    FakeStorageRepository storage,
    VaultSessionService vault,
  ) : super(
        session,
        GenerateSecret(FakeBundledData()),
        EncryptNewVault(FakeVaultCipher()),
        ResetVault(auth, storage, vault),
        now: () => DateTime.utc(2026, 10, 29, 14, 32),
      );

  void show(NewVaultState state) => emit(state);
}

/// A connection that tests switch on and off.
class SwitchableNetwork implements NetworkInfo {
  bool connected = true;

  @override
  Future<bool> get isConnected async => connected;

  @override
  Stream<bool> get onConnectivityChanged => const Stream<bool>.empty();
}

/// Settings › Security in memory: the phone's defaults until changed.
class MemoryLockSettings implements ILockSettingsRepository {
  AutoLockDelay autoLock = AutoLockDelay.tenMinutes;
  ClipboardClearDelay clipboard = ClipboardClearDelay.standard;
  bool hideInSwitcher = true;
  bool blockScreenshots = true;

  @override
  Future<Either<Failure, AutoLockDelay>> getAutoLockDelay() async =>
      Right(autoLock);

  @override
  Future<Either<Failure, Unit>> saveAutoLockDelay(AutoLockDelay delay) async {
    autoLock = delay;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, ClipboardClearDelay>> getClipboardClearDelay() async =>
      Right(clipboard);

  @override
  Future<Either<Failure, Unit>> saveClipboardClearDelay(
    ClipboardClearDelay delay,
  ) async {
    clipboard = delay;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, bool>> getHideInSwitcher() async =>
      Right(hideInSwitcher);

  @override
  Future<Either<Failure, bool>> getBlockScreenshots() async =>
      Right(blockScreenshots);

  @override
  Future<Either<Failure, Unit>> saveBlockScreenshots(bool block) async {
    blockScreenshots = block;
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> saveHideInSwitcher(bool hide) async {
    hideInSwitcher = hide;
    return const Right(unit);
  }
}

LockCubit stubLockCubit(SessionCubit session) => LockCubit(
  session,
  LockService(),
  GetAutoLockDelay(MemoryLockSettings()),
  SaveAutoLockDelay(MemoryLockSettings()),
);

/// Everything a step-2 screen reads, ready to put in any state.
class ScreenWorld {
  ScreenWorld({FakeAuthRepository? auth}) : auth = auth ?? FakeAuthRepository();

  final FakeAuthRepository auth;
  final FakeStorageRepository storage = FakeStorageRepository();
  final VaultSessionService vault = VaultSessionService();
  final SwitchableNetwork network = SwitchableNetwork();
  late final SessionCubit session = buildSessionCubit(auth, storage, vault);
  late final StubConnectCubit connect = StubConnectCubit(session);
  late final StubUnlockCubit unlock = StubUnlockCubit(session);
  late final StubCreateVaultCubit create = StubCreateVaultCubit(
    session,
    auth,
    storage,
    vault,
  );
  late final StubNewVaultCubit newVault = StubNewVaultCubit(
    session,
    auth,
    storage,
    vault,
  );
  late final ConnectivityCubit connectivity = ConnectivityCubit(
    network,
    offlineConfirmation: Duration.zero,
  );
  late final LockCubit lock = stubLockCubit(session);

  List<BlocProvider<dynamic>> get providers => <BlocProvider<dynamic>>[
    BlocProvider<SessionCubit>.value(value: session),
    BlocProvider<ConnectCubit>.value(value: connect),
    BlocProvider<UnlockCubit>.value(value: unlock),
    BlocProvider<CreateVaultCubit>.value(value: create),
    BlocProvider<NewVaultCubit>.value(value: newVault),
    BlocProvider<ConnectivityCubit>.value(value: connectivity),
    BlocProvider<LockCubit>.value(value: lock),
  ];

  /// Signed in as Jane, waiting for the secret (or greeted as expired when
  /// the auth repository restores an expired session).
  Future<void> restore() => session.restore();

  /// Offline; the cubit confirms it on the next timer tick (in a widget
  /// test, `tester.pump(Duration.zero)`).
  Future<void> goOffline() async {
    network.connected = false;
    await connectivity.recheck();
  }

  Future<void> close() async {
    await Future.wait(<Future<void>>[
      connect.close(),
      unlock.close(),
      create.close(),
      newVault.close(),
      connectivity.close(),
      lock.close(),
    ]);
    await session.close();
  }
}
