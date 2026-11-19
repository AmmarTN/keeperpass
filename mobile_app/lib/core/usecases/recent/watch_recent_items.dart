import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/recent_items_repository_impl.dart';

/// Recently Used as it changes.
@singleton
class WatchRecentItems implements UsecaseStream<List<String>, NoParams> {
  final IRecentItemsRepository _repository;

  WatchRecentItems(this._repository);

  @override
  Stream<Either<Failure, List<String>>> call(NoParams params) => _repository
      .changes
      .map((List<String> ids) => Right<Failure, List<String>>(ids));
}
