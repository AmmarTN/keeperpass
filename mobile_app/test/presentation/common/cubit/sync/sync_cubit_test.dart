import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/core/network/network_info.dart';
import 'package:keeperpass/core/usecases/auth/reconnect.dart';
import 'package:keeperpass/core/usecases/vault/check_newer_version.dart';
import 'package:keeperpass/core/usecases/vault/reload_vault.dart';
import 'package:keeperpass/core/usecases/vault/save_vault.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';
import 'package:keeperpass/presentation/common/cubit/sync/sync_cubit.dart';

import '../../../../helpers/fake_vault_layer.dart';

class FakeNetworkInfo implements NetworkInfo {
  bool connected = true;
  // Closed in tearDown.
  // ignore: close_sinks
  final StreamController<bool> changes = StreamController<bool>.broadcast();

  @override
  Future<bool> get isConnected async => connected;

  @override
  Stream<bool> get onConnectivityChanged => changes.stream;
}

/// A storage whose saves wait until released, to overlap them.
class GatedStorage extends FakeStorageRepository {
  final List<Completer<void>> gates = <Completer<void>>[];

  @override
  Future<Either<Failure, Unit>> saveVault(
    ProviderId provider,
    String accessToken,
    String content, {
    void Function(double)? onProgress,
  }) async {
    final Completer<void> gate = Completer<void>();
    gates.add(gate);
    await gate.future;
    return super.saveVault(
      provider,
      accessToken,
      content,
      onProgress: onProgress,
    );
  }
}

void main() {
  late FakeAuthRepository auth;
  late FakeStorageRepository storage;
  late FakeVaultCipher cipher;
  late VaultSessionService vault;
  late FakeNetworkInfo network;
  late ConnectivityCubit connectivity;
  late SyncCubit sync;
  late List<SyncState> states;
  final DateTime now = DateTime.utc(2026, 10, 30, 9, 41);

  SyncCubit build(FakeStorageRepository storage) {
    final SyncCubit cubit = SyncCubit(
      SaveVault(auth, storage, cipher, vault, now: () => now),
      ReloadVault(auth, storage, cipher, vault, now: () => now),
      CheckNewerVersion(auth, storage),
      Reconnect(auth, LockService()),
      vault,
      connectivity,
      now: () => now,
    );
    states = <SyncState>[];
    cubit.stream.listen(states.add);
    return cubit;
  }

  setUp(() {
    auth = FakeAuthRepository();
    storage = FakeStorageRepository();
    cipher = FakeVaultCipher();
    vault = VaultSessionService()
      ..open(VaultSnapshot.empty(vaultName: 'Work'), 'pw', DateTime.utc(2026));
    network = FakeNetworkInfo();
    connectivity = ConnectivityCubit(
      network,
      offlineConfirmation: Duration.zero,
    );
    sync = build(storage);
  });

  tearDown(() async {
    await sync.close();
    await connectivity.close();
    await network.changes.close();
  });

  Future<void> settle() => Future<void>.delayed(Duration.zero);

  test('encrypting → uploading → saved, and nothing left waiting', () async {
    storage.progress = <double>[0, 0.5, 1];
    await sync.saveNow();
    await settle();

    expect(states.map((SyncState s) => s.phase).toSet().toList(), <SyncPhase>[
      SyncPhase.idle,
      SyncPhase.encrypting,
      SyncPhase.uploading,
      SyncPhase.saved,
    ]);
    expect(
      states
          .where((SyncState s) => s.phase == SyncPhase.uploading)
          .map((SyncState s) => s.progress),
      <double>[0, 0.5, 1],
    );
    expect(states.first.pendingChanges, 1);
    expect(sync.state.pendingChanges, 0);
    expect(sync.state.savedAt, now);
  });

  test('one save at a time; changes during it make one more save', () async {
    final GatedStorage gated = GatedStorage();
    await sync.close();
    sync = build(gated);

    final Future<void> first = sync.saveNow();
    await settle();
    unawaited(sync.saveNow());
    unawaited(sync.saveNow());
    await settle();
    expect(gated.gates, hasLength(1));
    expect(sync.state.pendingChanges, 3);

    gated.gates.single.complete();
    await settle();
    await settle();
    expect(gated.gates, hasLength(2));
    gated.gates.last.complete();
    await first;
    await settle();

    expect(gated.calls.where((String c) => c == 'save:google'), hasLength(2));
    expect(sync.state.phase, SyncPhase.saved);
    expect(sync.state.pendingChanges, 0);
  });

  test('a failed save keeps the change; Retry saves it', () async {
    storage.failures['save:google'] = const Failure.storageError(
      StorageError.driveSaveFailed,
    );
    await sync.saveNow();
    expect(sync.state.phase, SyncPhase.failed);
    expect(sync.state.pendingChanges, 1);

    sync.dismissError();
    expect(sync.state.phase, SyncPhase.idle);
    expect(sync.state.pendingChanges, 1);

    storage.failures.clear();
    await sync.retry();
    await settle();
    expect(states.any((SyncState s) => s.retrying), isTrue);
    expect(sync.state.phase, SyncPhase.saved);
    expect(sync.state.pendingChanges, 0);
  });

  test(
    'a Dropbox conflict pauses editing until the latest is loaded',
    () async {
      final VaultFileInfo newer = VaultFileInfo(
        modifiedAt: DateTime.utc(2026, 10, 30, 9, 37),
      );
      storage.failures['save:google'] = const Failure.vaultConflict();
      storage.newer[ProviderId.google] = newer;

      await sync.saveNow();
      await settle();
      expect(sync.state.phase, SyncPhase.conflict);
      expect(sync.state.canEdit, isFalse);
      expect(sync.state.newerVersion, newer);

      storage.files[ProviderId.google] = await cipher.encrypt(
        'pw',
        VaultSnapshot.empty(vaultName: 'From the other phone').toVaultJson(),
      );
      await sync.loadLatest();
      expect(sync.state.phase, SyncPhase.idle);
      expect(sync.state.pendingChanges, 0);
      expect(sync.state.status.args, <String, dynamic>{
        'savedAt': newer.modifiedAt,
      });
      expect(vault.snapshot!.vaults.single.name, 'From the other phone');
    },
  );

  test('checking before editing finds a newer version', () async {
    expect(await sync.checkBeforeEditing(), isTrue);
    expect(sync.state.conflictPrompts, 0);
    storage.newer[ProviderId.google] = const VaultFileInfo();
    expect(await sync.checkBeforeEditing(), isFalse);
    expect(sync.state.phase, SyncPhase.conflict);
    // Each refused edit asks "Your Vault Changed" again (board
    // `Sync-states`).
    expect(sync.state.conflictPrompts, 1);
    expect(await sync.checkBeforeEditing(), isFalse);
    expect(sync.state.conflictPrompts, 2);
  });

  test(
    'an expired session keeps the vault open; Reconnect saves what waits',
    () async {
      storage.failures['save:google'] = const Failure.storageAuthExpired(
        ProviderId.google,
      );
      await sync.saveNow();
      expect(sync.state.phase, SyncPhase.sessionExpired);
      expect(vault.isOpen, isTrue);

      // More changes wait; nothing is tried until Reconnect.
      storage.calls.clear();
      await sync.saveNow();
      expect(storage.calls, isEmpty);
      expect(sync.state.pendingChanges, 2);

      auth.reconnectResult = const Left(
        Failure.accountMismatch('jane@example.com'),
      );
      await sync.reconnect();
      expect(sync.state.status.statusType, CubitStatusType.failure);
      expect(
        sync.state.status.errorMsg,
        'Sign in with jane@example.com to save your changes.',
      );
      expect(sync.state.phase, SyncPhase.sessionExpired);

      auth.reconnectResult = null;
      storage.failures.clear();
      await sync.reconnect();
      expect(sync.state.phase, SyncPhase.saved);
      expect(sync.state.pendingChanges, 0);
    },
  );

  test(
    'offline: the change waits and saves when the connection returns',
    () async {
      storage.failures['save:google'] = const Failure.networkFailure(
        NetworkFailure.noInternetConnection(),
      );
      await sync.saveNow();
      expect(sync.state.phase, SyncPhase.offline);
      expect(sync.state.pendingChanges, 1);

      storage.failures.clear();
      await connectivity.recheck();
      await settle();
      expect(sync.state.phase, SyncPhase.saved);
      expect(sync.state.pendingChanges, 0);
    },
  );

  test(
    'known to be offline: no attempt until the connection is back',
    () async {
      network.connected = false;
      await connectivity.recheck();
      await settle();

      await sync.saveNow();
      expect(storage.calls, isEmpty);
      expect(sync.state.phase, SyncPhase.offline);

      network.connected = true;
      await connectivity.recheck();
      await settle();
      expect(sync.state.phase, SyncPhase.saved);
    },
  );

  test('a save that times out is "not saved" with Retry, not offline '
      '(audit, 2026-11-04)', () async {
    storage.failures['save:google'] = const Failure.networkFailure(
      NetworkFailure.sendTimeout(),
    );
    await sync.saveNow();
    await settle();
    expect(sync.state.phase, SyncPhase.failed);
    expect(sync.state.pendingChanges, 1);

    // The connection recovers.
    storage.failures.remove('save:google');
    await sync.retry();
    await settle();
    expect(sync.state.phase, SyncPhase.saved);
    expect(sync.state.pendingChanges, 0);
  });

  test('a second check while one runs is refused; afterwards checks run '
      'again (a repeated tap, 2026-11-05)', () async {
    storage.holdNewer = Completer<void>();
    final Future<bool> first = sync.checkBeforeEditing();
    expect(await sync.checkBeforeEditing(), isFalse);
    storage.holdNewer!.complete();
    expect(await first, isTrue);
    storage.holdNewer = null;
    expect(await sync.checkBeforeEditing(), isTrue);
    expect(
      storage.calls.where((String c) => c == 'newer:google'),
      hasLength(2),
    );
    expect(sync.state.conflictPrompts, 0);
  });

  test('Save joins the running check and takes its answer; a repeated tap '
      'is still refused (2026-11-05)', () async {
    storage.holdNewer = Completer<void>();
    final Future<bool> opening = sync.checkBeforeEditing();
    final Future<bool> save = sync.checkBeforeEditing(join: true);
    expect(await sync.checkBeforeEditing(), isFalse);
    storage.holdNewer!.complete();
    expect(await opening, isTrue);
    expect(await save, isTrue);
    expect(
      storage.calls.where((String c) => c == 'newer:google'),
      hasLength(1),
    );
  });

  test('locking wipes what was waiting', () async {
    storage.failures['save:google'] = const Failure.storageError(
      StorageError.driveSaveFailed,
    );
    await sync.saveNow();
    vault.wipe();
    expect(sync.state, const SyncState());
  });

  group('a lock while a save still uploads (audit, 2026-11-04)', () {
    late GatedStorage gated;

    setUp(() async {
      gated = GatedStorage();
      await sync.close();
      sync = build(gated);
    });

    void unlockAgain() => vault.open(
      VaultSnapshot.empty(vaultName: 'Work'),
      'pw',
      DateTime.utc(2026),
    );

    int saves() => gated.calls.where((String c) => c == 'save:google').length;

    test('the save ends after the lock: it counts for nothing, and the '
        'next edit is uploaded', () async {
      unawaited(sync.saveNow());
      await settle();
      expect(gated.gates, hasLength(1));
      vault.wipe();

      gated.gates.single.complete();
      await settle();
      await settle();
      expect(sync.state, const SyncState());

      unlockAgain();
      unawaited(sync.saveNow());
      await settle();
      expect(gated.gates, hasLength(2));
      gated.gates.last.complete();
      await settle();
      await settle();
      expect(saves(), 2);
      expect(sync.state.phase, SyncPhase.saved);
      expect(sync.state.pendingChanges, 0);
    });

    test('unlocked again before it ends: the new edit waits, then is '
        'uploaded', () async {
      unawaited(sync.saveNow());
      await settle();
      vault.wipe();
      unlockAgain();

      unawaited(sync.saveNow());
      await settle();
      expect(gated.gates, hasLength(1));
      expect(sync.state.pendingChanges, 1);

      gated.gates.single.complete();
      await settle();
      await settle();
      expect(gated.gates, hasLength(2));
      expect(sync.state.pendingChanges, 1);
      gated.gates.last.complete();
      await settle();
      await settle();
      expect(saves(), 2);
      expect(sync.state.phase, SyncPhase.saved);
      expect(sync.state.pendingChanges, 0);
    });
  });
}
