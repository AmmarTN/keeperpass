import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/lock_settings_repository_impl.dart';

/// Settings › Security, on this phone only (board `S5-13`).
@singleton
class SaveHideInSwitcher implements Usecase<Unit, bool> {
  final ILockSettingsRepository _repository;

  SaveHideInSwitcher(this._repository);

  @override
  Future<Either<Failure, Unit>> call(bool params) =>
      _repository.saveHideInSwitcher(params);
}
