import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/dtos/rename_dto.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/vaults/vault_changes.dart' as changes;
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Renames a vault (web `VaultStore.renameVault`; the sheet checks the
/// name). The caller saves.
@singleton
class RenameVault implements UnawaitedUsecase<Unit, RenameDto> {
  final VaultSessionService _vault;

  RenameVault(this._vault);

  @override
  Either<Failure, Unit> call(RenameDto dto) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    _vault.update(changes.renameVault(snapshot, dto.id, dto.name));
    return const Right(unit);
  }
}
