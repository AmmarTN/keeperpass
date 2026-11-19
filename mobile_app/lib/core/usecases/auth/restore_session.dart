import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';

/// At launch: the sign-in remembered on this phone, if any (D10).
@singleton
class RestoreSession implements Usecase<RememberedSession?, NoParams> {
  final IAuthRepository _repository;

  RestoreSession(this._repository);

  @override
  Future<Either<Failure, RememberedSession?>> call(NoParams params) =>
      _repository.restoreSession();
}
