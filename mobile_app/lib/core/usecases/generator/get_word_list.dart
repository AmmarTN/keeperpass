import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/bundled_data_repository_impl.dart';

/// A passphrase language's word list (English when there is none).
@singleton
class GetWordList implements Usecase<List<String>, String> {
  final IBundledDataRepository _repository;

  GetWordList(this._repository);

  @override
  Future<Either<Failure, List<String>>> call(String language) =>
      _repository.wordList(language);
}
