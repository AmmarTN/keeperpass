import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/icons/icon_catalog.dart';
import 'package:keeperpass/infrastructure/repositories/bundled_data_repository_impl.dart';

/// The icon picker's catalogue (web `ICON_CATALOG`), loaded once.
@singleton
class GetIconCatalog implements Usecase<List<CatalogIcon>, NoParams> {
  final IBundledDataRepository _repository;

  GetIconCatalog(this._repository);

  @override
  Future<Either<Failure, List<CatalogIcon>>> call(NoParams params) =>
      _repository.iconCatalog();
}
