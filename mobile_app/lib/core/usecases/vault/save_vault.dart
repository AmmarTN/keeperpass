import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/save_vault_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/crypto/vault_cipher.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Encrypts the open vault with a fresh salt and IV and uploads the whole
/// file (web `VaultSyncService.save`). Called after every committed change.
@singleton
class SaveVault implements Usecase<Unit, SaveVaultDto> {
  SaveVault(
    this._auth,
    this._storage,
    this._cipher,
    this._vault, {
    @ignoreParam this._now = DateTime.now,
  });

  final IAuthRepository _auth;
  final IVaultStorageRepository _storage;
  final VaultCipher _cipher;
  final VaultSessionService _vault;
  final DateTime Function() _now;

  @override
  Future<Either<Failure, Unit>> call(SaveVaultDto dto) async {
    final ProviderAccount? account = _auth.account;
    final VaultSnapshot? snapshot = _vault.snapshot;
    final String? secret = _vault.secret;
    if (account == null || snapshot == null || secret == null) {
      return const Left(Failure.vaultLocked());
    }

    _vault.saving = true;
    try {
      final String encrypted = await _cipher.encrypt(
        secret,
        snapshot.toVaultJson(),
      );
      final Either<Failure, Unit> saved = await _auth.authorized(
        (String token) => _storage.saveVault(
          account.provider,
          token,
          encrypted,
          onProgress: dto.onProgress,
        ),
      );
      if (saved.isRight() && _vault.isOpen) _vault.markWritten(_now());
      return saved;
    } finally {
      _vault.saving = false;
    }
  }
}
