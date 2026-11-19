import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/bundled_data_repository_impl.dart';

/// Country names in the five app languages (web `Intl.DisplayNames`), for
/// `countryName`.
@singleton
class GetCountryNames implements Usecase<Map<String, dynamic>, NoParams> {
  final IBundledDataRepository _repository;

  GetCountryNames(this._repository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams params) =>
      _repository.countryNames();
}
