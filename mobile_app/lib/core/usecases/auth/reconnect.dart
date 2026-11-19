import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';

/// "Reconnect" after the session expired with the vault open (board
/// `Sync-states`): the same account only; another one is refused.
@singleton
class Reconnect implements Usecase<ProviderAccount, NoParams> {
  final IAuthRepository _repository;
  final LockService _lock;

  Reconnect(this._repository, this._lock);

  @override
  Future<Either<Failure, ProviderAccount>> call(NoParams params) =>
      _lock.duringExternalUi(_repository.reconnect);
}
