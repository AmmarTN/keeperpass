import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';

/// "Checking your vault…": whether this account already has a vault file,
/// without downloading it — Unlock when found, Create when not (web
/// `vaultStepGuard`).
@singleton
class CheckVault implements Usecase<VaultFileInfo?, NoParams> {
  final IAuthRepository _auth;
  final IVaultStorageRepository _storage;

  CheckVault(this._auth, this._storage);

  @override
  Future<Either<Failure, VaultFileInfo?>> call(NoParams params) async {
    final ProviderAccount? account = _auth.account;
    if (account == null) return const Left(Failure.accessTokenFailure());
    return _auth.authorized(
      (String token) => _storage.findVault(account.provider, token),
    );
  }
}
