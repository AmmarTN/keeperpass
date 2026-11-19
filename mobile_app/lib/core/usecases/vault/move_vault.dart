import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/move_vault_dto.dart';
import 'package:keeperpass/core/enums/migration_stage.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/crypto/vault_cipher.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Moves the open vault to the other provider (web
/// `VaultMigrationService.migrate`), ordered so no step can lose data: the
/// destination is written, read back, decrypted and compared, and only then
/// is the source file renamed — never deleted. An existing destination vault
/// is kept as a backup, and only when the person agreed. The result is the
/// old file's new name, null when it could not be renamed (or was gone); the
/// caller then signs out, as the web.
@singleton
class MoveVault implements Usecase<String?, MoveVaultDto> {
  final IAuthRepository _auth;
  final IVaultStorageRepository _storage;
  final VaultCipher _cipher;
  final VaultSessionService _vault;
  final DateTime Function() _now;

  MoveVault(
    this._auth,
    this._storage,
    this._cipher,
    this._vault, {
    @ignoreParam this._now = DateTime.now,
  });

  @override
  Future<Either<Failure, String?>> call(MoveVaultDto dto) async {
    if (dto.target.hasVault && !dto.replaceExisting) {
      return const Left(Failure.migration(MigrationError.targetHasVault));
    }
    final ProviderAccount? source = _auth.account;
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (dto.secret.isEmpty || source == null || snapshot == null) {
      return const Left(Failure.vaultLocked());
    }
    // A save in flight could write to the source after it was renamed.
    if (_vault.saving) {
      return const Left(Failure.migration(MigrationError.busy));
    }

    final Either<Failure, String> sourceToken = await _auth.authorized(
      (String token) async => Right<Failure, String>(token),
    );
    if (sourceToken.isLeft()) {
      return const Left(Failure.migration(MigrationError.sourceExpired));
    }

    final String targetToken = dto.target.accessToken;
    final Failure targetExpired = Failure.migration(
      MigrationError.targetExpired,
      provider: dto.targetProvider.storageName,
    );
    Failure destinationFailure(Failure failure) =>
        failure is StorageAuthExpired ? targetExpired : failure;

    dto.onStage?.call(MigrationStage.encrypting);
    final Map<String, dynamic> json = snapshot.toVaultJson();
    final String content = await _cipher.encrypt(dto.secret, json);

    dto.onStage?.call(MigrationStage.uploading);
    final Either<Failure, Unit> written = dto.target.hasVault
        ? await _storage.resetVault(
            dto.targetProvider,
            targetToken,
            content,
            backupAt: _now(),
            onProgress: dto.onProgress,
          )
        : await _storage.saveVault(
            dto.targetProvider,
            targetToken,
            content,
            onProgress: dto.onProgress,
          );
    if (written.isLeft()) {
      return Left(destinationFailure(_failureOf(written)));
    }

    dto.onStage?.call(MigrationStage.verifying);
    final Either<Failure, String?> stored = await _storage.loadVault(
      dto.targetProvider,
      targetToken,
    );
    if (stored.isLeft()) return Left(destinationFailure(_failureOf(stored)));
    final Failure verifyFailed = const Failure.migration(
      MigrationError.verifyFailed,
    );
    final String? text = stored.getOrElse(() => null);
    if (text == null) return Left(verifyFailed);
    final Either<Failure, Object?> roundTrip = await _cipher.decrypt(
      dto.secret,
      text,
    );
    // Through JSON on both sides: that is the shape that was encrypted.
    final bool same = roundTrip.fold(
      (_) => false,
      (Object? decrypted) => jsonEncode(decrypted) == jsonEncode(json),
    );
    if (!same) return Left(verifyFailed);

    dto.onStage?.call(MigrationStage.finishing);
    // The copy is safe and checked; failing to tidy the old file must not
    // read as a failed move.
    final Either<Failure, String?> renamed = await _auth.authorized(
      (String token) => _storage.detachVault(source.provider, token),
    );
    return Right(renamed.getOrElse(() => null));
  }

  static Failure _failureOf<T>(Either<Failure, T> result) => result.fold(
    (Failure failure) => failure,
    (_) => throw StateError('Right'),
  );
}
