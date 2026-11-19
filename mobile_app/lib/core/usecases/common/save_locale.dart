import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/locale_repository_impl.dart';

@singleton
class SaveLocale implements Usecase<Unit, String> {
  final ILocaleRepository _repository;

  SaveLocale(this._repository);

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return _repository.saveLocale(params);
  }
}
