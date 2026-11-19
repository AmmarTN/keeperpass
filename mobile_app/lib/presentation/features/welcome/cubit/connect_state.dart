part of 'connect_cubit.dart';

/// What the Welcome screen's dock is doing (board `U2-Connect`).
enum ConnectStage {
  /// Both providers, the three facts and the footer.
  idle,

  /// The pressed provider carries the spinner; the other rests at 50 %.
  signingIn,

  /// "Checking your vault…": the account and a status line.
  checking,

  /// "Found your vault", a beat before Unlock.
  found,

  /// "Could not read your vault", with Try again.
  checkFailed,
}

/// Where the screen goes next.
enum ConnectDestination { unlock, create }

@freezed
abstract class ConnectState with _$ConnectState {
  const factory ConnectState({
    @Default(ConnectStage.idle) ConnectStage stage,
    ProviderId? signingIn,

    /// Why the last sign-in failed (the dock's red banner).
    Failure? signInFailure,

    /// "Found in Google Drive · updated 2 days ago".
    String? foundMeta,

    /// Set once; the page navigates and calls `destinationHandled`.
    ConnectDestination? destination,

    /// Bumped each time the person closed the provider's page (a toast).
    @Default(0) int cancelled,
  }) = _ConnectState;
}
