import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/utils/text/relative_time.dart';
import 'package:keeperpass/infrastructure/repositories/bundled_data_repository_impl.dart';

/// "updated 2 days ago" (web `formatRelativeToNow`).
@singleton
class GetRelativeTimeFormatter
    implements Usecase<RelativeTimeFormatter, NoParams> {
  final IBundledDataRepository _repository;

  GetRelativeTimeFormatter(this._repository);

  @override
  Future<Either<Failure, RelativeTimeFormatter>> call(NoParams params) =>
      _repository.relativeTime();
}
