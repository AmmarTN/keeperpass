import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/change_secret_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/crypto/vault_cipher.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Settings › Change secret (web `MasterPasswordService.change`): the current
/// secret is proved by decrypting the stored vault with it — not by
/// comparing with the one in memory — then the same data is encrypted under
/// the new secret and saved.
@singleton
class ChangeSecret implements Usecase<Unit, ChangeSecretDto> {
  ChangeSecret(
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
  Future<Either<Failure, Unit>> call(ChangeSecretDto dto) async {
    final ProviderAccount? account = _auth.account;
    if (account == null) return const Left(Failure.vaultLocked());

    final Either<Failure, String?> stored = await _auth.authorized(
      (String token) => _storage.loadVault(account.provider, token),
    );
    return stored.fold(Left.new, (String? content) async {
      if (content == null) return const Left(Failure.vaultNotFound());
      final Either<Failure, Object?> data = await _cipher.decrypt(
        dto.currentSecret,
        content,
      );
      return data.fold(Left.new, (Object? json) async {
        dto.onVerified?.call();
        final String encrypted = await _cipher.encrypt(dto.newSecret, json);
        final Either<Failure, Unit> saved = await _auth.authorized(
          (String token) => _storage.saveVault(
            account.provider,
            token,
            encrypted,
            onProgress: dto.onProgress,
          ),
        );
        return saved.map((_) {
          _vault.changeSecret(dto.newSecret);
          if (_vault.isOpen) _vault.markWritten(_now());
          return unit;
        });
      });
    });
  }
}
