import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/auth_repository_impl.dart';

/// Where the vault could move to: configured in this build, and not the
/// provider in use (web `VaultMigrationService.targets`).
@singleton
class GetMigrationTargets
    implements UnawaitedUsecase<List<ProviderId>, NoParams> {
  final IAuthRepository _auth;

  GetMigrationTargets(this._auth);

  @override
  Either<Failure, List<ProviderId>> call(NoParams params) => Right(<ProviderId>[
    for (final ProviderId id in _auth.availableProviders())
      if (id != _auth.account?.provider) id,
  ]);
}
