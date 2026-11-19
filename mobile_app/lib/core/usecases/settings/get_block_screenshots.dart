import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/lock_settings_repository_impl.dart';

/// Settings › Security on Android, on this phone only (board
/// `Lock-privacy`).
@singleton
class GetBlockScreenshots implements Usecase<bool, NoParams> {
  final ILockSettingsRepository _repository;

  GetBlockScreenshots(this._repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) =>
      _repository.getBlockScreenshots();
}
