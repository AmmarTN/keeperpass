import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/infrastructure/datasources/remote_datasources/dropbox_remote_data_source.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';

import '../../helpers/fake_http.dart';

/// Ported from web `core/providers/dropbox/dropbox-vault.storage.ts`.
void main() {
  late FakeHttpAdapter http;
  late DropboxRemoteDataSourceImpl dropbox;
  late List<Duration> waits;
  final DateTime now = DateTime.utc(2026, 10, 30, 21, 5, 9, 123);

  setUp(() {
    http = FakeHttpAdapter();
    waits = <Duration>[];
    dropbox = DropboxRemoteDataSourceImpl(
      fakeDio(http),
      now: () => now,
      wait: (Duration d) async => waits.add(d),
    );
  });

  Map<String, Object?> apiArg(RecordedRequest request) =>
      jsonDecode(request.header('dropbox-api-arg')!) as Map<String, Object?>;

  const Map<String, Object> notFound = <String, Object>{
    'error': <String, Object>{
      '.tag': 'path',
      'path': <String, String>{'.tag': 'not_found'},
    },
  };

  test('finds the vault and its time; not_found means none', () async {
    http.replyJson(200, <String, String>{
      'rev': 'r1',
      'server_modified': '2026-10-28T09:37:00Z',
    });
    expect(
      await dropbox.findVault('tok'),
      Right<Failure, VaultFileInfo?>(
        VaultFileInfo(modifiedAt: DateTime.utc(2026, 10, 28, 9, 37)),
      ),
    );
    expect(http.requests.single.uri.path, '/2/files/get_metadata');
    expect(http.requests.single.json, <String, String>{
      'path': '/vault.json.enc',
    });

    http.replyJson(409, notFound);
    expect(
      await dropbox.findVault('tok'),
      const Right<Failure, VaultFileInfo?>(null),
    );

    http.replyJson(409, <String, Object>{
      'error': <String, String>{'.tag': 'other'},
    });
    expect(
      await dropbox.findVault('tok'),
      const Left<Failure, VaultFileInfo?>(
        Failure.storageError(StorageError.dropboxUnreachable),
      ),
    );
  });

  test(
    'a save updates exactly the revision last read, then the new one',
    () async {
      http.replyText(200, 'stored', <String, List<String>>{
        'dropbox-api-result': <String>['{"rev":"r1"}'],
      });
      http.replyJson(200, <String, String>{'rev': 'r2'});
      http.replyJson(200, <String, String>{'rev': 'r3'});

      expect(
        await dropbox.loadVault('tok'),
        const Right<Failure, String?>('stored'),
      );
      await dropbox.saveVault('tok', 'one');
      await dropbox.saveVault('tok', 'two');

      expect(apiArg(http.requests[0]), <String, String>{
        'path': '/vault.json.enc',
      });
      expect(apiArg(http.requests[1]), <String, Object>{
        'path': '/vault.json.enc',
        'mode': <String, String>{'.tag': 'update', 'update': 'r1'},
        'autorename': false,
        'mute': true,
      });
      expect(
        (apiArg(http.requests[2])['mode']! as Map<String, Object?>)['update'],
        'r2',
      );
      expect(http.requests[1].text, 'one');
      expect(
        http.requests[1].header('content-type'),
        'application/octet-stream',
      );
    },
  );

  test('with no known revision a save only creates', () async {
    http.replyJson(200, <String, String>{'rev': 'r1'});
    await dropbox.saveVault('tok', 'first');
    expect(apiArg(http.requests.single)['mode'], <String, String>{
      '.tag': 'add',
    });
  });

  test('a file changed elsewhere is a conflict, never overwritten', () async {
    http.replyJson(409, <String, Object>{
      'error': <String, Object>{
        '.tag': 'path',
        'reason': <String, Object>{
          '.tag': 'conflict',
          'conflict': <String, String>{'.tag': 'file'},
        },
      },
    });
    expect(
      await dropbox.saveVault('tok', 'x'),
      const Left<Failure, Unit>(Failure.vaultConflict()),
    );
  });

  test('uploads retry a 429 twice after 10 s, then give up', () async {
    http.replyText(429);
    http.replyJson(200, <String, String>{'rev': 'r1'});
    expect(
      await dropbox.saveVault('tok', 'x'),
      const Right<Failure, Unit>(unit),
    );
    expect(waits, <Duration>[const Duration(seconds: 10)]);

    waits.clear();
    http
      ..replyText(429)
      ..replyText(429)
      ..replyText(429);
    expect(
      await dropbox.saveVault('tok', 'x'),
      const Left<Failure, Unit>(
        Failure.storageError(StorageError.dropboxRateLimited),
      ),
    );
    expect(waits, hasLength(2));
  });

  test('calls honour Retry-After, capped at 10 s', () async {
    http
      ..replyText(429, '', <String, List<String>>{
        'retry-after': <String>['3'],
      })
      ..replyText(429, '', <String, List<String>>{
        'retry-after': <String>['30'],
      })
      ..replyJson(409, notFound);
    await dropbox.findVault('tok');
    expect(waits, <Duration>[
      const Duration(seconds: 3),
      const Duration(seconds: 10),
    ]);
  });

  test('a 401 is an expiry, except a missing scope', () async {
    http.replyJson(401, <String, Object>{
      'error': <String, String>{'.tag': 'expired_access_token'},
    });
    expect(
      await dropbox.loadVault('tok'),
      const Left<Failure, String?>(
        Failure.storageAuthExpired(ProviderId.dropbox),
      ),
    );

    http.replyJson(401, <String, Object>{
      'error': <String, String>{'.tag': 'missing_scope'},
    });
    expect(
      await dropbox.saveVault('tok', 'x'),
      const Left<Failure, Unit>(
        Failure.storageError(StorageError.dropboxMissingScope),
      ),
    );
  });

  test('reset moves the old file to a backup, then creates', () async {
    http.replyJson(200, <String, Object>{});
    http.replyJson(200, <String, String>{'rev': 'r9'});

    expect(
      await dropbox.resetVault(
        'tok',
        'new',
        backupAt: DateTime.utc(2026, 10, 29, 14, 32),
      ),
      const Right<Failure, Unit>(unit),
    );
    expect(http.requests[0].uri.path, '/2/files/move_v2');
    expect(http.requests[0].json, <String, Object>{
      'from_path': '/vault.json.enc',
      'to_path': '/vault.backup-2026-10-29T14-32-00.json.enc',
      'autorename': true,
    });
    expect(apiArg(http.requests[1])['mode'], <String, String>{'.tag': 'add'});
  });

  test('archive moves the file away; none to move is not an error', () async {
    http.replyJson(200, <String, Object>{});
    expect(
      await dropbox.detachVault('tok'),
      const Right<Failure, String?>(
        'vault.removed-2026-10-30T21-05-09.json.enc',
      ),
    );
    expect(
      (http.requests.single.json! as Map<String, Object?>)['to_path'],
      '/vault.removed-2026-10-30T21-05-09.json.enc',
    );

    // A taken name: Dropbox renames it, and says so.
    http.replyJson(200, <String, Object>{
      'metadata': <String, String>{
        '.tag': 'file',
        'name': 'vault.removed-2026-10-30T21-05-09 (1).json.enc',
      },
    });
    expect(
      await dropbox.detachVault('tok'),
      const Right<Failure, String?>(
        'vault.removed-2026-10-30T21-05-09 (1).json.enc',
      ),
    );

    http.replyJson(409, <String, Object>{
      'error': <String, Object>{
        '.tag': 'from_lookup',
        'from_lookup': <String, String>{'.tag': 'not_found'},
      },
    });
    expect(
      await dropbox.detachVault('tok'),
      const Right<Failure, String?>(null),
    );
  });

  test('a newer version is a different revision than the one read', () async {
    http.replyText(200, 'stored', <String, List<String>>{
      'dropbox-api-result': <String>['{"rev":"r1"}'],
    });
    await dropbox.loadVault('tok');

    http.replyJson(200, <String, String>{
      'rev': 'r1',
      'server_modified': '2026-10-30T09:00:00Z',
    });
    expect(
      await dropbox.newerVersion('tok'),
      const Right<Failure, VaultFileInfo?>(null),
    );

    http.replyJson(200, <String, String>{
      'rev': 'r2',
      'server_modified': '2026-10-30T09:37:00Z',
    });
    expect(
      await dropbox.newerVersion('tok'),
      Right<Failure, VaultFileInfo?>(
        VaultFileInfo(modifiedAt: DateTime.utc(2026, 10, 30, 9, 37)),
      ),
    );
  });

  test('upload progress ends at 1', () async {
    http.replyJson(200, <String, String>{'rev': 'r1'});
    final List<double> progress = <double>[];
    await dropbox.saveVault('tok', 'x' * 5000, onProgress: progress.add);
    expect(progress.first, 0);
    expect(progress.last, 1);
  });

  test('the upload may take 30 s plus a second per 8 KB (audit, '
      '2026-11-04)', () async {
    http.replyJson(200, <String, String>{'rev': 'r1'});
    await dropbox.saveVault('tok', 'x' * 80000);
    expect(
      http.requests.single.sendTimeout,
      const Duration(seconds: 30, milliseconds: 10000),
    );
  });

  test('Dropbox-API-Arg escapes everything from U+007F, like the web', () {
    expect(
      DropboxRemoteDataSourceImpl.apiArg(<String, String>{
        'path': '/\u00e9\u{1F600}\u007f',
      }),
      r'{"path":"/\u00e9\ud83d\ude00\u007f"}',
    );
  });
}
