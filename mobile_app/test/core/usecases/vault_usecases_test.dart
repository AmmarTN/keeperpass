import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/dtos/change_secret_dto.dart';
import 'package:keeperpass/core/dtos/move_vault_dto.dart';
import 'package:keeperpass/core/dtos/new_vault_dto.dart';
import 'package:keeperpass/core/dtos/save_vault_dto.dart';
import 'package:keeperpass/core/dtos/vault_secret_dto.dart';
import 'package:keeperpass/core/enums/migration_stage.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/core/usecases/auth/sign_out.dart';
import 'package:keeperpass/core/usecases/usecase.dart';
import 'package:keeperpass/core/usecases/vault/archive_vault.dart';
import 'package:keeperpass/core/usecases/vault/change_secret.dart';
import 'package:keeperpass/core/usecases/vault/check_newer_version.dart';
import 'package:keeperpass/core/usecases/vault/check_vault.dart';
import 'package:keeperpass/core/usecases/vault/connect_migration_target.dart';
import 'package:keeperpass/core/usecases/vault/create_vault.dart';
import 'package:keeperpass/core/usecases/vault/encrypt_new_vault.dart';
import 'package:keeperpass/core/usecases/vault/get_migration_targets.dart';
import 'package:keeperpass/core/usecases/vault/lock_vault.dart';
import 'package:keeperpass/core/usecases/vault/move_vault.dart';
import 'package:keeperpass/core/usecases/vault/reload_vault.dart';
import 'package:keeperpass/core/usecases/vault/reset_vault.dart';
import 'package:keeperpass/core/usecases/vault/save_vault.dart';
import 'package:keeperpass/core/usecases/vault/unlock_vault.dart';
import 'package:keeperpass/infrastructure/models/vault/prepared_vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:keeperpass/infrastructure/services/vault_session_service.dart';

import '../../helpers/fake_vault_layer.dart';

void main() {
  late FakeAuthRepository auth;
  late FakeStorageRepository storage;
  late FakeVaultCipher cipher;
  late VaultSessionService vault;
  final DateTime now = DateTime.utc(2026, 10, 30, 12);
  const VaultSecretDto secret = VaultSecretDto(
    secret: 'correct horse',
    vaultName: 'My Vault',
  );

  setUp(() {
    auth = FakeAuthRepository();
    storage = FakeStorageRepository();
    cipher = FakeVaultCipher();
    vault = VaultSessionService();
  });

  Future<String> stored(String secret, VaultSnapshot snapshot) =>
      cipher.encrypt(secret, snapshot.toVaultJson());

  VaultSnapshot named(String name) =>
      VaultSnapshot.empty(vaultName: name, now: now);

  group('unlock (web UnlockPage.submit)', () {
    late UnlockVault unlock;

    setUp(
      () => unlock = UnlockVault(auth, storage, cipher, vault, now: () => now),
    );

    test('opens the stored vault into memory', () async {
      storage.files[ProviderId.google] = await stored(
        secret.secret,
        named('Work'),
      );

      final Either<Failure, VaultSnapshot> result = await unlock(secret);

      expect(
        result.getOrElse(() => throw StateError('')).vaults.single.name,
        'Work',
      );
      expect(vault.isOpen, isTrue);
      expect(vault.secret, secret.secret);
      expect(vault.loadedAt, now);
    });

    test('a wrong secret leaves the vault closed', () async {
      storage.files[ProviderId.google] = await stored('other', named('Work'));
      expect(
        await unlock(secret),
        const Left<Failure, VaultSnapshot>(Failure.wrongSecret()),
      );
      expect(vault.isOpen, isFalse);
    });

    test(
      'a file gone missing is created with this secret, as the web',
      () async {
        final Either<Failure, VaultSnapshot> result = await unlock(secret);

        expect(
          result.getOrElse(() => throw StateError('')).vaults.single.name,
          'My Vault',
        );
        expect(storage.calls, <String>['load:google', 'save:google']);
        expect(
          (await cipher.decrypt(
            secret.secret,
            storage.files[ProviderId.google]!,
          )).isRight(),
          isTrue,
        );
      },
    );

    test('an expired session is reported, nothing opened', () async {
      auth.tokenFailure = const Failure.storageAuthExpired(ProviderId.google);
      expect(
        await unlock(secret),
        const Left<Failure, VaultSnapshot>(
          Failure.storageAuthExpired(ProviderId.google),
        ),
      );
      expect(vault.isOpen, isFalse);
    });
  });

  test('check: the file and its time, without downloading it', () async {
    expect(
      await CheckVault(auth, storage)(const NoParams()),
      const Right<Failure, VaultFileInfo?>(null),
    );
    storage.files[ProviderId.google] = 'x';
    expect(
      await CheckVault(auth, storage)(const NoParams()),
      Right<Failure, VaultFileInfo?>(
        VaultFileInfo(modifiedAt: DateTime.utc(2026, 10, 28)),
      ),
    );
    expect(storage.calls, <String>['find:google', 'find:google']);
  });

  test(
    'create: encrypted once, then saved; recover keeps a dated backup',
    () async {
      final PreparedVault prepared = (await EncryptNewVault(
        cipher,
        now: () => now,
      )(secret)).getOrElse(() => throw StateError(''));
      expect(storage.calls, isEmpty);
      expect(prepared.snapshot.vaults.single.name, 'My Vault');
      expect(
        (await cipher.decrypt(secret.secret, prepared.encrypted)).isRight(),
        isTrue,
      );

      final List<double> progress = <double>[];
      await CreateVault(auth, storage, vault, now: () => now)(
        NewVaultDto(vault: prepared, onProgress: progress.add),
      );
      expect(storage.calls.last, 'save:google');
      expect(storage.files[ProviderId.google], prepared.encrypted);
      expect(progress, <double>[0, 1]);
      expect(vault.snapshot!.items, isEmpty);

      vault.wipe();
      final List<String> events = <String>[];
      final DateTime backupAt = DateTime.utc(2026, 10, 29, 14, 32);
      await ResetVault(auth, storage, vault, now: () => now)(
        NewVaultDto(
          vault: prepared,
          backupAt: backupAt,
          onBackedUp: () => events.add('backed up'),
          onProgress: (double f) => events.add('upload $f'),
        ),
      );
      expect(storage.calls.last, 'reset:google');
      expect(storage.backups, <DateTime>[backupAt]);
      expect(events, <String>['backed up', 'upload 0.0', 'upload 1.0']);
      expect(vault.isOpen, isTrue);
    },
  );

  group('save (web VaultSyncService.save)', () {
    test(
      'encrypts what is in memory, reports progress, marks it written',
      () async {
        vault.open(named('Work'), 'pw', DateTime.utc(2026));
        final List<double> progress = <double>[];
        bool? savingDuringUpload;
        storage.progress = <double>[0, 0.5, 1];

        final Either<Failure, Unit> result =
            await SaveVault(auth, storage, cipher, vault, now: () => now)(
              SaveVaultDto(
                onProgress: (double f) {
                  savingDuringUpload ??= vault.saving;
                  progress.add(f);
                },
              ),
            );

        expect(result, const Right<Failure, Unit>(unit));
        expect(progress, <double>[0, 0.5, 1]);
        expect(savingDuringUpload, isTrue);
        expect(vault.saving, isFalse);
        expect(vault.loadedAt, now);
        expect(
          (await cipher.decrypt(
            'pw',
            storage.files[ProviderId.google]!,
          )).getOrElse(() => null),
          named('Work').toVaultJson(),
        );
      },
    );

    test('nothing to save while locked', () async {
      expect(
        await SaveVault(auth, storage, cipher, vault)(const SaveVaultDto()),
        const Left<Failure, Unit>(Failure.vaultLocked()),
      );
    });
  });

  test('load the latest replaces what this phone holds', () async {
    vault.open(named('Old'), 'pw', DateTime.utc(2026));
    storage.files[ProviderId.google] = await stored('pw', named('New'));

    await ReloadVault(auth, storage, cipher, vault, now: () => now)(
      const NoParams(),
    );

    expect(vault.snapshot!.vaults.single.name, 'New');
    expect(vault.loadedAt, now);
  });

  test('newer version: passed through from storage', () async {
    final VaultFileInfo newer = VaultFileInfo(
      modifiedAt: DateTime.utc(2026, 10, 30, 9, 37),
    );
    storage.newer[ProviderId.google] = newer;
    expect(
      await CheckNewerVersion(auth, storage)(const NoParams()),
      Right<Failure, VaultFileInfo?>(newer),
    );
  });

  group('change secret (web MasterPasswordService.change)', () {
    late ChangeSecret change;

    setUp(() {
      change = ChangeSecret(auth, storage, cipher, vault, now: () => now);
      vault.open(named('Work'), 'old', DateTime.utc(2026));
    });

    test(
      'proves the current secret on the stored file, then re-encrypts it',
      () async {
        storage.files[ProviderId.google] = await stored('old', named('Stored'));

        final Either<Failure, Unit> result = await change(
          const ChangeSecretDto(currentSecret: 'old', newSecret: 'new'),
        );

        expect(result, const Right<Failure, Unit>(unit));
        expect(vault.secret, 'new');
        // The stored data, not the copy in memory (as the web).
        expect(
          (await cipher.decrypt(
            'new',
            storage.files[ProviderId.google]!,
          )).getOrElse(() => null),
          named('Stored').toVaultJson(),
        );
      },
    );

    test('a wrong current secret changes nothing', () async {
      storage.files[ProviderId.google] = await stored('old', named('Stored'));
      expect(
        await change(
          const ChangeSecretDto(currentSecret: 'guess', newSecret: 'new'),
        ),
        const Left<Failure, Unit>(Failure.wrongSecret()),
      );
      expect(vault.secret, 'old');
      expect(storage.calls, <String>['load:google']);
    });

    test('no stored vault', () async {
      expect(
        await change(
          const ChangeSecretDto(currentSecret: 'old', newSecret: 'new'),
        ),
        const Left<Failure, Unit>(Failure.vaultNotFound()),
      );
    });
  });

  group('archive (web deleteAccount)', () {
    test('renames the file, then signs out', () async {
      storage.files[ProviderId.google] = 'x';
      vault.open(named('Work'), 'pw', now);

      expect(
        await ArchiveVault(auth, storage, vault)(const NoParams()),
        const Right<Failure, String?>(
          'vault.removed-2026-10-29T14-32-00.json.enc',
        ),
      );
      expect(auth.signOuts, 1);
      expect(vault.isOpen, isFalse);
    });

    test('a failed rename signs nothing out', () async {
      storage.failures['detach:google'] = const Failure.storageError(
        StorageError.driveRenameFailed,
      );
      await ArchiveVault(auth, storage, vault)(const NoParams());
      expect(auth.signOuts, 0);
    });
  });

  test('lock and sign out wipe the vault from memory', () async {
    vault.open(named('Work'), 'pw', now);
    LockVault(vault)(const NoParams());
    expect(vault.isOpen, isFalse);
    expect(vault.secret, isNull);

    vault.open(named('Work'), 'pw', now);
    await SignOut(auth, vault)(const NoParams());
    expect(vault.isOpen, isFalse);
    expect(auth.signOuts, 1);
  });

  group('move to the other provider (web VaultMigrationService)', () {
    late MoveVault move;
    final List<MigrationStage> stages = <MigrationStage>[];

    MoveVaultDto dto({bool hasVault = false, bool replace = false}) =>
        MoveVaultDto(
          targetProvider: ProviderId.dropbox,
          target: MigrationTarget(
            accessToken: 'target-token',
            email: 'jane@dropbox.example',
            hasVault: hasVault,
          ),
          secret: 'pw',
          replaceExisting: replace,
          onStage: stages.add,
        );

    setUp(() {
      stages.clear();
      move = MoveVault(auth, storage, cipher, vault);
      vault.open(named('Work'), 'pw', now);
      storage.files[ProviderId.google] = 'source';
    });

    test('targets: configured providers other than the current one', () {
      expect(
        GetMigrationTargets(auth)(
          const NoParams(),
        ).getOrElse(() => <ProviderId>[]),
        <ProviderId>[ProviderId.dropbox],
      );
    });

    test(
      'connect refuses the same provider and reports an existing vault',
      () async {
        final ConnectMigrationTarget connect = ConnectMigrationTarget(
          auth,
          storage,
          LockService(),
        );
        expect(
          await connect(ProviderId.google),
          const Left<Failure, MigrationTarget>(
            Failure.migration(MigrationError.sameProvider),
          ),
        );
        storage.files[ProviderId.dropbox] = 'theirs';
        expect(
          await connect(ProviderId.dropbox),
          const Right<Failure, MigrationTarget>(
            MigrationTarget(
              accessToken: 'target-token',
              email: 'jane@dropbox.example',
              hasVault: true,
            ),
          ),
        );
      },
    );

    test('writes, verifies, then renames the source', () async {
      expect(
        await move(dto()),
        const Right<Failure, String?>(
          'vault.removed-2026-10-29T14-32-00.json.enc',
        ),
      );
      expect(stages, MigrationStage.values);
      expect(storage.calls, <String>[
        'save:dropbox',
        'load:dropbox',
        'detach:google',
      ]);
      expect(storage.files[ProviderId.google], isNull);
      expect(
        (await cipher.decrypt(
          'pw',
          storage.files[ProviderId.dropbox]!,
        )).getOrElse(() => null),
        named('Work').toVaultJson(),
      );
    });

    test(
      'an existing destination vault needs consent, then is reset',
      () async {
        expect(
          await move(dto(hasVault: true)),
          const Left<Failure, String?>(
            Failure.migration(MigrationError.targetHasVault),
          ),
        );
        expect(
          await move(dto(hasVault: true, replace: true)),
          const Right<Failure, String?>(
            'vault.removed-2026-10-29T14-32-00.json.enc',
          ),
        );
        expect(storage.calls.first, 'reset:dropbox');
      },
    );

    test('a copy that does not match leaves the source untouched', () async {
      storage.tamperOnLoad = (String? text) {
        final Map<String, dynamic> json =
            jsonDecode(text!) as Map<String, dynamic>;
        (json['data'] as Map<String, dynamic>)['favouriteIds'] = <String>['x'];
        return jsonEncode(json);
      };
      expect(
        await move(dto()),
        const Left<Failure, String?>(
          Failure.migration(MigrationError.verifyFailed),
        ),
      );
      expect(storage.files[ProviderId.google], 'source');
      expect(storage.calls, isNot(contains('detach:google')));
    });

    test(
      'a save in flight, an expired source, an expired destination',
      () async {
        vault.saving = true;
        expect(
          await move(dto()),
          const Left<Failure, String?>(Failure.migration(MigrationError.busy)),
        );
        vault.saving = false;

        auth.tokenFailure = const Failure.storageAuthExpired(ProviderId.google);
        expect(
          await move(dto()),
          const Left<Failure, String?>(
            Failure.migration(MigrationError.sourceExpired),
          ),
        );
        auth.tokenFailure = null;

        storage.failures['save:dropbox'] = const Failure.storageAuthExpired(
          ProviderId.dropbox,
        );
        expect(
          await move(dto()),
          const Left<Failure, String?>(
            Failure.migration(
              MigrationError.targetExpired,
              provider: 'Dropbox',
            ),
          ),
        );
      },
    );

    test('a source that cannot be renamed still counts as moved', () async {
      storage.failures['detach:google'] = const Failure.storageError(
        StorageError.driveRenameFailed,
      );
      expect(await move(dto()), const Right<Failure, String?>(null));
    });
  });
}
