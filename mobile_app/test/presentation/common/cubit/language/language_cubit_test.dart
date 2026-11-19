import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/common/get_saved_locale.dart';
import 'package:keeperpass/core/usecases/common/save_locale.dart';
import 'package:keeperpass/infrastructure/repositories/locale_repository_impl.dart';
import 'package:keeperpass/presentation/common/cubit/language/language_cubit.dart';

final class FakeLocaleRepository implements ILocaleRepository {
  FakeLocaleRepository([this.saved]);

  String? saved;

  @override
  Future<Either<Failure, String?>> getSavedLocale() async => Right(saved);

  @override
  Future<Either<Failure, Unit>> saveLocale(String localeCode) async {
    saved = localeCode;
    return const Right(unit);
  }
}

LanguageCubit cubitWith(FakeLocaleRepository repository) =>
    LanguageCubit(GetSavedLocale(repository), SaveLocale(repository));

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('restores the saved language', () async {
    final LanguageCubit cubit = cubitWith(FakeLocaleRepository('pt'));
    await cubit.restore();
    expect(cubit.state, LocaleLanguage.pt);
    await cubit.close();
  });

  test('falls back to English for a language the app does not ship', () async {
    final LanguageCubit cubit = cubitWith(FakeLocaleRepository('ar'));
    await cubit.restore();
    expect(cubit.state, LocaleLanguage.en);
    await cubit.close();
  });

  test('saves a chosen language', () async {
    final FakeLocaleRepository repository = FakeLocaleRepository();
    final LanguageCubit cubit = cubitWith(repository);
    await cubit.setLanguage(LocaleLanguage.de);
    expect(cubit.state, LocaleLanguage.de);
    expect(repository.saved, 'de');
    await cubit.close();
  });
}
