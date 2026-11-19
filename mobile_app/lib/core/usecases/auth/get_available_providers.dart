import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';

/// The sign-in buttons: every provider this build is configured for.
@singleton
class GetAvailableProviders
    implements UnawaitedUsecase<List<ProviderId>, NoParams> {
  final IAuthRepository _repository;

  GetAvailableProviders(this._repository);

  @override
  Either<Failure, List<ProviderId>> call(NoParams params) =>
      Right(_repository.availableProviders());
}
