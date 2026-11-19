import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';

/// Signs in to the destination and reports whether it already holds a
/// vault (web `VaultMigrationService.connect`). The destination's token is
/// held only for the move, never put on the session.
@singleton
class ConnectMigrationTarget implements Usecase<MigrationTarget, ProviderId> {
  final IAuthRepository _auth;
  final IVaultStorageRepository _storage;
  final LockService _lock;

  ConnectMigrationTarget(this._auth, this._storage, this._lock);

  @override
  Future<Either<Failure, MigrationTarget>> call(ProviderId target) async {
    if (target == _auth.account?.provider) {
      return const Left(Failure.migration(MigrationError.sameProvider));
    }
    final Either<Failure, ProviderSignIn> signIn = await _lock.duringExternalUi(
      () => _auth.signInElsewhere(target),
    );
    return signIn.fold(Left.new, (ProviderSignIn signIn) async {
      final Either<Failure, VaultFileInfo?> existing = await _storage.findVault(
        target,
        signIn.grant.accessToken,
      );
      return existing.map(
        (VaultFileInfo? file) => MigrationTarget(
          accessToken: signIn.grant.accessToken,
          email: signIn.profile.email,
          name: signIn.profile.name,
          hasVault: file != null,
        ),
      );
    });
  }
}
