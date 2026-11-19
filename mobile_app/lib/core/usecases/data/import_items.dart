import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/import_items_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/import_export/csv.dart';
import 'package:keeperpass/core/utils/items/item_history.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:uuid/uuid.dart';

/// Adds the items read from a CSV to one vault (web `VaultStore.addItems`):
/// new ids, created and updated now, no history, their tags registered.
/// Nothing is replaced. The result is how many were added; the caller
/// saves.
@singleton
class ImportItems implements UnawaitedUsecase<int, ImportItemsDto> {
  final VaultSessionService _vault;
  final DateTime Function() _now;

  ImportItems(this._vault, {@ignoreParam this._now = DateTime.now});

  @override
  Either<Failure, int> call(ImportItemsDto params) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    final DateTime now = _now().toUtc();
    final List<VaultItem> items = <VaultItem>[
      for (final ItemDraft draft in params.drafts)
        VaultItem(
          id: const Uuid().v4(),
          vaultId: params.vaultId,
          name: draft.name,
          fields: <Field>[...draft.fields],
          tags: <String>[...draft.tags],
          created: now,
          updated: now,
        ),
    ];
    _vault.update(
      snapshot.copyWith(
        items: <VaultItem>[...snapshot.items, ...items],
        tagRegistry: registerTags(
          snapshot.tagRegistry,
          items.expand((VaultItem item) => item.tags),
          now,
        ),
      ),
    );
    return Right(items.length);
  }
}
