import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/infrastructure/constants/vault_file_names.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/vault_storage_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';

/// Google Drive v3 (web `core/drive/google-drive.service.ts`): one
/// `keeperpass` folder and, inside it, one active `vault.json.enc`. Saves are
/// last-save-wins (D9).
abstract class GoogleDriveRemoteDataSource
    implements VaultStorageRemoteDataSource {}

@Singleton(as: GoogleDriveRemoteDataSource)
class GoogleDriveRemoteDataSourceImpl implements GoogleDriveRemoteDataSource {
  GoogleDriveRemoteDataSourceImpl(
    this._dio, {
    @ignoreParam this._now = DateTime.now,
  });

  final Dio _dio;
  final DateTime Function() _now;

  static const String folderName = 'keeperpass';
  static const String fileName = VaultFileNames.vault;
  static const String _folderMimeType = 'application/vnd.google-apps.folder';
  static const String _filesUrl = 'https://www.googleapis.com/drive/v3/files';
  static const String _uploadUrl =
      'https://www.googleapis.com/upload/drive/v3/files';

  /// Resumable uploads go in multiples of 256 KiB (the last chunk excepted);
  /// the smallest legal size gives the smoothest progress (web `CHUNK_BYTES`).
  static const int chunkBytes = 256 * 1024;

  @override
  ProviderId get provider => ProviderId.google;

  @override
  Future<Either<Failure, VaultFileInfo?>> findVault(String accessToken) =>
      guardStorage(() async {
        final String? folderId = await _findFolder(accessToken);
        if (folderId == null) return null;
        final _DriveFile? file = await _findFile(accessToken, folderId);
        return file == null ? null : VaultFileInfo(modifiedAt: file.modifiedAt);
      });

  @override
  Future<Either<Failure, String?>> loadVault(String accessToken) =>
      guardStorage(() async {
        final String? folderId = await _findFolder(accessToken);
        if (folderId == null) return null;
        final _DriveFile? file = await _findFile(accessToken, folderId);
        if (file == null) return null;
        return _downloadFile(accessToken, file.id);
      });

  @override
  Future<Either<Failure, Unit>> saveVault(
    String accessToken,
    String content, {
    UploadProgress? onProgress,
  }) => guardStorage(() async {
    final String folderId =
        await _findFolder(accessToken) ?? await _createFolder(accessToken);
    final _DriveFile? file = await _findFile(accessToken, folderId);
    if (file != null) {
      await _updateFile(accessToken, file.id, content, onProgress);
    } else {
      await _createFile(accessToken, folderId, content, onProgress);
    }
    return unit;
  });

  /// For a forgotten secret: the old file is renamed to a timestamped backup
  /// (kept in case the secret is remembered), then a fresh vault is created.
  @override
  Future<Either<Failure, Unit>> resetVault(
    String accessToken,
    String content, {
    required DateTime backupAt,
    void Function()? onBackedUp,
    UploadProgress? onProgress,
  }) => guardStorage(() async {
    final String folderId =
        await _findFolder(accessToken) ?? await _createFolder(accessToken);
    final _DriveFile? file = await _findFile(accessToken, folderId);
    if (file != null) {
      await _renameFile(
        accessToken,
        file.id,
        VaultFileNames.backup(backupAt),
        StorageError.driveBackupFailed,
      );
    }
    onBackedUp?.call();
    await _createFile(accessToken, folderId, content, onProgress);
    return unit;
  });

  /// Renames the vault so the app stops finding it; nothing is deleted.
  @override
  Future<Either<Failure, String?>> detachVault(String accessToken) =>
      guardStorage(() async {
        final String? folderId = await _findFolder(accessToken);
        if (folderId == null) return null;
        final _DriveFile? file = await _findFile(accessToken, folderId);
        if (file == null) return null;
        final String name = VaultFileNames.removed(_now());
        await _renameFile(
          accessToken,
          file.id,
          name,
          StorageError.driveRenameFailed,
        );
        return name;
      });

  @override
  Future<Either<Failure, VaultFileInfo?>> newerVersion(
    String accessToken,
  ) async => const Right(null);

  /// 401 → expired; a 403 for a missing `drive.file` grant → not granted;
  /// anything else not OK → [error].
  void _assertOk(Response<String> response, StorageError error) {
    if (response.statusCode == 401) {
      throw const StorageStop(Failure.storageAuthExpired(ProviderId.google));
    }
    if (response.statusCode == 403 && _missingScope(response.data)) {
      throw const StorageStop(Failure.driveAccessNotGranted());
    }
    if (!isOk(response)) throw StorageStop(Failure.storageError(error));
  }

  static bool _missingScope(Object? body) =>
      body is String &&
      (body.contains('ACCESS_TOKEN_SCOPE_INSUFFICIENT') ||
          body.contains('insufficientPermissions'));

  Map<String, Object> _auth(String accessToken) => <String, Object>{
    'Authorization': 'Bearer $accessToken',
  };

  Future<void> _renameFile(
    String accessToken,
    String fileId,
    String name,
    StorageError error,
  ) async {
    final Response<String> response = await _dio.request<String>(
      '$_filesUrl/$fileId',
      data: jsonBytes(<String, Object>{'name': name}),
      options: rawOptions(
        'PATCH',
        headers: <String, Object>{
          ..._auth(accessToken),
          'Content-Type': 'application/json',
        },
      ),
    );
    _assertOk(response, error);
  }

  Future<String?> _findFolder(String accessToken) async {
    final List<_DriveFile> files = await _driveGet(
      accessToken,
      "name='$folderName' and mimeType='$_folderMimeType' and trashed=false",
    );
    return files.isEmpty ? null : files.first.id;
  }

  Future<String> _createFolder(String accessToken) async {
    final Response<String> response = await _dio.request<String>(
      _filesUrl,
      data: jsonBytes(<String, Object>{
        'name': folderName,
        'mimeType': _folderMimeType,
      }),
      options: rawOptions(
        'POST',
        headers: <String, Object>{
          ..._auth(accessToken),
          'Content-Type': 'application/json',
        },
      ),
    );
    _assertOk(response, StorageError.driveCreateFolderFailed);
    final Object? json = tryDecodeJson(response.data);
    if (json is! Map<String, dynamic> || json['id'] is! String) {
      throw const StorageStop(
        Failure.storageError(StorageError.driveCreateFolderFailed),
      );
    }
    return json['id'] as String;
  }

  Future<_DriveFile?> _findFile(String accessToken, String folderId) async {
    final List<_DriveFile> files = await _driveGet(
      accessToken,
      "name='$fileName' and '$folderId' in parents and trashed=false",
    );
    return files.isEmpty ? null : files.first;
  }

  Future<String> _downloadFile(String accessToken, String fileId) async {
    final Response<String> response = await _dio.request<String>(
      '$_filesUrl/$fileId',
      queryParameters: <String, Object>{'alt': 'media'},
      options: rawOptions('GET', headers: _auth(accessToken)),
    );
    _assertOk(response, StorageError.driveReadFailed);
    return response.data ?? '';
  }

  Future<void> _createFile(
    String accessToken,
    String folderId,
    String content,
    UploadProgress? onProgress,
  ) => _resumableUpload(
    accessToken,
    _uploadUrl,
    'POST',
    <String, Object>{
      'name': fileName,
      'mimeType': 'application/json',
      'parents': <String>[folderId],
    },
    content,
    onProgress,
  );

  Future<void> _updateFile(
    String accessToken,
    String fileId,
    String content,
    UploadProgress? onProgress,
  ) => _resumableUpload(
    accessToken,
    '$_uploadUrl/$fileId',
    'PATCH',
    <String, Object>{'mimeType': 'application/json'},
    content,
    onProgress,
  );

  /// Drive's resumable upload: the metadata request returns a session URI
  /// (`Location`), then the content goes in [chunkBytes] pieces. A `308`'s
  /// `Range` header says how much the server confirmed, and that is what
  /// [onProgress] reports; `200`/`201` means done.
  Future<void> _resumableUpload(
    String accessToken,
    String url,
    String method,
    Map<String, Object> metadata,
    String content,
    UploadProgress? onProgress,
  ) async {
    final Uint8List bytes = utf8.encode(content);
    final int total = bytes.length;

    final Response<String> initiate = await _dio.request<String>(
      url,
      queryParameters: <String, Object>{'uploadType': 'resumable'},
      data: jsonBytes(metadata),
      options: rawOptions(
        method,
        headers: <String, Object>{
          ..._auth(accessToken),
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Upload-Content-Type': 'application/json',
          'X-Upload-Content-Length': '$total',
        },
      ),
    );
    _assertOk(initiate, StorageError.driveSaveFailed);

    final String? sessionUri = initiate.headers.value('location');
    if (sessionUri == null) {
      throw const StorageStop(
        Failure.storageError(StorageError.driveSaveFailed),
      );
    }

    onProgress?.call(0);

    int start = 0;
    while (start < total) {
      final int end = math.min(start + chunkBytes, total);
      final Response<String> response = await _dio.request<String>(
        sessionUri,
        data: Uint8List.sublistView(bytes, start, end),
        options: rawOptions(
          'PUT',
          headers: <String, Object>{
            ..._auth(accessToken),
            'Content-Range': 'bytes $start-${end - 1}/$total',
          },
        ),
      );

      if (isOk(response)) {
        onProgress?.call(1);
        return;
      }
      if (response.statusCode != 308) {
        _assertOk(response, StorageError.driveSaveFailed);
      }

      // "bytes=0-262143": the upper bound is what the server has confirmed;
      // this chunk's own end if the header is missing.
      final String? range = response.headers.value('range');
      final int confirmedEnd = range == null
          ? end
          : int.parse(range.split('-')[1]) + 1;
      onProgress?.call(confirmedEnd / total);
      start = confirmedEnd;
    }
  }

  Future<List<_DriveFile>> _driveGet(String accessToken, String query) async {
    final Response<String> response = await _dio.request<String>(
      _filesUrl,
      queryParameters: <String, Object>{
        'q': query,
        'fields': 'files(id,modifiedTime)',
      },
      options: rawOptions('GET', headers: _auth(accessToken)),
    );
    _assertOk(response, StorageError.driveUnreachable);
    final Object? json = tryDecodeJson(response.data);
    final Object? files = json is Map<String, dynamic> ? json['files'] : null;
    if (files is! List<dynamic>) {
      throw const StorageStop(
        Failure.storageError(StorageError.driveUnreachable),
      );
    }
    return <_DriveFile>[
      for (final Object? file in files)
        if (file is Map<String, dynamic> && file['id'] is String)
          _DriveFile(
            file['id'] as String,
            file['modifiedTime'] is String
                ? DateTime.tryParse(file['modifiedTime'] as String)
                : null,
          ),
    ];
  }
}

class _DriveFile {
  const _DriveFile(this.id, this.modifiedAt);

  final String id;
  final DateTime? modifiedAt;
}
