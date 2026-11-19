import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/lock_settings_repository_impl.dart';

@singleton
class SaveAutoLockDelay implements Usecase<Unit, AutoLockDelay> {
  final ILockSettingsRepository _repository;

  SaveAutoLockDelay(this._repository);

  @override
  Future<Either<Failure, Unit>> call(AutoLockDelay delay) =>
      _repository.saveAutoLockDelay(delay);
}
