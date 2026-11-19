import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

/// Log out, "Use another account", after archiving or moving the vault
/// (web `disconnectSession`): the vault is wiped from memory and the phone
/// forgets the sign-in.
@singleton
class SignOut implements Usecase<Unit, NoParams> {
  final IAuthRepository _repository;
  final VaultSessionService _vault;

  SignOut(this._repository, this._vault);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    _vault.wipe();
    return _repository.signOut();
  }
}
