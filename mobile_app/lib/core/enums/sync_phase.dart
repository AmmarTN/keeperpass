/// What saving is doing (board `Sync-states`): the pill while it works, the
/// banners when it cannot.
enum SyncPhase {
  idle,

  /// Deriving the key and encrypting: no byte count yet.
  encrypting,

  /// Uploading, with progress.
  uploading,

  /// The last save went through ("Saved").
  saved,

  /// "Your vault was not saved", with Retry and Dismiss.
  failed,

  /// Dropbox only (D9): the file changed on another device; editing waits
  /// until the latest is loaded.
  conflict,

  /// The provider session expired with the vault open: reading goes on, and
  /// changes are saved after Reconnect.
  sessionExpired,

  /// No connection: changes wait and are saved when it returns.
  offline,
}
