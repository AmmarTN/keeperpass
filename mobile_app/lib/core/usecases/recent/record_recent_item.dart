import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/infrastructure/repositories/recent_items_repository_impl.dart';

/// An item was opened or copied from (board `U3-Vault-empty` 08: "Items you
/// open or copy from show up here").
@singleton
class RecordRecentItem implements Usecase<Unit, String> {
  final IRecentItemsRepository _repository;

  RecordRecentItem(this._repository);

  @override
  Future<Either<Failure, Unit>> call(String itemId) =>
      _repository.record(itemId);
}
