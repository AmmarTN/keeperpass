import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/theme_preference.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/common/get_theme_preference.dart';
import 'package:keeperpass/core/usecases/common/save_theme_preference.dart';
import 'package:keeperpass/infrastructure/datasources/local_datasources/theme_local_data_source.dart';
import 'package:keeperpass/infrastructure/repositories/theme_repository_impl.dart';
import 'package:keeperpass/presentation/common/cubit/theme/theme_cubit.dart';

final class FakeThemeLocalDataSource implements IThemeLocalDataSource {
  FakeThemeLocalDataSource([this.value]);

  String? value;
  bool fails = false;

  @override
  String? readThemePreference() {
    if (fails) throw StateError('storage unavailable');
    return value;
  }

  @override
  Future<void> writeThemePreference(String preference) async {
    if (fails) throw StateError('storage unavailable');
    value = preference;
  }
}

ThemeCubit cubitWith(FakeThemeLocalDataSource dataSource) {
  final ThemeRepositoryImpl repository = ThemeRepositoryImpl(dataSource);
  return ThemeCubit(
    GetThemePreference(repository),
    SaveThemePreference(repository),
  );
}

void main() {
  test('defaults to Auto, which follows the phone', () async {
    final ThemeCubit cubit = cubitWith(FakeThemeLocalDataSource());
    await cubit.restore();
    expect(cubit.state, ThemePreference.auto);
    expect(cubit.themeMode, ThemeMode.system);
    await cubit.close();
  });

  test('restores and saves the chosen theme', () async {
    final FakeThemeLocalDataSource dataSource = FakeThemeLocalDataSource(
      'dark',
    );
    final ThemeCubit cubit = cubitWith(dataSource);
    await cubit.restore();
    expect(cubit.themeMode, ThemeMode.dark);

    await cubit.setPreference(ThemePreference.light);
    expect(cubit.themeMode, ThemeMode.light);
    expect(dataSource.value, 'light');
    await cubit.close();
  });

  test('an unknown stored value falls back to Auto', () async {
    final ThemeCubit cubit = cubitWith(FakeThemeLocalDataSource('sepia'));
    await cubit.restore();
    expect(cubit.state, ThemePreference.auto);
    await cubit.close();
  });

  test('storage errors become cache failures', () async {
    final ThemeRepositoryImpl repository = ThemeRepositoryImpl(
      FakeThemeLocalDataSource()..fails = true,
    );
    expect(
      await repository.getThemePreference(),
      const Left<Failure, ThemePreference>(Failure.cacheReadFailure()),
    );
    expect(
      await repository.saveThemePreference(ThemePreference.dark),
      const Left<Failure, Unit>(Failure.cacheWriteFailure()),
    );
  });
}
