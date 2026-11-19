/// Why the vault locked; the unlock screen says it in one line
/// (boards `U2-Unlock`, `Lock-privacy`).
enum LockReason {
  /// "Lock now".
  manual,

  /// The auto-lock delay passed without use.
  inactivity,

  /// The app left the foreground with auto-lock set to "Immediately".
  leftApp,
}
