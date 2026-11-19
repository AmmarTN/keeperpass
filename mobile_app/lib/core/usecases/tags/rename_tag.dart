import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/rename_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/items/tag_changes.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Renames a tag on every item carrying it (web `VaultStore.renameTag`,
/// each item's earlier version kept in its history). The caller saves.
@singleton
class RenameTag implements UnawaitedUsecase<Unit, RenameDto> {
  final VaultSessionService _vault;
  final DateTime Function() _now;

  RenameTag(this._vault, {@ignoreParam this._now = DateTime.now});

  @override
  Either<Failure, Unit> call(RenameDto dto) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    _vault.update(renameTag(snapshot, dto.id, dto.name, _now()));
    return const Right(unit);
  }
}
