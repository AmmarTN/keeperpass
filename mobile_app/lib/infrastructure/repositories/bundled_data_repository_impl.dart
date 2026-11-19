import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/utils/icons/icon_catalog.dart';
import 'package:keeperpass/core/utils/text/relative_time.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/bundled_data_local_data_source.dart';

abstract class IBundledDataRepository {
  /// The passphrase words for [language] (English when there is no list).
  Future<Either<Failure, List<String>>> wordList(String language);

  /// "3 days ago" in the five app languages.
  Future<Either<Failure, RelativeTimeFormatter>> relativeTime();

  /// Country names by language, then ISO code (`countryName` reads them).
  Future<Either<Failure, Map<String, dynamic>>> countryNames();

  /// The icon picker's catalogue.
  Future<Either<Failure, List<CatalogIcon>>> iconCatalog();
}

@Singleton(as: IBundledDataRepository)
class BundledDataRepositoryImpl implements IBundledDataRepository {
  final IBundledDataLocalDataSource _localDataSource;

  BundledDataRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, List<String>>> wordList(String language) async {
    try {
      final List<String> words = await _localDataSource.wordList(language);
      if (words.isEmpty) return const Left(Failure.cacheReadFailure());
      return Right(words);
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Future<Either<Failure, RelativeTimeFormatter>> relativeTime() async {
    try {
      return Right(
        RelativeTimeFormatter(await _localDataSource.relativeTimeTable()),
      );
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> countryNames() async {
    try {
      return Right(await _localDataSource.countryNames());
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Future<Either<Failure, List<CatalogIcon>>> iconCatalog() async {
    try {
      return Right(parseIconCatalog(await _localDataSource.iconCatalog()));
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }
}
