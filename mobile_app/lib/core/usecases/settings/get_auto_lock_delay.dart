import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/lock_settings_repository_impl.dart';

@singleton
class GetAutoLockDelay implements Usecase<AutoLockDelay, NoParams> {
  final ILockSettingsRepository _repository;

  GetAutoLockDelay(this._repository);

  @override
  Future<Either<Failure, AutoLockDelay>> call(NoParams params) =>
      _repository.getAutoLockDelay();
}
