import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/vault_secret_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/crypto/vault_cipher.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Unlock (web `UnlockPage.submit`): download, derive the key, decrypt, and
/// open the vault in memory. When the file has gone missing since the check,
/// a first vault is created with this secret, as on the web.
@singleton
class UnlockVault implements Usecase<VaultSnapshot, VaultSecretDto> {
  UnlockVault(
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
  Future<Either<Failure, VaultSnapshot>> call(VaultSecretDto dto) async {
    final ProviderAccount? account = _auth.account;
    if (account == null) return const Left(Failure.accessTokenFailure());

    final Either<Failure, String?> stored = await _auth.authorized(
      (String token) => _storage.loadVault(account.provider, token),
    );
    return stored.fold(Left.new, (String? content) async {
      if (content != null) {
        final Either<Failure, VaultSnapshot> opened = await _cipher.open(
          dto.secret,
          content,
        );
        return opened.map((VaultSnapshot snapshot) {
          _vault.open(snapshot, dto.secret, _now());
          return snapshot;
        });
      }

      final VaultSnapshot snapshot = VaultSnapshot.empty(
        vaultName: dto.vaultName,
        now: _now(),
      );
      final String encrypted = await _cipher.encrypt(
        dto.secret,
        snapshot.toVaultJson(),
      );
      final Either<Failure, Unit> saved = await _auth.authorized(
        (String token) =>
            _storage.saveVault(account.provider, token, encrypted),
      );
      return saved.map((_) {
        _vault.open(snapshot, dto.secret, _now());
        return snapshot;
      });
    });
  }
}
