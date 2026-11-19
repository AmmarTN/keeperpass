import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/locale_repository_impl.dart';

@singleton
class GetSavedLocale implements Usecase<String?, NoParams> {
  final ILocaleRepository _repository;

  GetSavedLocale(this._repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) {
    return _repository.getSavedLocale();
  }
}
