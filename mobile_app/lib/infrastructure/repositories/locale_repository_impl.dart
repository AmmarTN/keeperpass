import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/locale_local_data_source.dart';

abstract class ILocaleRepository {
  /// The language saved on this device, or null when none was chosen yet.
  Future<Either<Failure, String?>> getSavedLocale();

  /// Saves the chosen language on this device.
  Future<Either<Failure, Unit>> saveLocale(String localeCode);
}

@Singleton(as: ILocaleRepository)
class LocaleRepositoryImpl implements ILocaleRepository {
  final ILocaleLocalDataSource _localDataSource;

  LocaleRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, String?>> getSavedLocale() async {
    try {
      return Right(_localDataSource.readLocale());
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveLocale(String localeCode) async {
    try {
      await _localDataSource.writeLocale(localeCode);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheWriteFailure());
    }
  }
}
