import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/vault_secret_dto.dart';
import 'package:keeperpass/core/enums/lock_reason.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/auth/get_available_providers.dart';
import 'package:keeperpass/core/usecases/auth/mark_session_expired.dart';
import 'package:keeperpass/core/usecases/auth/refresh_profile.dart';
import 'package:keeperpass/core/usecases/auth/restore_session.dart';
import 'package:keeperpass/core/usecases/auth/sign_in.dart';
import 'package:keeperpass/core/usecases/auth/sign_out.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/usecases/vault/archive_vault.dart';
import 'package:keeperpass/core/usecases/vault/check_vault.dart';
import 'package:keeperpass/core/usecases/vault/lock_vault.dart';
import 'package:keeperpass/core/usecases/vault/unlock_vault.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/infrastructure/extensions/failures.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

part 'session_cubit.freezed.dart';
part 'session_state.dart';

/// The sign-in flow's phases, as the web's `SessionStore`: signed out →
/// awaiting the secret → ready. Screens send their intents here and route
/// on [SessionState.phase].
///
/// An expired session before the vault is open signs out but keeps the
/// account to greet (board `U2-Connect`); with the vault open it never signs
/// out — saving waits for Reconnect instead (`SyncCubit`).
@lazySingleton
final class SessionCubit extends Cubit<SessionState> {
  SessionCubit(
    this._restoreSession,
    this._getAvailableProviders,
    this._signIn,
    this._checkVault,
    this._unlockVault,
    this._lockVault,
    this._signOut,
    this._archiveVault,
    this._markSessionExpired,
    this._refreshProfile,
  ) : super(const SessionState());

  final RestoreSession _restoreSession;
  final GetAvailableProviders _getAvailableProviders;
  final SignIn _signIn;
  final CheckVault _checkVault;
  final UnlockVault _unlockVault;
  final LockVault _lockVault;
  final SignOut _signOut;
  final ArchiveVault _archiveVault;
  final MarkSessionExpired _markSessionExpired;
  final RefreshProfile _refreshProfile;

  /// The sign-in buttons: providers configured in this build (X7).
  List<ProviderId> get availableProviders =>
      _getAvailableProviders(const NoParams()).getOrElse(() => <ProviderId>[]);

  bool get _busy => state.status.statusType == CubitStatusType.loading;

  /// At launch: a remembered sign-in skips straight to the secret (D10).
  Future<void> restore() async {
    final Either<Failure, RememberedSession?> result = await _restoreSession(
      const NoParams(),
    );
    final RememberedSession? session = result.getOrElse(() => null);
    if (session == null) {
      emit(const SessionState(restored: true));
    } else if (session.expired) {
      emit(
        SessionState(restored: true, account: session.account, expired: true),
      );
    } else {
      emit(
        SessionState(
          restored: true,
          phase: SessionPhase.awaitingSecret,
          account: session.account,
        ),
      );
    }
  }

  /// "Continue with …". A closed provider page ends in
  /// [Failure.signInCancelled] and leaves everything as it was.
  Future<void> signIn(ProviderId provider) async {
    if (_busy) return;
    emit(
      state.copyWith(
        status: _loading(CubitAction.signIn),
        signingIn: provider,
        failure: null,
      ),
    );
    final Either<Failure, ProviderAccount> result = await _signIn(provider);
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          status: _failed(CubitAction.signIn, failure),
          signingIn: null,
          failure: failure,
        ),
      ),
      (ProviderAccount account) => emit(
        SessionState(
          restored: true,
          phase: SessionPhase.awaitingSecret,
          account: account,
          status: _done(CubitAction.signIn),
        ),
      ),
    );
  }

  /// "Checking your vault…": decides Unlock or Create. Offline or
  /// unreachable leaves the session as it is, for a retry.
  Future<void> checkVault() async {
    if (_busy || state.phase != SessionPhase.awaitingSecret) return;
    emit(
      state.copyWith(status: _loading(CubitAction.checkVault), failure: null),
    );
    final Either<Failure, VaultFileInfo?> result = await _checkVault(
      const NoParams(),
    );
    await result.fold(
      (Failure failure) => _fail(CubitAction.checkVault, failure),
      (VaultFileInfo? file) async => emit(
        state.copyWith(
          status: _done(CubitAction.checkVault),
          hasVault: file != null,
          vaultFile: file,
        ),
      ),
    );
  }

  Future<void> unlock(String secret) =>
      _open(CubitAction.unlock, secret, _unlockVault.call);

  /// Create or Start a new vault opened the vault (their page cubits run the
  /// steps, with progress).
  void vaultOpened() {
    if (state.phase != SessionPhase.awaitingSecret) return;
    emit(
      state.copyWith(
        status: const CubitStatus(),
        phase: SessionPhase.ready,
        hasVault: true,
        lockReason: null,
        failure: null,
      ),
    );
  }

  /// A page's storage call found the session expired before the vault was
  /// open: sign out, keeping the account to greet.
  Future<void> sessionExpired(Failure failure) =>
      _fail(CubitAction.none, failure);

  /// Wipes the decrypted vault and the secret; the sign-in stays, so only
  /// the secret is asked again.
  void lock(LockReason reason) {
    if (state.phase != SessionPhase.ready) return;
    _lockVault(const NoParams());
    emit(
      state.copyWith(
        phase: SessionPhase.awaitingSecret,
        lockReason: reason,
        status: const CubitStatus(),
        failure: null,
      ),
    );
  }

  /// Log out, or "Use another account": the phone forgets the sign-in.
  Future<void> signOut() async {
    emit(state.copyWith(status: _loading(CubitAction.signOut)));
    await _signOut(const NoParams());
    emit(
      const SessionState(
        restored: true,
        status: CubitStatus(
          action: CubitAction.signOut,
          statusType: CubitStatusType.success,
        ),
      ),
    );
  }

  /// "Archive vault and sign out": signed out at once, with what Welcome
  /// shows over itself (board `S5-37`).
  Future<void> archiveVault() async {
    if (_busy) return;
    final ProviderId? provider = state.account?.provider;
    emit(
      state.copyWith(status: _loading(CubitAction.archiveVault), failure: null),
    );
    final Either<Failure, String?> result = await _archiveVault(
      const NoParams(),
    );
    result.fold(
      (Failure failure) => emit(
        state.copyWith(
          status: _failed(CubitAction.archiveVault, failure),
          failure: failure,
        ),
      ),
      (String? renamed) => emit(
        SessionState(
          restored: true,
          status: const CubitStatus(
            action: CubitAction.archiveVault,
            statusType: CubitStatusType.success,
          ),
          farewell: provider == null
              ? null
              : SessionFarewell.archived(
                  provider: provider,
                  renamedFile: renamed,
                ),
        ),
      ),
    );
  }

  /// The vault moved to another storage: the phone signs out at once (as
  /// the web) and Welcome says where it went (boards `S5-29`, `S5-30`).
  Future<void> vaultMoved(SessionFarewell farewell) async {
    emit(state.copyWith(status: _loading(CubitAction.signOut)));
    await _signOut(const NoParams());
    emit(
      SessionState(
        restored: true,
        status: const CubitStatus(
          action: CubitAction.signOut,
          statusType: CubitStatusType.success,
        ),
        farewell: farewell,
      ),
    );
  }

  /// Re-reads the name and address; best effort, nothing changes on failure.
  Future<void> refreshProfile() async {
    final Either<Failure, ProviderAccount> result = await _refreshProfile(
      const NoParams(),
    );
    result.fold(
      (_) {},
      (ProviderAccount account) => emit(state.copyWith(account: account)),
    );
  }

  Future<void> _open(
    CubitAction action,
    String secret,
    Future<Either<Failure, VaultSnapshot>> Function(VaultSecretDto dto) open,
  ) async {
    if (_busy || state.phase != SessionPhase.awaitingSecret) return;
    emit(state.copyWith(status: _loading(action), failure: null));
    final Either<Failure, VaultSnapshot> result = await open(
      VaultSecretDto(secret: secret, vaultName: t.vaults.defaultName),
    );
    await result.fold(
      (Failure failure) => _fail(action, failure),
      (_) async => emit(
        state.copyWith(
          status: _done(action),
          phase: SessionPhase.ready,
          hasVault: true,
          lockReason: null,
        ),
      ),
    );
  }

  /// An expired session signs out but keeps the account to greet; any other
  /// failure is reported and the session stays where it is.
  Future<void> _fail(CubitAction action, Failure failure) async {
    if (failure is! StorageAuthExpired) {
      emit(state.copyWith(status: _failed(action, failure), failure: failure));
      return;
    }
    final ProviderAccount? account = state.account;
    await _markSessionExpired(const NoParams());
    emit(
      SessionState(
        restored: true,
        account: account,
        expired: true,
        status: _failed(action, failure),
        failure: failure,
      ),
    );
  }

  static CubitStatus _loading(CubitAction action) =>
      CubitStatus(action: action, statusType: CubitStatusType.loading);

  static CubitStatus _done(CubitAction action) =>
      CubitStatus(action: action, statusType: CubitStatusType.success);

  static CubitStatus _failed(CubitAction action, Failure failure) =>
      CubitStatus(
        action: action,
        statusType: CubitStatusType.failure,
        errorMsg: failure.getMessage(),
      );
}
