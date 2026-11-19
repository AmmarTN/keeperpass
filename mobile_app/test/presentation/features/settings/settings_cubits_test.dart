import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/core/enums/migration_stage.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/storage_error.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/export_record.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/file_service.dart';
import 'package:keeperpass/presentation/common/cubit/session/session_cubit.dart';
import 'package:keeperpass/presentation/features/change_secret/cubit/change_secret_cubit.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/export_cubit.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/import_cubit.dart';
import 'package:keeperpass/presentation/features/move_vault/cubit/move_vault_cubit.dart';
import 'package:keeperpass/presentation/features/settings/cubit/settings_cubit.dart';

import '../../../helpers/vault_world.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late VaultWorld world;

  setUp(() async {
    world = VaultWorld();
    await world.open();
  });
  tearDown(() => world.close());

  group('Settings', () {
    test('reads the phone’s choices and where the vault can move', () async {
      world.lockSettings
        ..clipboard = ClipboardClearDelay.twoMinutes
        ..hideInSwitcher = false;
      final SettingsCubit cubit = world.settingsCubit();
      await cubit.load();

      expect(cubit.state.clipboardDelay, ClipboardClearDelay.twoMinutes);
      expect(cubit.state.hideInSwitcher, isFalse);
      expect(cubit.state.moveTargets, <ProviderId>[ProviderId.dropbox]);
      await cubit.close();
    });

    test('saves each choice on the phone', () async {
      final SettingsCubit cubit = world.settingsCubit();
      await cubit.load();
      await cubit.setClipboardDelay(ClipboardClearDelay.never);
      await cubit.setHideInSwitcher(false);

      expect(cubit.state.clipboardDelay, ClipboardClearDelay.never);
      expect(world.lockSettings.clipboard, ClipboardClearDelay.never);
      expect(world.lockSettings.hideInSwitcher, isFalse);
      // Each privacy change is put into effect at once (Part 14).
      expect(world.privacy.hideInSwitcher, isFalse);
      expect(world.privacy.blockScreenshots, isTrue);

      await cubit.setBlockScreenshots(false);
      expect(cubit.state.blockScreenshots, isFalse);
      expect(world.lockSettings.blockScreenshots, isFalse);
      expect(world.privacy.blockScreenshots, isFalse);
      await cubit.close();
    });

    test('follows the vault’s export record', () async {
      final SettingsCubit cubit = world.settingsCubit();
      expect(cubit.state.exports, isEmpty);
      final ExportRecord record = ExportRecord(
        at: world.now,
        format: 'csv',
        scope: 'All Vaults',
        itemCount: 3,
        fileName: 'keeperpass-all-vaults.csv',
      );
      world.vault.update(
        world.vault.snapshot!.copyWith(exportHistory: <ExportRecord>[record]),
      );
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.exports, <ExportRecord>[record]);
      await cubit.close();
    });
  });

  group('Change secret', () {
    test(
      'a wrong current secret goes back to the form, nothing cleared',
      () async {
        final ChangeSecretCubit cubit = world.changeSecretCubit()
          ..setCurrent('nope')
          ..setSecret('new secret words')
          ..setRepeat('new secret words');
        await cubit.submit();

        expect(cubit.state.step, ChangeSecretStep.form);
        expect(cubit.state.wrongCurrent, isTrue);
        expect(cubit.state.secret, 'new secret words');
        await cubit.close();
      },
    );

    test('the vault is saved under the new secret', () async {
      final ChangeSecretCubit cubit = world.changeSecretCubit()
        ..setCurrent('secret')
        ..setSecret('new secret words')
        ..setRepeat('new secret words');
      expect(cubit.state.canSubmit, isTrue);
      await cubit.submit();

      expect(cubit.state.step, ChangeSecretStep.done);
      expect(
        (await world.cipher.decrypt(
          'new secret words',
          world.storage.files[ProviderId.google]!,
        )).isRight(),
        isTrue,
      );
      await cubit.close();
    });

    test('a failed upload changes nothing and can be tried again', () async {
      world.storage.failures['reset:google'] = const Failure.storageError(
        StorageError.driveSaveFailed,
      );
      world.storage.failures['save:google'] = const Failure.storageError(
        StorageError.driveSaveFailed,
      );
      final ChangeSecretCubit cubit = world.changeSecretCubit()
        ..setCurrent('secret')
        ..setSecret('new secret words')
        ..setRepeat('new secret words');
      await cubit.submit();
      expect(cubit.state.step, ChangeSecretStep.failed);

      world.storage.failures.clear();
      await cubit.submit();
      expect(cubit.state.step, ChangeSecretStep.done);
      await cubit.close();
    });

    test('Generate fills both fields with a passphrase', () async {
      final ChangeSecretCubit cubit = world.changeSecretCubit();
      await cubit.generate();
      expect(cubit.state.secret.split('-'), hasLength(5));
      expect(cubit.state.repeat, cubit.state.secret);
      expect(cubit.state.generation, 1);
      await cubit.close();
    });
  });

  group('Move vault', () {
    test('connect, confirm, move: signed out, Welcome says where', () async {
      final MoveVaultCubit cubit = world.moveVaultCubit()
        ..start(ProviderId.dropbox);
      expect(cubit.state.from, ProviderId.google);
      await cubit.connect();
      expect(cubit.state.step, MoveVaultStep.confirm);
      expect(cubit.state.target!.email, 'jane@dropbox.example');
      expect(cubit.state.canMove, isTrue);

      final List<MigrationStage> stages = <MigrationStage>[];
      final Future<void> watching = cubit.stream
          .map((MoveVaultState s) => s.stage)
          .distinct()
          .forEach(stages.add);
      await cubit.move();

      expect(world.session.state.phase, SessionPhase.signedOut);
      expect(
        world.session.state.farewell,
        SessionFarewell.moved(
          from: ProviderId.google,
          to: ProviderId.dropbox,
          renamedFile: world.storage.detachedName,
        ),
      );
      expect(world.storage.files[ProviderId.dropbox], isNotNull);
      expect(
        stages,
        containsAllInOrder(<MigrationStage>[
          MigrationStage.uploading,
          MigrationStage.verifying,
          MigrationStage.finishing,
        ]),
      );
      await cubit.close();
      await watching;
    });

    test('a second Move before the progress shows moves once '
        '(2026-11-05)', () async {
      final MoveVaultCubit cubit = world.moveVaultCubit()
        ..start(ProviderId.dropbox);
      await cubit.connect();
      await Future.wait(<Future<void>>[cubit.move(), cubit.move()]);
      expect(
        world.storage.calls.where((String c) => c == 'save:dropbox'),
        hasLength(1),
      );
      await cubit.close();
    });

    test('an existing vault there needs consent', () async {
      world.storage.files[ProviderId.dropbox] = 'older';
      final MoveVaultCubit cubit = world.moveVaultCubit()
        ..start(ProviderId.dropbox);
      await cubit.connect();
      expect(cubit.state.target!.hasVault, isTrue);
      expect(cubit.state.canMove, isFalse);

      cubit.setReplace(true);
      expect(cubit.state.canMove, isTrue);
      await cubit.close();
    });

    test('a new secret must be typed twice', () async {
      final MoveVaultCubit cubit = world.moveVaultCubit()
        ..start(ProviderId.dropbox);
      await cubit.connect();
      cubit
        ..setNewSecret(true)
        ..setSecret('another secret');
      expect(cubit.state.canMove, isFalse);
      cubit.setRepeat('another secret');
      expect(cubit.state.canMove, isTrue);

      await cubit.move();
      expect(
        (await world.cipher.decrypt(
          'another secret',
          world.storage.files[ProviderId.dropbox]!,
        )).isRight(),
        isTrue,
      );
      await cubit.close();
    });

    test('a failed move changes nothing; Try again moves it', () async {
      world.storage.failures['save:dropbox'] = const Failure.storageError(
        StorageError.dropboxSaveFailed,
      );
      final MoveVaultCubit cubit = world.moveVaultCubit()
        ..start(ProviderId.dropbox);
      await cubit.connect();
      await cubit.move();
      expect(cubit.state.step, MoveVaultStep.failed);
      expect(cubit.state.failure, isNotNull);
      expect(world.session.state.phase, SessionPhase.ready);
      expect(world.storage.files[ProviderId.google], isNotNull);

      world.storage.failures.clear();
      await cubit.move();
      expect(world.session.state.phase, SessionPhase.signedOut);
      await cubit.close();
    });

    test('a closed sign-in stays on the start', () async {
      world.auth.elsewhereResult = const Left<Failure, Never>(
        Failure.signInCancelled(),
      );
      final MoveVaultCubit cubit = world.moveVaultCubit()
        ..start(ProviderId.dropbox);
      await cubit.connect();
      expect(cubit.state.step, MoveVaultStep.start);
      expect(cubit.state.connectFailure, const Failure.signInCancelled());
      await cubit.close();
    });
  });

  group('Import', () {
    const String csv =
        'name,tags,Username,Password\r\n'
        'GitHub,work,jane,hunter2\r\n'
        'GitLab,,jane,hunter3';

    test('reads the file at once; the personal vault is chosen', () async {
      final ImportCubit cubit = world.importCubit()
        ..load(
          const PickedTextFile(name: 'export.csv', size: 24576, text: csv),
        );
      expect(cubit.state.drafts, hasLength(2));
      expect(cubit.state.error, isNull);
      expect(cubit.state.vaultId, kPersonalVaultId);
      expect(cubit.state.vaults.first.items, greaterThan(0));
      await cubit.close();
    });

    test('nothing to import, or unreadable', () async {
      final ImportCubit cubit = world.importCubit()
        ..load(const PickedTextFile(name: 'notes.txt', text: ''));
      expect(cubit.state.error, ImportError.noItems);
      expect(cubit.state.canImport, isFalse);

      cubit.load(const PickedTextFile(name: 'notes.bin', text: null));
      expect(cubit.state.error, ImportError.invalidCsv);
      await cubit.close();
    });

    test('Import adds the items to the chosen vault and saves', () async {
      final int before = world.vault.snapshot!.items.length;
      final ImportCubit cubit = world.importCubit()
        ..load(const PickedTextFile(name: 'export.csv', text: csv));
      final String vaultId = world.vault.snapshot!.vaults.last.id;
      cubit.setVault(vaultId);
      expect(await cubit.import(), vaultId);

      final List<VaultItem> items = world.vault.snapshot!.items;
      expect(items, hasLength(before + 2));
      expect(items.last.vaultId, vaultId);
      await pumpEventQueue();
      expect(world.storage.calls, contains('save:google'));
      await cubit.close();
    });

    test('Change picks another file', () async {
      world.files.picked = const PickedTextFile(name: 'b.csv', text: csv);
      final ImportCubit cubit = world.importCubit()
        ..load(const PickedTextFile(name: 'a.txt', text: ''));
      await cubit.change();
      expect(cubit.state.fileName, 'b.csv');
      expect(cubit.state.error, isNull);
      await cubit.close();
    });
  });

  group('Export', () {
    test('All Vaults first, then each vault, with counts', () async {
      final ExportCubit cubit = world.exportCubit();
      final VaultSnapshot snapshot = world.vault.snapshot!;
      expect(cubit.state.sources.first.label, 'All Vaults');
      expect(cubit.state.sources.first.items, snapshot.items.length);
      expect(cubit.state.sources, hasLength(snapshot.vaults.length + 1));
      expect(cubit.state.vaultId, isNull);
      await cubit.close();
    });

    test('shares the CSV, then remembers the export and saves', () async {
      final ExportCubit cubit = world.exportCubit();
      final ExportSource work = cubit.state.sources.last;
      cubit.choose(work.vaultId);
      await cubit.export();

      expect(world.files.shared, hasLength(1));
      expect(world.files.shared.single.mimeType, 'text/csv');
      expect(world.files.shared.single.content, startsWith('name,tags'));
      final ExportRecord record = world.vault.snapshot!.exportHistory.first;
      expect(record.scope, work.label);
      expect(record.itemCount, work.items);
      expect(record.format, 'csv');
      expect(record.fileName, world.files.shared.single.fileName);
      await pumpEventQueue();
      expect(world.storage.calls, contains('save:google'));
      expect(cubit.state.exporting, isFalse);
      await cubit.close();
    });
  });
}
