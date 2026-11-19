import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// "Archive vault and sign out" (web `DangerZoneSection.deleteAccount`): the
/// file is renamed so the app stops finding it — nothing is deleted — and
/// then the phone signs out. A failed rename signs nothing out. The result
/// is the file's new name, null when there was no file to rename.
@singleton
class ArchiveVault implements Usecase<String?, NoParams> {
  final IAuthRepository _auth;
  final IVaultStorageRepository _storage;
  final VaultSessionService _vault;

  ArchiveVault(this._auth, this._storage, this._vault);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    final ProviderAccount? account = _auth.account;
    if (account == null) return const Left(Failure.vaultLocked());

    final Either<Failure, String?> detached = await _auth.authorized(
      (String token) => _storage.detachVault(account.provider, token),
    );
    return detached.fold(Left.new, (String? renamed) async {
      _vault.wipe();
      await _auth.signOut();
      return Right(renamed);
    });
  }
}
