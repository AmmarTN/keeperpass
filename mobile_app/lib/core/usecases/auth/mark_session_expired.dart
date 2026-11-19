import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Before unlocking, the session could not be renewed: the phone keeps the
/// account only to say "Welcome back" (board `U2-Connect`).
@singleton
class MarkSessionExpired implements Usecase<Unit, NoParams> {
  final IAuthRepository _repository;
  final VaultSessionService _vault;

  MarkSessionExpired(this._repository, this._vault);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    _vault.wipe();
    return _repository.markExpired();
  }
}
