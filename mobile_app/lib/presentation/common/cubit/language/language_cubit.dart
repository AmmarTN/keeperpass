import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/usecases/common/get_saved_locale.dart';
import 'package:keeperpass/core/usecases/common/save_locale.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/i18n/strings.g.dart';

/// The web app's five languages (`web/src/app/core/i18n/locales.ts`).
enum LocaleLanguage { en, de, es, fr, pt }

@lazySingleton
final class LanguageCubit extends Cubit<LocaleLanguage> {
  LanguageCubit(this._getSavedLocale, this._saveLocale)
    : super(LocaleLanguage.en);

  final GetSavedLocale _getSavedLocale;
  final SaveLocale _saveLocale;

  /// The saved language, else the phone's language when it is one of the
  /// five, else English.
  Future<void> restore() async {
    final result = await _getSavedLocale(const NoParams());
    final String? storedCode = result.getOrElse(() => null);
    final String deviceCode = PlatformDispatcher.instance.locale.languageCode;
    final LocaleLanguage locale = _parse(storedCode ?? deviceCode);

    await LocaleSettings.setLocaleRaw(locale.name);
    emit(locale);
  }

  Future<void> setLanguage(LocaleLanguage language) async {
    await LocaleSettings.setLocaleRaw(language.name);
    await _saveLocale(language.name);
    emit(language);
  }

  LocaleLanguage _parse(String value) {
    return LocaleLanguage.values.firstWhere(
      (LocaleLanguage language) => language.name == value,
      orElse: () => LocaleLanguage.en,
    );
  }
}
