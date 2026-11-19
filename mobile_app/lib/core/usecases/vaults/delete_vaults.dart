import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/vaults/vault_changes.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Deletes vaults, their items moving to the personal vault (web
/// `VaultStore.deleteVault`, once per vault); the personal vault is never
/// deleted. How many went. The caller saves.
@singleton
class DeleteVaults implements UnawaitedUsecase<int, List<String>> {
  final VaultSessionService _vault;

  DeleteVaults(this._vault);

  @override
  Either<Failure, int> call(List<String> vaultIds) {
    VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    int deleted = 0;
    for (final String id in vaultIds) {
      final VaultSnapshot? after = deleteVault(snapshot!, id);
      if (after == null) continue;
      snapshot = after;
      deleted++;
    }
    if (deleted > 0) _vault.update(snapshot!);
    return Right(deleted);
  }
}
