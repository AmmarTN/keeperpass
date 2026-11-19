import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/vault_secret_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/crypto/vault_cipher.dart';
import 'package:keeperpass/infrastructure/models/vault/prepared_vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';

/// "Encrypting your vault…": an empty vault (web
/// `createEmptyVaultSnapshot`), encrypted with the chosen secret on this
/// phone. Nothing is sent yet.
@singleton
class EncryptNewVault implements Usecase<PreparedVault, VaultSecretDto> {
  EncryptNewVault(this._cipher, {@ignoreParam this._now = DateTime.now});

  final VaultCipher _cipher;
  final DateTime Function() _now;

  @override
  Future<Either<Failure, PreparedVault>> call(VaultSecretDto dto) async {
    final VaultSnapshot snapshot = VaultSnapshot.empty(
      vaultName: dto.vaultName,
      now: _now(),
    );
    final String encrypted = await _cipher.encrypt(
      dto.secret,
      snapshot.toVaultJson(),
    );
    return Right(
      PreparedVault(
        snapshot: snapshot,
        secret: dto.secret,
        encrypted: encrypted,
      ),
    );
  }
}
