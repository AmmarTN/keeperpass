import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Locking (web `lockSession`): the decrypted vault and the secret are wiped
/// from memory; the provider sign-in stays, so unlocking only asks for the
/// secret again.
@singleton
class LockVault implements UnawaitedUsecase<Unit, NoParams> {
  final VaultSessionService _vault;

  LockVault(this._vault);

  @override
  Either<Failure, Unit> call(NoParams params) {
    _vault.wipe();
    return const Right(unit);
  }
}
