import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/google_drive_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';

import '../../helpers/fake_http.dart';

/// Ported from web `core/drive/google-drive.service.ts`.
void main() {
  late FakeHttpAdapter http;
  late GoogleDriveRemoteDataSourceImpl drive;
  final DateTime now = DateTime.utc(2026, 10, 30, 21, 5, 9, 123);

  setUp(() {
    http = FakeHttpAdapter();
    drive = GoogleDriveRemoteDataSourceImpl(fakeDio(http), now: () => now);
  });

  void folder([String? id = 'F']) => http.replyJson(200, <String, Object>{
    'files': <Object>[
      if (id != null) <String, String>{'id': id},
    ],
  });

  void file([String? id = 'V', String? modified]) =>
      http.replyJson(200, <String, Object>{
        'files': <Object>[
          if (id != null) <String, String>{'id': id, 'modifiedTime': ?modified},
        ],
      });

  test('finds the vault by name inside the keeperpass folder', () async {
    folder();
    file('V', '2026-10-28T09:37:00.000Z');

    final Either<Failure, VaultFileInfo?> result = await drive.findVault('tok');

    expect(
      result,
      Right<Failure, VaultFileInfo?>(
        VaultFileInfo(modifiedAt: DateTime.utc(2026, 10, 28, 9, 37)),
      ),
    );
    expect(
      http.requests[0].uri.queryParameters['q'],
      "name='keeperpass' and mimeType='application/vnd.google-apps.folder' and trashed=false",
    );
    expect(
      http.requests[1].uri.queryParameters['q'],
      "name='vault.json.enc' and 'F' in parents and trashed=false",
    );
    expect(http.requests[0].header('authorization'), 'Bearer tok');
  });

  test('no folder or no file means no vault', () async {
    folder(null);
    expect(
      await drive.findVault('tok'),
      const Right<Failure, VaultFileInfo?>(null),
    );
    folder();
    file(null);
    expect(await drive.loadVault('tok'), const Right<Failure, String?>(null));
  });

  test('downloads the file contents as they are', () async {
    folder();
    file();
    // Drive serves the file with the type it was saved with.
    http.replyText(200, '{"salt":"…"}', <String, List<String>>{
      Headers.contentTypeHeader: <String>[Headers.jsonContentType],
    });

    expect(
      await drive.loadVault('tok'),
      const Right<Failure, String?>('{"salt":"…"}'),
    );
    expect(http.requests[2].uri.path, '/drive/v3/files/V');
    expect(http.requests[2].uri.queryParameters['alt'], 'media');
  });

  test('first save creates the folder and uploads in 256 KiB chunks, '
      'reporting what the server confirmed', () async {
    final String content = 'x' * (600 * 1024);
    const int chunk = 256 * 1024;
    folder(null);
    http.replyJson(200, <String, String>{'id': 'F'});
    file(null);
    http.replyText(200, '', <String, List<String>>{
      'location': <String>['https://upload.example/session'],
    });
    http.replyText(308, '', <String, List<String>>{
      'range': <String>['bytes=0-${chunk - 1}'],
    });
    // The server kept less than was sent: the next chunk restarts there.
    http.replyText(308, '', <String, List<String>>{
      'range': <String>['bytes=0-${chunk + 99}'],
    });
    http.replyText(308, '', <String, List<String>>{
      'range': <String>['bytes=0-${2 * chunk + 99}'],
    });
    http.replyText(200, '{}');
    final List<double> progress = <double>[];

    final Either<Failure, Unit> result = await drive.saveVault(
      'tok',
      content,
      onProgress: progress.add,
    );

    expect(result, const Right<Failure, Unit>(unit));
    expect(http.requests[1].method, 'POST');
    expect(http.requests[1].json, <String, String>{
      'name': 'keeperpass',
      'mimeType': 'application/vnd.google-apps.folder',
    });
    final RecordedRequest initiate = http.requests[3];
    expect(initiate.method, 'POST');
    expect(initiate.uri.path, '/upload/drive/v3/files');
    expect(initiate.uri.queryParameters['uploadType'], 'resumable');
    expect(initiate.json, <String, Object>{
      'name': 'vault.json.enc',
      'mimeType': 'application/json',
      'parents': <String>['F'],
    });
    expect(initiate.header('x-upload-content-length'), '${content.length}');
    expect(
      http.requests
          .skip(4)
          .map((RecordedRequest r) => r.header('content-range')),
      <String>[
        'bytes 0-${chunk - 1}/${content.length}',
        'bytes $chunk-${2 * chunk - 1}/${content.length}',
        'bytes ${chunk + 100}-${2 * chunk + 99}/${content.length}',
        'bytes ${2 * chunk + 100}-${content.length - 1}/${content.length}',
      ],
    );
    expect(progress, <double>[
      0,
      chunk / content.length,
      (chunk + 100) / content.length,
      (2 * chunk + 100) / content.length,
      1,
    ]);
    expect(http.done, isTrue);
  });

  test('later saves update the same file', () async {
    folder();
    file();
    http.replyText(200, '', <String, List<String>>{
      'location': <String>['https://upload.example/session'],
    });
    http.replyText(200, '{}');

    await drive.saveVault('tok', 'vault');

    expect(http.requests[2].method, 'PATCH');
    expect(http.requests[2].uri.path, '/upload/drive/v3/files/V');
    expect(http.requests[2].json, <String, String>{
      'mimeType': 'application/json',
    });
    expect(http.done, isTrue);
  });

  test('reset keeps the old file as a dated backup', () async {
    folder();
    file();
    http.replyJson(200, <String, String>{'id': 'V'});
    http.replyText(200, '', <String, List<String>>{
      'location': <String>['https://upload.example/session'],
    });
    http.replyText(200, '{}');

    bool backedUp = false;
    expect(
      await drive.resetVault(
        'tok',
        'new',
        backupAt: DateTime.utc(2026, 10, 29, 14, 32),
        onBackedUp: () => backedUp = true,
      ),
      const Right<Failure, Unit>(unit),
    );
    expect(backedUp, isTrue);
    expect(http.requests[2].method, 'PATCH');
    expect(http.requests[2].json, <String, String>{
      'name': 'vault.backup-2026-10-29T14-32-00.json.enc',
    });
    expect(http.requests[3].method, 'POST');
  });

  test('archive renames the file and gives its new name', () async {
    folder();
    file();
    http.replyJson(200, <String, String>{'id': 'V'});

    expect(
      await drive.detachVault('tok'),
      const Right<Failure, String?>(
        'vault.removed-2026-10-30T21-05-09.json.enc',
      ),
    );
    expect(http.requests[2].json, <String, String>{
      'name': 'vault.removed-2026-10-30T21-05-09.json.enc',
    });

    folder(null);
    expect(await drive.detachVault('tok'), const Right<Failure, String?>(null));
  });

  test('Drive is last-save-wins: never a newer version (D9)', () async {
    expect(
      await drive.newerVersion('tok'),
      const Right<Failure, VaultFileInfo?>(null),
    );
    expect(http.requests, isEmpty);
  });

  test('a refused token, a missing drive.file grant, other errors', () async {
    http.replyText(401);
    expect(
      await drive.findVault('tok'),
      const Left<Failure, VaultFileInfo?>(
        Failure.storageAuthExpired(ProviderId.google),
      ),
    );

    http.replyText(
      403,
      '{"error":{"details":[{"reason":"ACCESS_TOKEN_SCOPE_INSUFFICIENT"}]}}',
    );
    expect(
      await drive.findVault('tok'),
      const Left<Failure, VaultFileInfo?>(Failure.driveAccessNotGranted()),
    );

    folder();
    file();
    http.replyText(500);
    expect(
      await drive.loadVault('tok'),
      const Left<Failure, String?>(
        Failure.storageError(StorageError.driveReadFailed),
      ),
    );

    http.replyOffline();
    expect(
      await drive.findVault('tok'),
      const Left<Failure, VaultFileInfo?>(
        Failure.networkFailure(NetworkFailure.noInternetConnection()),
      ),
    );
  });
}
