import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/theme_preference.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/theme_repository_impl.dart';

@singleton
class GetThemePreference implements Usecase<ThemePreference, NoParams> {
  final IThemeRepository _repository;

  GetThemePreference(this._repository);

  @override
  Future<Either<Failure, ThemePreference>> call(NoParams params) {
    return _repository.getThemePreference();
  }
}
