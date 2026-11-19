import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/save_vault_dto.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/usecases/auth/reconnect.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/usecases/vault/check_newer_version.dart';
import 'package:keeperpass/core/usecases/vault/reload_vault.dart';
import 'package:keeperpass/core/usecases/vault/save_vault.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:keeperpass/presentation/common/cubit/connectivity/connectivity_cubit.dart';

part 'sync_cubit.freezed.dart';
part 'sync_state.dart';

/// Saves the vault after every committed change (web `VaultSyncService`):
/// one save at a time, and a change made during a save triggers one more
/// afterwards. The states are the board `Sync-states`': encrypting →
/// uploading → saved; failed (Retry / Dismiss, the change stays); a Dropbox
/// conflict (D9); an expired session, which keeps the vault open and saves
/// after Reconnect; offline, which saves as soon as the connection returns.
@lazySingleton
final class SyncCubit extends Cubit<SyncState> {
  SyncCubit(
    this._saveVault,
    this._reloadVault,
    this._checkNewerVersion,
    this._reconnect,
    this._vault,
    this._connectivity, {
    @ignoreParam this._now = DateTime.now,
  }) : super(const SyncState()) {
    _vaultSubscription = _vault.changes.listen((VaultSnapshot? snapshot) {
      if (snapshot == null) _reset();
    });
    _connectivitySubscription = _connectivity.stream.listen(_onConnectivity);
  }

  final SaveVault _saveVault;
  final ReloadVault _reloadVault;
  final CheckNewerVersion _checkNewerVersion;
  final Reconnect _reconnect;
  final VaultSessionService _vault;
  final ConnectivityCubit _connectivity;
  final DateTime Function() _now;

  /// The clock the conflict's times are told against ("9:37 AM" today).
  DateTime now() => _now();

  late final StreamSubscription<VaultSnapshot?> _vaultSubscription;
  late final StreamSubscription<ConnectivityState> _connectivitySubscription;

  /// Committed changes asked to be saved, and how many of them are stored.
  int _requested = 0;
  int _saved = 0;
  bool _saving = false;

  /// Set when a change arrives during a save (web `saveAgain`).
  bool _saveAgain = false;

  /// The check before editing that is running, if any. A second request in
  /// that moment (a repeated tap while the first waits on the network) is
  /// refused, so nothing opens or changes twice; Save in Edit waits for it
  /// instead (Edit opens while its check runs).
  Future<bool>? _checking;

  /// Goes up with every lock and sign-out. A save still uploading then
  /// finishes (it carries changes made before the lock), but its result no
  /// longer counts: the counters it would settle belong to the wiped vault.
  int _session = 0;

  int get _pending => _requested - _saved;

  /// After every committed change — never from a draft.
  Future<void> saveNow() async {
    _requested++;
    emit(state.copyWith(pendingChanges: _pending));
    await _save();
  }

  /// "Retry" on the failed banner: it turns into progress.
  Future<void> retry() => _save(retrying: true);

  /// "Dismiss": the banner goes; the status line keeps counting what waits.
  void dismissError() {
    if (state.phase != SyncPhase.failed) return;
    emit(state.copyWith(phase: SyncPhase.idle, failure: null));
  }

  /// "Reconnect" after the session expired with the vault open: the same
  /// account signs in again and the waiting changes are saved.
  Future<void> reconnect() async {
    emit(
      state.copyWith(
        status: const CubitStatus(
          action: CubitAction.reconnect,
          statusType: CubitStatusType.loading,
        ),
      ),
    );
    final Either<Failure, ProviderAccount> result = await _reconnect(
      const NoParams(),
    );
    await result.fold(
      (Failure failure) async =>
          emit(state.copyWith(status: _failed(CubitAction.reconnect, failure))),
      (_) async {
        emit(
          state.copyWith(
            status: const CubitStatus(
              action: CubitAction.reconnect,
              statusType: CubitStatusType.success,
            ),
            phase: SyncPhase.idle,
            failure: null,
          ),
        );
        if (_pending > 0) await _save();
      },
    );
  }

  /// "Load the latest" after a Dropbox conflict: the stored vault replaces
  /// this phone's, and what was waiting here is dropped. On success the
  /// status carries `args['savedAt']`, the loaded version's time.
  Future<void> loadLatest() async {
    final DateTime? savedAt = state.newerVersion?.modifiedAt;
    emit(
      state.copyWith(
        status: const CubitStatus(
          action: CubitAction.loadLatest,
          statusType: CubitStatusType.loading,
        ),
      ),
    );
    final Either<Failure, VaultSnapshot> result = await _reloadVault(
      const NoParams(),
    );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          status: _failed(CubitAction.loadLatest, failure),
          phase: failure is StorageAuthExpired
              ? SyncPhase.sessionExpired
              : state.phase,
        ),
      ),
      (_) {
        _saved = _requested;
        emit(
          state.copyWith(
            status: CubitStatus(
              action: CubitAction.loadLatest,
              statusType: CubitStatusType.success,
              args: <String, dynamic>{'savedAt': savedAt},
            ),
            phase: SyncPhase.idle,
            pendingChanges: 0,
            failure: null,
            newerVersion: null,
          ),
        );
      },
    );
  }

  /// Before editing: whether editing may start. A newer stored version
  /// (Dropbox) pauses it until "Load the latest"; when the check cannot run,
  /// editing goes on and the save itself still guards against overwriting.
  /// Each refusal asks for "Your Vault Changed" (`conflictPrompts`). While a
  /// check runs, another request is refused without asking (a repeated tap),
  /// unless it [join]s it and takes its answer.
  Future<bool> checkBeforeEditing({bool join = false}) async {
    if (state.phase == SyncPhase.conflict) {
      emit(state.copyWith(conflictPrompts: state.conflictPrompts + 1));
      return false;
    }
    final Future<bool>? running = _checking;
    if (running != null) return join ? running : false;
    final Future<bool> check = _checkNewer();
    _checking = check;
    try {
      return await check;
    } finally {
      if (identical(_checking, check)) _checking = null;
    }
  }

  /// Whether this phone's copy is still the latest; a newer one is a
  /// conflict and asks for "Your Vault Changed".
  Future<bool> _checkNewer() async {
    final Either<Failure, VaultFileInfo?> result = await _checkNewerVersion(
      const NoParams(),
    );
    final VaultFileInfo? newer = result.getOrElse(() => null);
    if (newer == null) return true;
    emit(
      state.copyWith(
        phase: SyncPhase.conflict,
        newerVersion: newer,
        openedAt: _vault.loadedAt,
        conflictPrompts: state.conflictPrompts + 1,
      ),
    );
    return false;
  }

  Future<void> _save({bool retrying = false}) async {
    if (_saving) {
      _saveAgain = true;
      return;
    }
    if (!_vault.isOpen || _pending == 0) return;
    // Waits for Reconnect.
    if (state.phase == SyncPhase.sessionExpired) return;
    if (_connectivity.state is ConnectivityDisconnected) {
      emit(state.copyWith(phase: SyncPhase.offline, failure: null));
      return;
    }

    _saving = true;
    final int session = _session;
    final int saving = _requested;
    emit(
      state.copyWith(
        phase: SyncPhase.encrypting,
        retrying: retrying,
        progress: 0,
        failure: null,
      ),
    );
    final Either<Failure, Unit> result = await _saveVault(
      SaveVaultDto(
        onProgress: (double fraction) {
          if (!isClosed && _saving && session == _session) {
            emit(
              state.copyWith(phase: SyncPhase.uploading, progress: fraction),
            );
          }
        },
      ),
    );
    _saving = false;
    if (isClosed) return;

    if (session == _session) _settle(result, saving);

    // A change made meanwhile, in this session or a new one, saves now.
    if (_saveAgain) {
      _saveAgain = false;
      await _save();
    }
  }

  void _settle(Either<Failure, Unit> result, int saving) {
    result.fold(
      (Failure failure) {
        if (failure is StorageAuthExpired) {
          _saveAgain = false;
          emit(_stopped(SyncPhase.sessionExpired, failure));
        } else if (failure is VaultConflict) {
          _saveAgain = false;
          emit(_stopped(SyncPhase.conflict, failure));
          unawaited(_loadNewerVersion());
        } else if (_isOffline(failure)) {
          // Saved when the connection returns.
          _saveAgain = false;
          emit(_stopped(SyncPhase.offline, null));
        } else {
          emit(_stopped(SyncPhase.failed, failure));
        }
      },
      (_) {
        _saved = saving;
        emit(
          state.copyWith(
            phase: SyncPhase.saved,
            retrying: false,
            progress: 1,
            pendingChanges: _pending,
            failure: null,
            savedAt: _now(),
          ),
        );
      },
    );
  }

  SyncState _stopped(SyncPhase phase, Failure? failure) => state.copyWith(
    phase: phase,
    retrying: false,
    progress: 0,
    pendingChanges: _pending,
    failure: failure,
  );

  /// The stored file's time, for the conflict's "Two versions".
  Future<void> _loadNewerVersion() async {
    final Either<Failure, VaultFileInfo?> result = await _checkNewerVersion(
      const NoParams(),
    );
    final VaultFileInfo? newer = result.getOrElse(() => null);
    if (!isClosed && newer != null && state.phase == SyncPhase.conflict) {
      emit(state.copyWith(newerVersion: newer));
    }
  }

  void _onConnectivity(ConnectivityState connectivity) {
    if (connectivity is ConnectivityConnected &&
        state.phase == SyncPhase.offline &&
        _pending > 0) {
      unawaited(_save());
    }
  }

  static bool _isOffline(Failure failure) => failure.maybeMap(
    networkFailure: (f) => f.f is NoInternetConnection,
    orElse: () => false,
  );

  /// Locking and signing out wipe the vault, and with it what was waiting —
  /// as the web (open item O10, answer a).
  void _reset() {
    _session++;
    _requested = 0;
    _saved = 0;
    _saveAgain = false;
    if (!isClosed) emit(const SyncState());
  }

  static CubitStatus _failed(CubitAction action, Failure failure) =>
      CubitStatus(
        action: action,
        statusType: CubitStatusType.failure,
        errorMsg: failure.getMessage(),
      );

  @override
  Future<void> close() async {
    await _vaultSubscription.cancel();
    await _connectivitySubscription.cancel();
    return super.close();
  }
}
