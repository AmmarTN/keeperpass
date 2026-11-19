import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/move_items_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Moves items to another vault, with their history and tags (web
/// `VaultStore.moveItems`: only the vault changes). The caller saves.
@singleton
class MoveItems implements UnawaitedUsecase<Unit, MoveItemsDto> {
  final VaultSessionService _vault;

  MoveItems(this._vault);

  @override
  Either<Failure, Unit> call(MoveItemsDto dto) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    final Set<String> ids = dto.itemIds.toSet();
    _vault.update(
      snapshot.copyWith(
        items: <VaultItem>[
          for (final VaultItem item in snapshot.items)
            ids.contains(item.id) ? item.copyWith(vaultId: dto.vaultId) : item,
        ],
      ),
    );
    return const Right(unit);
  }
}
