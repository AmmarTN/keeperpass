import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';

/// Have I Been Pwned's k-anonymous password range (web
/// `isPasswordCompromised`): only the first five hex characters of a
/// password's SHA-1 leave the phone; the answer lists every breached hash
/// with that prefix, matched here.
abstract class BreachRemoteDataSource {
  /// The range body for [prefix]; a response that is not OK is a failure.
  Future<Either<Failure, String>> range(String prefix);
}

@Singleton(as: BreachRemoteDataSource)
class BreachRemoteDataSourceImpl implements BreachRemoteDataSource {
  BreachRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  static const String rangeUrl = 'https://api.pwnedpasswords.com/range/';

  @override
  Future<Either<Failure, String>> range(String prefix) async {
    try {
      final Response<String> response = await _dio.request<String>(
        '$rangeUrl$prefix',
        options: rawOptions('GET'),
      );
      final Object? body = response.data;
      if (!isOk(response) || body is! String) {
        return Left(
          Failure.networkFailure(
            NetworkFailure.defaultError(
              'Breach lookup failed with status ${response.statusCode}',
            ),
          ),
        );
      }
      return Right(body);
    } on DioException catch (error) {
      return Left(
        Failure.networkFailure(NetworkFailure.getDioException(error)),
      );
    }
  }
}
