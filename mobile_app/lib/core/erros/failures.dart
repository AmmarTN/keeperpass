import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/erros/storage_error.dart';

part 'failures.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  /// General Failures
  const factory Failure.networkFailure(NetworkFailure f) = _NetworkFailure;
  const factory Failure.platformFailure({String? message}) = PlatformFailure;
  const factory Failure.formatExceptionFailure() = FormatExceptionFailure;
  const factory Failure.unableToProcess(dynamic error) = UnableToProcess;
  const factory Failure.unexpectedError(dynamic data) = UnexpectedError;
  const factory Failure.accessTokenFailure() = AccessTokenFailure;
  const factory Failure.cacheReadFailure() = CacheReadFailure;
  const factory Failure.cacheWriteFailure() = CacheWriteFailure;

  /// Sign-in and storage
  /// The provider's token is expired or revoked and could not be renewed
  /// (web `StorageAuthExpiredError`).
  const factory Failure.storageAuthExpired(ProviderId provider) =
      StorageAuthExpired;

  /// Dropbox: the file changed since this phone read it (web
  /// `VaultConflictError`). Google Drive is last-save-wins (D9).
  const factory Failure.vaultConflict() = VaultConflict;
  const factory Failure.storageError(StorageError error) = StorageFailure;

  /// Google signed in but did not grant `drive.file` (board `U2-Connect`).
  const factory Failure.driveAccessNotGranted() = DriveAccessNotGranted;

  /// The person closed the provider's page: a choice, not an error.
  const factory Failure.signInCancelled() = SignInCancelled;
  const factory Failure.signInFailed(ProviderId provider, {String? message}) =
      SignInFailed;
  const factory Failure.profileFailed(ProviderId provider) = ProfileFailed;

  /// Reconnect signed in to a different account than the open vault's.
  const factory Failure.accountMismatch(String expectedEmail) = AccountMismatch;

  /// Vault file
  const factory Failure.wrongSecret() = WrongSecret;
  const factory Failure.unsupportedVault() = UnsupportedVault;
  const factory Failure.corruptVault() = CorruptVault;
  const factory Failure.vaultNotFound() = VaultNotFound;

  /// Needs an unlocked vault (or a signed-in session) and there is none.
  const factory Failure.vaultLocked() = VaultLocked;
  const factory Failure.migration(MigrationError error, {String? provider}) =
      MigrationFailure;
}
