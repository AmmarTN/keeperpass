import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/recent_items_repository_impl.dart';

/// Recently Used ids, most recent first.
@singleton
class GetRecentItems implements UnawaitedUsecase<List<String>, NoParams> {
  final IRecentItemsRepository _repository;

  GetRecentItems(this._repository);

  @override
  Either<Failure, List<String>> call(NoParams params) => Right(_repository.ids);
}
