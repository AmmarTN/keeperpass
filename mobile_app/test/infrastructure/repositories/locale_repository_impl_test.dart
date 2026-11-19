import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/locale_local_data_source.dart';
import 'package:keeperpass/infrastructure/repositories/locale_repository_impl.dart';

final class FakeLocaleLocalDataSource implements ILocaleLocalDataSource {
  String? value;
  bool fails = false;

  @override
  String? readLocale() {
    if (fails) throw StateError('storage unavailable');
    return value;
  }

  @override
  Future<void> writeLocale(String localeCode) async {
    if (fails) throw StateError('storage unavailable');
    value = localeCode;
  }
}

void main() {
  test('persists locale through the local data source boundary', () async {
    final FakeLocaleLocalDataSource dataSource = FakeLocaleLocalDataSource();
    final LocaleRepositoryImpl repository = LocaleRepositoryImpl(dataSource);

    final Either<Failure, Unit> writeResult = await repository.saveLocale('de');
    final Either<Failure, String?> readResult = await repository
        .getSavedLocale();

    expect(writeResult, const Right<Failure, Unit>(unit));
    expect(readResult.getOrElse(() => null), 'de');
  });

  test('storage errors become cache failures', () async {
    final FakeLocaleLocalDataSource dataSource = FakeLocaleLocalDataSource()
      ..fails = true;
    final LocaleRepositoryImpl repository = LocaleRepositoryImpl(dataSource);

    expect(
      await repository.getSavedLocale(),
      const Left<Failure, String?>(Failure.cacheReadFailure()),
    );
    expect(
      await repository.saveLocale('fr'),
      const Left<Failure, Unit>(Failure.cacheWriteFailure()),
    );
  });
}
