import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/i18n/strings.g.dart';

// ignore: camel_case_extensions
extension exceptionToFailure on Failure {
  String getMessage() {
    final Failure a = this;
    return a.map(
      networkFailure: (f) {
        return f.f.maybeMap(
          unauthorisedRequest: (nf) =>
              nf.errorMessage ?? t.errors.failures.networkFailure,
          noInternetConnection: (nf) => t.errors.failures.connectionError,
          customBackendError: (customError) {
            return customError.error['message']?.toString() ??
                t.errors.failures.undocumentedError;
          },
          notFound: (f) {
            return t.errors.failures.notFound;
          },
          requestTimeout: (nf) => t.errors.failures.requestTimeout,
          sendTimeout: (nf) => t.errors.failures.requestTimeout,
          receiveTimeout: (nf) => t.errors.failures.requestTimeout,
          orElse: () {
            return t.errors.failures.networkFailure;
          },
        );
      },
      formatExceptionFailure: (_) => t.errors.failures.formatException,
      unableToProcess: (_) => t.errors.failures.unableToProcess,
      platformFailure: (f) => f.message ?? t.errors.failures.platformError,
      unexpectedError: (f) {
        return t.errors.failures.unexpectedError;
      },
      accessTokenFailure: (_) => t.errors.failures.accessTokenFailure,
      cacheReadFailure: (_) => t.errors.failures.cacheReadFailure,
      cacheWriteFailure: (_) => t.errors.failures.cacheWriteFailure,
      storageAuthExpired: (f) => switch (f.provider) {
        ProviderId.google => t.errors.drive.authExpired,
        ProviderId.dropbox => t.errors.dropbox.authExpired,
      },
      vaultConflict: (_) => t.errors.vault.conflict,
      storageError: (f) => f.error.message,
      driveAccessNotGranted: (_) => t.errors.vault.driveAccessNotGranted,
      signInCancelled: (_) => t.errors.vault.signInCanceled,
      signInFailed: (f) =>
          f.message ??
          switch (f.provider) {
            ProviderId.google => t.errors.auth.unknown,
            ProviderId.dropbox => t.errors.dropbox.unknown,
          },
      profileFailed: (f) => switch (f.provider) {
        ProviderId.google => t.errors.auth.profileFailed,
        ProviderId.dropbox => t.errors.dropbox.profileFailed,
      },
      accountMismatch: (f) =>
          t.errors.vault.accountMismatch(email: f.expectedEmail),
      wrongSecret: (_) => t.auth.unlock.incorrectSecret,
      unsupportedVault: (_) => t.errors.vault.unsupported,
      corruptVault: (_) => t.errors.vault.corrupt,
      vaultNotFound: (_) => t.errors.masterPassword.vaultNotFound,
      vaultLocked: (_) => t.errors.failures.unexpectedError,
      migration: (f) => switch (f.error) {
        MigrationError.sameProvider => t.settings.migrate.error.sameProvider,
        MigrationError.busy => t.settings.migrate.error.busy,
        MigrationError.sourceExpired => t.settings.migrate.error.sourceExpired,
        MigrationError.targetExpired => t.settings.migrate.error.targetExpired(
          provider: f.provider ?? '',
        ),
        MigrationError.verifyFailed => t.settings.migrate.error.verifyFailed,
        MigrationError.targetHasVault => t.errors.failures.unexpectedError,
      },
    );
  }
}

extension StorageErrorMessage on StorageError {
  /// The web's message for this error (`errors.drive.*`,
  /// `errors.dropbox.*`).
  String get message => switch (this) {
    StorageError.driveUnreachable => t.errors.drive.unreachable,
    StorageError.driveReadFailed => t.errors.drive.readFailed,
    StorageError.driveSaveFailed => t.errors.drive.saveFailed,
    StorageError.driveCreateFolderFailed => t.errors.drive.createFolderFailed,
    StorageError.driveBackupFailed => t.errors.drive.backupFailed,
    StorageError.driveRenameFailed => t.errors.drive.renameFailed,
    StorageError.dropboxUnreachable => t.errors.dropbox.unreachable,
    StorageError.dropboxReadFailed => t.errors.dropbox.readFailed,
    StorageError.dropboxSaveFailed => t.errors.dropbox.saveFailed,
    StorageError.dropboxBackupFailed => t.errors.dropbox.backupFailed,
    StorageError.dropboxRenameFailed => t.errors.dropbox.renameFailed,
    StorageError.dropboxRateLimited => t.errors.dropbox.rateLimited,
    StorageError.dropboxMissingScope => t.errors.dropbox.missingScope,
  };
}
