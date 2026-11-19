import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/item_edit_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/items/item_history.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Saves an edit (web `VaultStore.updateItem`): the item as it was goes to
/// the front of its history (at most 5 kept), the name, fields, tags and
/// picked icon change, `updated` becomes now, and the tags are registered.
/// The caller saves and checks the item's passwords again.
@singleton
class UpdateItem implements UnawaitedUsecase<Unit, ItemEditDto> {
  final VaultSessionService _vault;
  final DateTime Function() _now;

  UpdateItem(this._vault, {@ignoreParam this._now = DateTime.now});

  @override
  Either<Failure, Unit> call(ItemEditDto params) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    if (!snapshot.items.any((VaultItem i) => i.id == params.itemId)) {
      return const Left(Failure.unableToProcess('No such item'));
    }
    final DateTime now = _now();
    _vault.update(
      snapshot.copyWith(
        items: <VaultItem>[
          for (final VaultItem item in snapshot.items)
            item.id == params.itemId
                ? withHistorySnapshot(
                    item,
                    now: now,
                    name: params.name,
                    fields: params.fields,
                    tags: params.tags,
                  ).copyWith(iconGlyph: params.iconGlyph)
                : item,
        ],
        tagRegistry: registerTags(snapshot.tagRegistry, params.tags, now),
      ),
    );
    return const Right(unit);
  }
}
