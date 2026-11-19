import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/constants/vault_file_names.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';

/// Called with how much of an upload has been sent, from `0` to `1`.
typedef UploadProgress = void Function(double fraction);

/// Where the one encrypted vault file lives (web `VaultStorage`). The vault
/// is an opaque string here: encryption happens before.
///
/// Every method returns [Failure.storageAuthExpired] when the token is dead.
abstract class VaultStorageRemoteDataSource {
  ProviderId get provider;

  /// The vault file without its contents, or null when this account has
  /// none yet (web `vaultExists`, plus the file's time for Connect).
  Future<Either<Failure, VaultFileInfo?>> findVault(String accessToken);

  /// The encrypted vault's contents, or null when there is none.
  Future<Either<Failure, String?>> loadVault(String accessToken);

  /// Creates the vault on first save, overwrites it afterwards.
  Future<Either<Failure, Unit>> saveVault(
    String accessToken,
    String content, {
    UploadProgress? onProgress,
  });

  /// Keeps the current vault as a backup named for [backupAt]
  /// ([VaultFileNames.backup]) and creates a new one. [onBackedUp] runs once
  /// the old file is out of the way (or there was none), before the upload.
  Future<Either<Failure, Unit>> resetVault(
    String accessToken,
    String content, {
    required DateTime backupAt,
    void Function()? onBackedUp,
    UploadProgress? onProgress,
  });

  /// Moves the vault out of the app's way without deleting it. The result is
  /// the file's new name, null when there was none.
  Future<Either<Failure, String?>> detachVault(String accessToken);

  /// The stored file when it is newer than the one this session last read or
  /// wrote, else null. Only Dropbox tracks this; Google Drive is
  /// last-save-wins (D9) and always answers null.
  Future<Either<Failure, VaultFileInfo?>> newerVersion(String accessToken);
}

/// Ends a storage call with [failure]; turned into a `Left` at the boundary.
final class StorageStop implements Exception {
  const StorageStop(this.failure);

  final Failure failure;
}

/// Runs [body], turning a [StorageStop] or a transport error into a `Left`.
Future<Either<Failure, T>> guardStorage<T>(Future<T> Function() body) async {
  try {
    return Right<Failure, T>(await body());
  } on StorageStop catch (stop) {
    return Left<Failure, T>(stop.failure);
  } on DioException catch (error) {
    return Left<Failure, T>(
      Failure.networkFailure(NetworkFailure.getDioException(error)),
    );
  } on FormatException {
    return const Left(Failure.formatExceptionFailure());
  }
}

/// Request options that hand every status back, like `fetch`.
Options rawOptions(
  String method, {
  Map<String, Object> headers = const <String, Object>{},
  Duration? sendTimeout,
}) => Options(
  method: method,
  headers: headers,
  sendTimeout: sendTimeout,
  responseType: ResponseType.plain,
  validateStatus: (_) => true,
);

/// [value] as JSON bytes, sent as they are.
List<int> jsonBytes(Object? value) => utf8.encode(jsonEncode(value));

/// A response body parsed as JSON, or null when it is not JSON.
Object? tryDecodeJson(Object? body) {
  if (body is! String || body.isEmpty) return null;
  try {
    return jsonDecode(body);
  } on FormatException {
    return null;
  }
}

/// Whether the request succeeded (`Response.ok`).
bool isOk(Response<String> response) {
  final int status = response.statusCode ?? 0;
  return status >= 200 && status < 300;
}
