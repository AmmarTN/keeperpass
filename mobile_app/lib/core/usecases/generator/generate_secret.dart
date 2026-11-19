import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/generator/generator.dart';
import 'package:keeperpass/infrastructure/repositories/bundled_data_repository_impl.dart';

/// "Generate a secret" on Create and Start a new vault (board `U2-Create`):
/// five random words joined by "-", from the app language's word list
/// (your decision, 2026-10-31; English when the language has none).
@singleton
class GenerateSecret implements Usecase<String, String> {
  final IBundledDataRepository _repository;

  GenerateSecret(this._repository);

  static const int wordCount = 5;
  static const String separator = '-';

  @override
  Future<Either<Failure, String>> call(String language) async {
    final Either<Failure, List<String>> words = await _repository.wordList(
      language,
    );
    return words.map(
      (List<String> list) => generatePassphrase(list, wordCount, separator),
    );
  }
}
