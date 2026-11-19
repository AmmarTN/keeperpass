part of 'create_vault_cubit.dart';

/// Where Create is (board `U2-Create`).
enum CreateStep {
  /// 1 · "Choose Your Secret".
  secret,

  /// 2 · "Type It Again" (typed secrets only).
  repeat,

  /// 3 · "Write It Down".
  writeDown,

  /// Encrypting, then saving.
  working,

  /// "Could not save your vault".
  failed,

  /// Saved: the vault opens.
  done,
}

/// The two real steps of making the vault.
enum CreateStage { encrypting, saving }

@freezed
abstract class CreateVaultState with _$CreateVaultState {
  const CreateVaultState._();

  const factory CreateVaultState({
    @Default(CreateStep.secret) CreateStep step,
    @Default('') String secret,

    /// Five generated words: no retype step, shown as word tiles.
    @Default(false) bool generated,
    @Default('') String repeat,

    /// "I've written my secret down".
    @Default(false) bool acknowledged,
    @Default(CreateStage.encrypting) CreateStage stage,
    Failure? failure,

    /// Bumped by each generation, so the field shows the new words.
    @Default(0) int generation,
  }) = _CreateVaultState;

  int get score => estimatePasswordStrength(secret).score;

  /// A warning, never a block (web `weak`).
  bool get weak => secret.isNotEmpty && score < kMinMasterPasswordScore;

  /// Only once there is something to compare (web `mismatch`).
  bool get mismatch => repeat.isNotEmpty && repeat != secret;

  bool get canContinue => switch (step) {
    CreateStep.secret => secret.isNotEmpty,
    CreateStep.repeat => repeat.isNotEmpty && repeat == secret,
    CreateStep.writeDown => acknowledged,
    _ => false,
  };

  /// Step N of 3, as the bar shows it.
  int get stepNumber => switch (step) {
    CreateStep.secret => 1,
    CreateStep.repeat => 2,
    _ => 3,
  };
}
