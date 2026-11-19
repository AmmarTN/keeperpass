part of 'change_secret_cubit.dart';

/// Where Change secret is (boards `S5-18` … `S5-23`).
enum ChangeSecretStep { form, verifying, encrypting, saving, done, failed }

@freezed
abstract class ChangeSecretState with _$ChangeSecretState {
  const ChangeSecretState._();

  const factory ChangeSecretState({
    @Default(ChangeSecretStep.form) ChangeSecretStep step,
    @Default('') String current,
    @Default('') String secret,
    @Default('') String repeat,

    /// Bumped by Generate, so the fields show the new secret.
    @Default(0) int generation,

    /// "That is not your current secret." (board `S5-19`).
    @Default(false) bool wrongCurrent,

    /// The upload's share, 0–1.
    @Default(0) double progress,
    Failure? failure,
  }) = _ChangeSecretState;

  int get score => estimatePasswordStrength(secret).score;

  /// A warning, never a block (web `weak`).
  bool get weak => secret.isNotEmpty && score < kMinMasterPasswordScore;

  /// Only once there is something to compare (web `mismatch`).
  bool get mismatch => repeat.isNotEmpty && repeat != secret;

  bool get matches => repeat.isNotEmpty && repeat == secret;

  bool get canSubmit =>
      current.isNotEmpty && secret.isNotEmpty && repeat == secret;
}
