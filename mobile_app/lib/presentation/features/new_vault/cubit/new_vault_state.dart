part of 'new_vault_cubit.dart';

enum NewVaultStep { form, working, failed, done }

/// The three real steps, in order (board `U2-New-vault`).
enum NewVaultStage { encrypting, backingUp, saving }

@freezed
abstract class NewVaultState with _$NewVaultState {
  const NewVaultState._();

  const factory NewVaultState({
    required DateTime backupAt,
    @Default(NewVaultStep.form) NewVaultStep step,
    @Default('') String secret,
    @Default('') String repeat,
    @Default(NewVaultStage.encrypting) NewVaultStage stage,
    Failure? failure,

    /// Bumped by each generation, so the fields show the new words.
    @Default(0) int generation,
  }) = _NewVaultState;

  /// The old file's name once kept aside.
  String get backupName => VaultFileNames.backup(backupAt);

  int get score => estimatePasswordStrength(secret).score;

  /// A warning, never a block (web `weak`).
  bool get weak => secret.isNotEmpty && score < kMinMasterPasswordScore;

  bool get mismatch => repeat.isNotEmpty && repeat != secret;

  /// Both filled and matching (web `canSubmit`).
  bool get canStart => secret.isNotEmpty && repeat == secret;
}
