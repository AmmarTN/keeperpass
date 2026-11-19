import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/new_vault_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Create (web `SetupPage.submit`): saves the first vault, already encrypted
/// ([EncryptNewVault]), then opens it.
@singleton
class CreateVault implements Usecase<VaultSnapshot, NewVaultDto> {
  CreateVault(
    this._auth,
    this._storage,
    this._vault, {
    @ignoreParam this._now = DateTime.now,
  });

  final IAuthRepository _auth;
  final IVaultStorageRepository _storage;
  final VaultSessionService _vault;
  final DateTime Function() _now;

  @override
  Future<Either<Failure, VaultSnapshot>> call(NewVaultDto dto) async {
    final ProviderAccount? account = _auth.account;
    if (account == null) return const Left(Failure.accessTokenFailure());

    final Either<Failure, Unit> saved = await _auth.authorized(
      (String token) => _storage.saveVault(
        account.provider,
        token,
        dto.vault.encrypted,
        onProgress: dto.onProgress,
      ),
    );
    return saved.map((_) {
      _vault.open(dto.vault.snapshot, dto.vault.secret, _now());
      return dto.vault.snapshot;
    });
  }
}
