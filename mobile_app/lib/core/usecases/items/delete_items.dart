import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/repositories/recent_items_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Deletes items for good (web `VaultStore.deleteItems`): their favorite
/// marks go with them, and they leave Recently Used (web `confirmDelete`).
/// The caller saves.
@singleton
class DeleteItems implements Usecase<Unit, List<String>> {
  final VaultSessionService _vault;
  final IRecentItemsRepository _recent;

  DeleteItems(this._vault, this._recent);

  @override
  Future<Either<Failure, Unit>> call(List<String> itemIds) async {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    final Set<String> ids = itemIds.toSet();
    _vault.update(
      snapshot.copyWith(
        items: snapshot.items
            .where((VaultItem item) => !ids.contains(item.id))
            .toList(),
        favouriteIds: snapshot.favouriteIds
            .where((String id) => !ids.contains(id))
            .toList(),
      ),
    );
    // Recently Used is a convenience on this phone: failing to update it
    // never undoes the delete.
    await _recent.forget(ids);
    return const Right(unit);
  }
}
