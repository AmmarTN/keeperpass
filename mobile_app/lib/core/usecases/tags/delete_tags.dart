import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/items/tag_changes.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Deletes tags from every item and the registry (web
/// `VaultStore.deleteTags`, each item's earlier version kept in its
/// history); the items stay. The caller saves.
@singleton
class DeleteTags implements UnawaitedUsecase<Unit, List<String>> {
  final VaultSessionService _vault;
  final DateTime Function() _now;

  DeleteTags(this._vault, {@ignoreParam this._now = DateTime.now});

  @override
  Either<Failure, Unit> call(List<String> names) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    _vault.update(deleteTags(snapshot, names, _now()));
    return const Right(unit);
  }
}
