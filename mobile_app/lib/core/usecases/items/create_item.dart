import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/item_edit_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/items/item_history.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Adds a new item from its draft (web `VaultStore.createItem`): created and
/// updated now, no history yet, its tags registered. Nothing reaches the
/// vault before this — the draft lives only on its screen. The caller saves
/// and checks the item's passwords.
@singleton
class CreateItem implements UnawaitedUsecase<VaultItem, ItemEditDto> {
  final VaultSessionService _vault;
  final DateTime Function() _now;

  CreateItem(this._vault, {@ignoreParam this._now = DateTime.now});

  @override
  Either<Failure, VaultItem> call(ItemEditDto params) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    final String? vaultId = params.vaultId;
    if (vaultId == null) {
      return const Left(Failure.unableToProcess('No vault'));
    }
    final DateTime now = _now().toUtc();
    final VaultItem item = VaultItem(
      id: params.itemId,
      vaultId: vaultId,
      name: params.name,
      icon: params.icon,
      iconGlyph: params.iconGlyph,
      fields: params.fields,
      tags: params.tags,
      created: now,
      updated: now,
    );
    _vault.update(
      snapshot.copyWith(
        items: <VaultItem>[...snapshot.items, item],
        tagRegistry: registerTags(snapshot.tagRegistry, params.tags, now),
      ),
    );
    return Right(item);
  }
}
