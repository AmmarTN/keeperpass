import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/theme_preference.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/theme_repository_impl.dart';

@singleton
class SaveThemePreference implements Usecase<Unit, ThemePreference> {
  final IThemeRepository _repository;

  SaveThemePreference(this._repository);

  @override
  Future<Either<Failure, Unit>> call(ThemePreference params) {
    return _repository.saveThemePreference(params);
  }
}
