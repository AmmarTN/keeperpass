import 'dart:convert';
import 'dart:math' as math;

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/infrastructure/constants/network_timeouts.dart';
import 'package:keeperpass/infrastructure/constants/vault_file_names.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';

/// The vault as `/vault.json.enc` in the app's Dropbox folder (web
/// `core/providers/dropbox/dropbox-vault.storage.ts`). Writes are guarded by
/// the file's `rev`, so a save from another device in between fails with
/// [Failure.vaultConflict] instead of overwriting it.
abstract class DropboxRemoteDataSource
    implements VaultStorageRemoteDataSource {}

@Singleton(as: DropboxRemoteDataSource)
class DropboxRemoteDataSourceImpl implements DropboxRemoteDataSource {
  DropboxRemoteDataSourceImpl(
    this._dio, {
    @ignoreParam this._now = DateTime.now,
    @ignoreParam this._wait = Future<void>.delayed,
  });

  final Dio _dio;
  final DateTime Function() _now;
  final Future<void> Function(Duration) _wait;

  static const String _apiUrl = 'https://api.dropboxapi.com/2';
  static const String _contentUrl = 'https://content.dropboxapi.com/2';

  /// In the app folder's root — the app folder is already the namespace.
  static const String vaultPath = '/${VaultFileNames.vault}';

  /// Retries after a 429, each waiting what Dropbox asked for (capped).
  static const int maxRateLimitRetries = 2;
  static const Duration maxRetryWait = Duration(seconds: 10);

  /// The revision this session last read or wrote; null when it has seen no
  /// vault.
  String? _rev;

  @override
  ProviderId get provider => ProviderId.dropbox;

  @override
  Future<Either<Failure, VaultFileInfo?>> findVault(String accessToken) =>
      guardStorage(() async {
        final Response<String> response = await _rpc(
          accessToken,
          'files/get_metadata',
          <String, Object>{'path': vaultPath},
        );
        if (response.statusCode == 409) {
          if (hasTag(tryDecodeJson(response.data), 'not_found')) {
            _rev = null;
            return null;
          }
          throw const StorageStop(
            Failure.storageError(StorageError.dropboxUnreachable),
          );
        }
        _assertOk(response, StorageError.dropboxUnreachable);
        return VaultFileInfo(modifiedAt: _serverModified(response.data));
      });

  @override
  Future<Either<Failure, String?>> loadVault(String accessToken) =>
      guardStorage(() async {
        final Response<String> response = await _withRateLimitRetry(
          () => _dio.request<String>(
            '$_contentUrl/files/download',
            options: rawOptions(
              'POST',
              headers: <String, Object>{
                'Authorization': 'Bearer $accessToken',
                'Dropbox-API-Arg': apiArg(<String, Object>{'path': vaultPath}),
              },
            ),
          ),
        );
        if (response.statusCode == 409) {
          if (hasTag(tryDecodeJson(response.data), 'not_found')) {
            _rev = null;
            return null;
          }
          throw const StorageStop(
            Failure.storageError(StorageError.dropboxReadFailed),
          );
        }
        _assertOk(response, StorageError.dropboxReadFailed);
        _rev = _revFromResultHeader(response);
        return response.data ?? '';
      });

  /// With a known revision: update exactly that one. With none: create, and
  /// fail if a file turned up meanwhile — one this session never read.
  @override
  Future<Either<Failure, Unit>> saveVault(
    String accessToken,
    String content, {
    UploadProgress? onProgress,
  }) => guardStorage(() async {
    final String? rev = _rev;
    await _uploadVault(
      accessToken,
      content,
      rev == null
          ? <String, Object>{'.tag': 'add'}
          : <String, Object>{'.tag': 'update', 'update': rev},
      onProgress,
    );
    return unit;
  });

  @override
  Future<Either<Failure, Unit>> resetVault(
    String accessToken,
    String content, {
    required DateTime backupAt,
    void Function()? onBackedUp,
    UploadProgress? onProgress,
  }) => guardStorage(() async {
    await _moveVault(
      accessToken,
      '/${VaultFileNames.backup(backupAt)}',
      StorageError.dropboxBackupFailed,
    );
    _rev = null;
    onBackedUp?.call();
    await _uploadVault(accessToken, content, <String, Object>{
      '.tag': 'add',
    }, onProgress);
    return unit;
  });

  @override
  Future<Either<Failure, String?>> detachVault(String accessToken) =>
      guardStorage(() async {
        final String? moved = await _moveVault(
          accessToken,
          '/${VaultFileNames.removed(_now())}',
          StorageError.dropboxRenameFailed,
        );
        _rev = null;
        return moved;
      });

  /// Before editing, the design checks whether the stored file is newer than
  /// the one this phone opened (board `Sync-states`, "Changed on another
  /// device"): its `rev` differs from the one last read or written.
  @override
  Future<Either<Failure, VaultFileInfo?>> newerVersion(String accessToken) =>
      guardStorage(() async {
        final Response<String> response = await _rpc(
          accessToken,
          'files/get_metadata',
          <String, Object>{'path': vaultPath},
        );
        if (response.statusCode == 409) {
          if (hasTag(tryDecodeJson(response.data), 'not_found')) return null;
          throw const StorageStop(
            Failure.storageError(StorageError.dropboxUnreachable),
          );
        }
        _assertOk(response, StorageError.dropboxUnreachable);
        final Object? json = tryDecodeJson(response.data);
        final Object? rev = json is Map<String, dynamic> ? json['rev'] : null;
        if (rev == _rev) return null;
        return VaultFileInfo(modifiedAt: _serverModified(response.data));
      });

  /// Renames the active vault out of the way; false when there was none.
  /// The file's name after the move (Dropbox may add " (1)" when the name is
  /// taken), null when there was no vault.
  Future<String?> _moveVault(
    String accessToken,
    String toPath,
    StorageError error,
  ) async {
    final Response<String> response = await _rpc(
      accessToken,
      'files/move_v2',
      <String, Object>{
        'from_path': vaultPath,
        'to_path': toPath,
        'autorename': true,
      },
    );
    if (response.statusCode == 409) {
      if (hasTag(tryDecodeJson(response.data), 'not_found')) return null;
      throw StorageStop(Failure.storageError(error));
    }
    _assertOk(response, error);
    final Object? json = tryDecodeJson(response.data);
    final Object? metadata = json is Map<String, dynamic>
        ? json['metadata']
        : null;
    final Object? name = metadata is Map<String, dynamic>
        ? metadata['name']
        : null;
    return name is String ? name : toPath.substring(1);
  }

  Future<void> _uploadVault(
    String accessToken,
    String content,
    Map<String, Object> mode,
    UploadProgress? onProgress,
  ) async {
    final Map<String, Object> headers = <String, Object>{
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/octet-stream',
      'Dropbox-API-Arg': apiArg(<String, Object>{
        'path': vaultPath,
        'mode': mode,
        'autorename': false,
        'mute': true,
      }),
    };

    onProgress?.call(0);

    final List<int> bytes = utf8.encode(content);
    Future<Response<String>> upload() => _dio.request<String>(
      '$_contentUrl/files/upload',
      data: bytes,
      options: rawOptions(
        'POST',
        headers: headers,
        sendTimeout: NetworkTimeouts.sendFor(bytes.length),
      ),
      onSendProgress: (int sent, int total) {
        if (total > 0) onProgress?.call(sent / total);
      },
    );

    Response<String> result = await upload();
    for (
      int attempt = 0;
      result.statusCode == 429 && attempt < maxRateLimitRetries;
      attempt++
    ) {
      await _wait(maxRetryWait);
      result = await upload();
    }

    final int status = result.statusCode ?? 0;
    if (status == 409) {
      if (hasTag(tryDecodeJson(result.data), 'conflict')) {
        throw const StorageStop(Failure.vaultConflict());
      }
      throw const StorageStop(
        Failure.storageError(StorageError.dropboxSaveFailed),
      );
    }
    if (status == 401) throw StorageStop(_authError(result.data));
    if (status == 429) {
      throw const StorageStop(
        Failure.storageError(StorageError.dropboxRateLimited),
      );
    }
    if (!isOk(result)) {
      throw const StorageStop(
        Failure.storageError(StorageError.dropboxSaveFailed),
      );
    }

    final Object? metadata = tryDecodeJson(result.data);
    final Object? rev = metadata is Map<String, dynamic>
        ? metadata['rev']
        : null;
    _rev = rev is String ? rev : null;
    onProgress?.call(1);
  }

  Future<Response<String>> _rpc(
    String accessToken,
    String endpoint,
    Object body,
  ) => _withRateLimitRetry(
    () => _dio.request<String>(
      '$_apiUrl/$endpoint',
      data: jsonBytes(body),
      options: rawOptions(
        'POST',
        headers: <String, Object>{
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      ),
    ),
  );

  /// Honours `Retry-After` on a 429, a bounded number of times, then hands
  /// the 429 back.
  Future<Response<String>> _withRateLimitRetry(
    Future<Response<String>> Function() send,
  ) async {
    Response<String> response = await send();
    for (
      int attempt = 0;
      response.statusCode == 429 && attempt < maxRateLimitRetries;
      attempt++
    ) {
      final int seconds =
          int.tryParse(response.headers.value('retry-after') ?? '') ?? 0;
      final Duration wanted = Duration(seconds: seconds == 0 ? 1 : seconds);
      await _wait(
        Duration(
          milliseconds: math.min(
            wanted.inMilliseconds,
            maxRetryWait.inMilliseconds,
          ),
        ),
      );
      response = await send();
    }
    return response;
  }

  void _assertOk(Response<String> response, StorageError error) {
    if (isOk(response)) return;
    if (response.statusCode == 401) {
      throw StorageStop(_authError(response.data));
    }
    if (response.statusCode == 429) {
      throw const StorageStop(
        Failure.storageError(StorageError.dropboxRateLimited),
      );
    }
    throw StorageStop(Failure.storageError(error));
  }

  /// A 401 is an expired or revoked token — except `missing_scope`, a
  /// misconfigured app, which must not look like an expiry.
  Failure _authError(Object? body) =>
      hasTag(tryDecodeJson(body), 'missing_scope')
      ? const Failure.storageError(StorageError.dropboxMissingScope)
      : const Failure.storageAuthExpired(ProviderId.dropbox);

  static DateTime? _serverModified(Object? body) {
    final Object? json = tryDecodeJson(body);
    final Object? modified = json is Map<String, dynamic>
        ? json['server_modified']
        : null;
    return modified is String ? DateTime.tryParse(modified) : null;
  }

  /// The `rev` Dropbox reports alongside a download.
  static String? _revFromResultHeader(Response<String> response) {
    final Object? json = tryDecodeJson(
      response.headers.value('dropbox-api-result'),
    );
    final Object? rev = json is Map<String, dynamic> ? json['rev'] : null;
    return rev is String ? rev : null;
  }

  /// Whether `.tag == tag` appears anywhere in a (nested) Dropbox error.
  static bool hasTag(Object? value, String tag) {
    if (value is Map) {
      return value['.tag'] == tag ||
          value.values.any((Object? inner) => hasTag(inner, tag));
    }
    if (value is List) {
      return value.any((Object? inner) => hasTag(inner, tag));
    }
    return false;
  }

  /// `Dropbox-API-Arg` is an HTTP header, so it must be ASCII: everything from
  /// U+007F up is `\uXXXX`-escaped.
  static String apiArg(Object value) => jsonEncode(value).replaceAllMapped(
    RegExp(r'[\u007f-\uffff]'),
    (Match match) =>
        '\\u${match[0]!.codeUnitAt(0).toRadixString(16).padLeft(4, '0')}',
  );
}
