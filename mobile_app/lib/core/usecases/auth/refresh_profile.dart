import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';

/// Re-reads the signed-in name and address (web `UnlockPage` on mount).
@singleton
class RefreshProfile implements Usecase<ProviderAccount, NoParams> {
  final IAuthRepository _repository;

  RefreshProfile(this._repository);

  @override
  Future<Either<Failure, ProviderAccount>> call(NoParams params) =>
      _repository.refreshProfile();
}
