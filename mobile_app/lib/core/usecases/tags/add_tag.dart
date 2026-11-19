import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/items/tag_changes.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// "Add tag": a tag with no items yet (web `VaultStore.createTag`). The
/// caller saves.
@singleton
class AddTag implements UnawaitedUsecase<Unit, String> {
  final VaultSessionService _vault;
  final DateTime Function() _now;

  AddTag(this._vault, {@ignoreParam this._now = DateTime.now});

  @override
  Either<Failure, Unit> call(String name) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    _vault.update(addTag(snapshot, name, _now()));
    return const Right(unit);
  }
}
