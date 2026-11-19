import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/history_entry_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/items/item_history.dart';
import 'package:keeperpass/infrastructure/models/items/history_entry.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Brings an item back to an earlier version (web
/// `VaultStore.restoreHistoryEntry`): just another edit — the current state
/// goes into history first, so restoring is itself undoable — of the name,
/// fields and tags (the picked icon stays); the tags are registered. The
/// caller saves and re-runs the audit for the item.
@singleton
class RestoreHistoryEntry implements UnawaitedUsecase<Unit, HistoryEntryDto> {
  final VaultSessionService _vault;
  final DateTime Function() _now;

  RestoreHistoryEntry(this._vault, {@ignoreParam this._now = DateTime.now});

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
      // A stale index (the version was deleted meanwhile): nothing happens.
      return const Left(Failure.unableToProcess('No such version'));
    }
    final HistoryEntry entry = item.history[params.index];
    final DateTime now = _now();
    _vault.update(
      snapshot.copyWith(
        items: <VaultItem>[
          for (final VaultItem i in snapshot.items)
            i.id == item.id
                ? withHistorySnapshot(
                    i,
                    now: now,
                    name: entry.name,
                    fields: entry.fields,
                    tags: entry.tags,
                  )
                : i,
        ],
        tagRegistry: registerTags(snapshot.tagRegistry, entry.tags, now),
      ),
    );
    return const Right(unit);
  }
}
