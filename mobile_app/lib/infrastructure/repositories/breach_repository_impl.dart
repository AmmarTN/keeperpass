import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/utils/audit/audit.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/breach_remote_data_source.dart';

/// Whether a password appears in a known breach, by its SHA-1 hash.
abstract class IBreachRepository {
  Future<Either<Failure, bool>> isCompromised(String hash);
}

@Singleton(as: IBreachRepository)
class BreachRepositoryImpl implements IBreachRepository {
  final BreachRemoteDataSource _remoteDataSource;

  BreachRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, bool>> isCompromised(String hash) async =>
      (await _remoteDataSource.range(
        hash.substring(0, 5),
      )).map((String body) => rangeContains(body, hash));
}
