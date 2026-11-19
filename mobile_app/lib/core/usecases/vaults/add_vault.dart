import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';
import 'package:uuid/uuid.dart';

/// "New vault": an empty personal vault after the others (web
/// `VaultStore.createVault`; the name is checked by the sheet). The caller
/// saves.
@singleton
class AddVault implements UnawaitedUsecase<Vault, String> {
  final VaultSessionService _vault;
  final DateTime Function() _now;

  AddVault(this._vault, {@ignoreParam this._now = DateTime.now});

  @override
  Either<Failure, Vault> call(String name) {
    final VaultSnapshot? snapshot = _vault.snapshot;
    if (snapshot == null) return const Left(Failure.vaultLocked());
    final Vault vault = Vault(
      id: const Uuid().v4(),
      name: name,
      created: _now().toUtc(),
    );
    _vault.update(
      snapshot.copyWith(vaults: <Vault>[...snapshot.vaults, vault]),
    );
    return Right(vault);
  }
}
