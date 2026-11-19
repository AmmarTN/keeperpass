import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/history_entry_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/items/history_entry.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Removes one earlier version for good (web
/// `VaultStore.deleteHistoryEntry`); nothing else about the item changes.
/// The caller saves.
@singleton
class DeleteHistoryEntry implements UnawaitedUsecase<Unit, HistoryEntryDto> {
  final VaultSessionService _vault;

  DeleteHistoryEntry(this._vault);

  @override
  Either<Failure, Unit> call(HistoryEntryDto params) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    final VaultItem? item = snapshot.items
        .where((VaultItem i) => i.id == params.itemId)
        .firstOrNull;
    if (item == null ||
        params.index < 0 ||
        params.index >= item.history.length) {
      return const Left(Failure.unableToProcess('No such version'));
    }
    _vault.update(
      snapshot.copyWith(
        items: <VaultItem>[
          for (final VaultItem i in snapshot.items)
            i.id == item.id
                ? i.copyWith(
                    history: <HistoryEntry>[
                      for (int k = 0; k < i.history.length; k++)
                        if (k != params.index) i.history[k],
                    ],
                  )
                : i,
        ],
      ),
    );
    return const Right(unit);
  }
}
