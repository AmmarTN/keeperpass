part of 'unlock_cubit.dart';

enum UnlockStatus {
  idle,

  /// The key is being derived; the dial turns.
  unlocking,

  /// "Incorrect secret. Please try again."; the dial rings red.
  wrongSecret,

  /// The file could not be fetched: a banner with Retry.
  unreachable,

  /// Anything else (a damaged or unsupported file).
  failed,
}

@freezed
abstract class UnlockState with _$UnlockState {
  const factory UnlockState({
    @Default(UnlockStatus.idle) UnlockStatus status,
    Failure? failure,

    /// Bumped on each wrong secret: the dial shakes and rings red.
    @Default(0) int wrongAttempts,
  }) = _UnlockState;
}
