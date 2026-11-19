import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Stars or unstars an item (web `VaultStore.toggleFavourite`); returns
/// whether it is a favorite now. The caller saves.
@singleton
class ToggleFavourite implements UnawaitedUsecase<bool, String> {
  final VaultSessionService _vault;

  ToggleFavourite(this._vault);

  @override
  Either<Failure, bool> call(String itemId) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    final bool favourite = !snapshot.favouriteIds.contains(itemId);
    _vault.update(
      snapshot.copyWith(
        favouriteIds: favourite
            ? <String>[...snapshot.favouriteIds, itemId]
            : snapshot.favouriteIds.where((String id) => id != itemId).toList(),
      ),
    );
    return Right(favourite);
  }
}
