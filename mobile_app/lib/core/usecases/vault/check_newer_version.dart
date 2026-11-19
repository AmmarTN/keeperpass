import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';

/// Before editing (board `Sync-states`, "Changed on another device"): the
/// stored file when it is newer than the one this phone opened. Dropbox
/// only; Google Drive is last-save-wins (D9) and answers null.
@singleton
class CheckNewerVersion implements Usecase<VaultFileInfo?, NoParams> {
  final IAuthRepository _auth;
  final IVaultStorageRepository _storage;

  CheckNewerVersion(this._auth, this._storage);

  @override
  Future<Either<Failure, VaultFileInfo?>> call(NoParams params) async {
    final ProviderAccount? account = _auth.account;
    if (account == null) return const Left(Failure.vaultLocked());
    return _auth.authorized(
      (String token) => _storage.newerVersion(account.provider, token),
    );
  }
}
