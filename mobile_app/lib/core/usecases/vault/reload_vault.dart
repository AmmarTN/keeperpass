import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/crypto/vault_cipher.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/repositories/vault_storage_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// "Load the latest" after a Dropbox conflict (board `Sync-states`): the
/// stored file replaces what this phone holds, opened with the same secret.
@singleton
class ReloadVault implements Usecase<VaultSnapshot, NoParams> {
  ReloadVault(
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
  Future<Either<Failure, VaultSnapshot>> call(NoParams params) async {
    final ProviderAccount? account = _auth.account;
    final String? secret = _vault.secret;
    if (account == null || secret == null) {
      return const Left(Failure.vaultLocked());
    }

    final Either<Failure, String?> stored = await _auth.authorized(
      (String token) => _storage.loadVault(account.provider, token),
    );
    return stored.fold(Left.new, (String? content) async {
      if (content == null) return const Left(Failure.vaultNotFound());
      final Either<Failure, VaultSnapshot> opened = await _cipher.open(
        secret,
        content,
      );
      return opened.map((VaultSnapshot snapshot) {
        _vault.reload(snapshot, _now());
        return snapshot;
      });
    });
  }
}
