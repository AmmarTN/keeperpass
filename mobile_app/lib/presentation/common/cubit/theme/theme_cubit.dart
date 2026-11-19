import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/theme_preference.dart';
import 'package:keeperpass/core/usecases/common/get_theme_preference.dart';
import 'package:keeperpass/core/usecases/common/save_theme_preference.dart';
import 'package:keeperpass/core/usecases/usecase.dart';

/// Settings › Appearance › Theme: Auto (follows the phone), Light or Dark,
/// saved on this device only.
@lazySingleton
final class ThemeCubit extends Cubit<ThemePreference> {
  ThemeCubit(this._getThemePreference, this._saveThemePreference)
    : super(ThemePreference.auto);

  final GetThemePreference _getThemePreference;
  final SaveThemePreference _saveThemePreference;

  ThemeMode get themeMode => switch (state) {
    ThemePreference.auto => ThemeMode.system,
    ThemePreference.light => ThemeMode.light,
    ThemePreference.dark => ThemeMode.dark,
  };

  Future<void> restore() async {
    final result = await _getThemePreference(const NoParams());
    emit(result.getOrElse(() => ThemePreference.auto));
  }

  Future<void> setPreference(ThemePreference preference) async {
    emit(preference);
    await _saveThemePreference(preference);
  }
}
