import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/models/auth/provider_account.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';

/// "Continue with Google / Dropbox": the provider's own page, then the
/// session remembers the account.
@singleton
class SignIn implements Usecase<ProviderAccount, ProviderId> {
  final IAuthRepository _repository;
  final LockService _lock;

  SignIn(this._repository, this._lock);

  @override
  Future<Either<Failure, ProviderAccount>> call(ProviderId provider) =>
      _lock.duringExternalUi(() => _repository.signIn(provider));
}
