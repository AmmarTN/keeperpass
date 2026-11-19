part of 'session_cubit.dart';

@freezed
abstract class SessionState with _$SessionState {
  const SessionState._();

  const factory SessionState({
    @Default(CubitStatus()) CubitStatus status,
    @Default(SessionPhase.signedOut) SessionPhase phase,

    /// The session's account; while signed out after an expiry, the one to
    /// greet ("Welcome back", board `U2-Connect`).
    ProviderAccount? account,

    /// Signed out because the session expired, not by choice.
    @Default(false) bool expired,

    /// The launch restore has finished (the splash can move on).
    @Default(false) bool restored,

    /// Whether this account has a vault file; null before the check.
    bool? hasVault,

    /// The file found by the check ("updated 2 days ago").
    VaultFileInfo? vaultFile,

    /// Why the vault last locked; null when it was never unlocked.
    LockReason? lockReason,

    /// Which provider's button is busy signing in.
    ProviderId? signingIn,

    /// The last action's failure, for screens that react to its kind
    /// (cancelled sign-in → toast, wrong secret → shake).
    Failure? failure,

    /// Signed out by archiving or moving the vault: what Welcome shows over
    /// itself.
    SessionFarewell? farewell,
  }) = _SessionState;

  bool get isReady => phase == SessionPhase.ready;
}

/// Said over Welcome right after the vault was archived or moved (boards
/// `S5-37`, `S5-29`, `S5-30`); the phone has already signed out.
@freezed
sealed class SessionFarewell with _$SessionFarewell {
  /// "Your vault file has been renamed".
  const factory SessionFarewell.archived({
    required ProviderId provider,

    /// The file's new name; null when there was no file to rename.
    String? renamedFile,
  }) = ArchivedFarewell;

  /// "Your vault now lives in Dropbox", or, without [renamedFile], copied
  /// while the old file kept its name.
  const factory SessionFarewell.moved({
    required ProviderId from,
    required ProviderId to,
    String? renamedFile,
  }) = MovedFarewell;
}
