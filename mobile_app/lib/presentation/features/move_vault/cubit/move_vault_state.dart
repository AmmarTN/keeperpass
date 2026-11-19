part of 'move_vault_cubit.dart';

/// Where Move vault is (boards `S5-25` … `S5-31`); done is Welcome's.
enum MoveVaultStep { start, confirm, moving, failed }

@freezed
abstract class MoveVaultState with _$MoveVaultState {
  const MoveVaultState._();

  const factory MoveVaultState({
    @Default(MoveVaultStep.start) MoveVaultStep step,

    /// The storage the vault leaves, and the one it goes to.
    ProviderId? from,
    ProviderId? destination,

    /// Signing in to the destination.
    @Default(false) bool connecting,

    /// Why signing in there did not work (web: the dialog's alert).
    Failure? connectFailure,

    /// The signed-in destination, held only for this move.
    MigrationTarget? target,

    /// The person agreed the destination's vault is kept as a backup and
    /// replaced.
    @Default(false) bool replaceConfirmed,

    /// "Choose a new secret" for the moved vault.
    @Default(false) bool newSecret,
    @Default('') String secret,
    @Default('') String repeat,

    /// Bumped by Generate, so the fields show the new secret.
    @Default(0) int generation,

    @Default(MigrationStage.encrypting) MigrationStage stage,

    /// The upload's share, 0–1.
    @Default(0) double progress,
    Failure? failure,
  }) = _MoveVaultState;

  int get score => estimatePasswordStrength(secret).score;

  /// A warning, never a block (web `weak`).
  bool get weak => secret.isNotEmpty && score < kMinMasterPasswordScore;

  /// Only once there is something to compare (web `mismatch`).
  bool get mismatch => repeat.isNotEmpty && repeat != secret;

  bool get matches => repeat.isNotEmpty && repeat == secret;

  /// Any replacement agreed to, and a new secret typed twice when one was
  /// asked for (web `canMove`; the repeat is required as in Change secret).
  bool get canMove {
    final MigrationTarget? target = this.target;
    if (target == null) return false;
    if (target.hasVault && !replaceConfirmed) return false;
    if (newSecret) return secret.isNotEmpty && repeat == secret;
    return true;
  }
}
