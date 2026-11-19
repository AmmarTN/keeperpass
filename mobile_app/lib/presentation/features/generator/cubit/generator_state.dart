part of 'generator_cubit.dart';

/// Passphrase or random string.
enum GeneratorMode { passphrase, randomString }

@freezed
abstract class GeneratorState with _$GeneratorState {
  const GeneratorState._();

  const factory GeneratorState({
    @Default(CubitStatus()) CubitStatus status,

    /// Your answer, Part 9: the Generator tab's defaults — a passphrase of
    /// 4 words, Dash, English; 20 characters of a–z, A–Z and 0–9.
    @Default(GeneratorMode.passphrase) GeneratorMode mode,
    @Default(kDefaultWordCount) int wordCount,
    @Default('-') String separator,
    @Default('en') String language,
    @Default(kDefaultLength) int length,
    @Default(true) bool lowercase,
    @Default(true) bool uppercase,
    @Default(true) bool digits,
    @Default(false) bool symbols,

    /// The suggestion; empty while a word list loads or when no kind of
    /// character is on.
    @Default('') String value,
  }) = _GeneratorState;

  /// "Pick at least one kind of character." (web).
  bool get charsetEmpty => !lowercase && !uppercase && !digits && !symbols;

  /// 0–4, for the meter.
  int get score => estimatePasswordStrength(value).score;
}
