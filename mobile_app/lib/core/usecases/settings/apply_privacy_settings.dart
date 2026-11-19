import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/lock_settings_repository_impl.dart';
import 'package:keeperpass/infrastructure/services/privacy_service.dart';

/// Puts the saved "Hide in app switcher" and "Block screenshots" into
/// effect: at launch, and after either changes.
@singleton
class ApplyPrivacySettings implements Usecase<Unit, NoParams> {
  final ILockSettingsRepository _repository;
  final PrivacyService _privacy;

  ApplyPrivacySettings(this._repository, this._privacy);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    final bool hide = (await _repository.getHideInSwitcher()).getOrElse(
      () => true,
    );
    final bool block = (await _repository.getBlockScreenshots()).getOrElse(
      () => true,
    );
    await _privacy.apply(hideInSwitcher: hide, blockScreenshots: block);
    return const Right(unit);
  }
}
