import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/theme_preference.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/theme_local_data_source.dart';

abstract class IThemeRepository {
  /// The theme saved on this device; [ThemePreference.auto] when none was chosen.
  Future<Either<Failure, ThemePreference>> getThemePreference();

  /// Saves the chosen theme on this device (not part of the vault).
  Future<Either<Failure, Unit>> saveThemePreference(ThemePreference preference);
}

@Singleton(as: IThemeRepository)
class ThemeRepositoryImpl implements IThemeRepository {
  final IThemeLocalDataSource _localDataSource;

  ThemeRepositoryImpl(this._localDataSource);

  @override
  Future<Either<Failure, ThemePreference>> getThemePreference() async {
    try {
      final String? stored = _localDataSource.readThemePreference();
      return Right(
        ThemePreference.values.firstWhere(
          (ThemePreference preference) => preference.name == stored,
          orElse: () => ThemePreference.auto,
        ),
      );
    } catch (e) {
      return const Left(Failure.cacheReadFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveThemePreference(
    ThemePreference preference,
  ) async {
    try {
      await _localDataSource.writeThemePreference(preference.name);
      return const Right(unit);
    } catch (e) {
      return const Left(Failure.cacheWriteFailure());
    }
  }
}
