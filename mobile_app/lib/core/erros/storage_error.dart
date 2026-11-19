/// What a storage call could not do, one per web error message
/// (`errors.drive.*`, `errors.dropbox.*`).
enum StorageError {
  driveUnreachable,
  driveReadFailed,
  driveSaveFailed,
  driveCreateFolderFailed,
  driveBackupFailed,
  driveRenameFailed,
  dropboxUnreachable,
  dropboxReadFailed,
  dropboxSaveFailed,
  dropboxBackupFailed,
  dropboxRenameFailed,
  dropboxRateLimited,

  /// A 401 that is a misconfigured Dropbox app, not an expiry: signing in
  /// again would loop forever (web `authError`).
  dropboxMissingScope,
}

/// Why moving the vault to the other provider stopped
/// (web `settings.migrate.error.*`, `TargetVaultExistsError`).
enum MigrationError {
  sameProvider,
  busy,
  sourceExpired,
  targetExpired,
  verifyFailed,
  targetHasVault,
}
