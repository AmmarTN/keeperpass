import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/usecases/items/create_item.dart';
import 'package:keeperpass/core/usecases/items/update_item.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/camera_permission_service.dart';
import 'package:keeperpass/infrastructure/services/lock_service.dart';
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';

import '../../../helpers/vault_world.dart';

void main() {
  final DateTime boardsNow = DateTime(2026, 10, 29, 9, 45, 6);
  late VaultWorld world;
  late DateTime clock;
  late ScanCubit cubit;

  setUp(() async {
    world = VaultWorld(now: boardsNow, snapshot: scanBoardsVault(boardsNow));
    await world.open();
    clock = boardsNow;
    cubit = ScanCubit(
      world.vault,
      world.sync,
      world.audit,
      CreateItem(world.vault, now: () => boardsNow),
      UpdateItem(world.vault, now: () => boardsNow),
      world.camera,
      LockService(),
      now: () => clock,
    );
  });

  tearDown(() async {
    await cubit.close();
    await world.close();
  });

  VaultItem item(String id) =>
      world.vault.snapshot!.items.firstWhere((VaultItem i) => i.id == id);

  List<String> totpKeys(VaultItem item) => <String>[
    for (final Field f in item.fields)
      if (f.type == FieldType.totp) f.value,
  ];

  group('camera access (plan, Part 15 rule 11)', () {
    test('the screen starts where access stands', () {
      cubit.open(CameraAccess.askable);
      expect(cubit.state.step, ScanStep.primer);
      cubit.open(CameraAccess.allowed);
      expect(cubit.state.step, ScanStep.scanning);
      cubit.open(CameraAccess.refused);
      expect(cubit.state.step, ScanStep.cameraOff);
    });

    test('Continue asks; yes scans, no is "Camera access is off"', () async {
      cubit.open(CameraAccess.askable);
      await cubit.allowCamera();
      expect(world.camera.asked, 1);
      expect(cubit.state.step, ScanStep.scanning);

      cubit.open(CameraAccess.askable);
      world.camera.answer = CameraAccess.refused;
      await cubit.allowCamera();
      expect(cubit.state.step, ScanStep.cameraOff);
    });

    test('back from Settings, scanning starts once allowed', () async {
      world.camera.access = CameraAccess.refused;
      cubit.open(CameraAccess.refused);
      await cubit.openSettings();
      expect(world.camera.settingsOpened, 1);

      await cubit.recheck();
      expect(cubit.state.step, ScanStep.cameraOff);

      world.camera.access = CameraAccess.allowed;
      await cubit.recheck();
      expect(cubit.state.step, ScanStep.scanning);
    });

    test('a camera that cannot start is said once per problem', () {
      cubit.open(CameraAccess.allowed);
      cubit.cameraFailed();
      expect(cubit.state.notice, ScanNotice.cameraFailed);
      expect(cubit.state.notices, 1);
      cubit.cameraRefused();
      expect(cubit.state.step, ScanStep.cameraOff);
    });
  });

  group('reading', () {
    setUp(() => cubit.open(CameraAccess.allowed));

    test('S6-29: the Dropbox QR code offers the Dropbox item', () {
      cubit.read(kDropboxQr);
      final ScanState state = cubit.state;
      expect(state.found?.issuer, 'Dropbox');
      expect(state.found?.account, 'jane.doe92@example.com');
      expect(state.matches.map((VaultRow r) => r.id), <String>['dropbox']);
      expect(state.targetId, 'dropbox');
    });

    test('several matches A to Z, the first chosen; none: a new item', () {
      world.vault.update(
        world.vault.snapshot!.copyWith(
          items: <VaultItem>[
            ...world.vault.snapshot!.items,
            VaultItem(
              id: 'dropbox-2',
              vaultId: kWorkVaultId,
              name: ' dropbox ',
              fields: const <Field>[],
              updated: boardsNow.toUtc(),
            ),
          ],
        ),
      );
      cubit.read(kDropboxQr);
      expect(cubit.state.matches, hasLength(2));
      expect(cubit.state.targetId, cubit.state.matches.first.id);
      cubit.closeFound();

      cubit.read('otpauth://totp/Linear:jane?secret=JBSWY3DPEHPK3PXP');
      expect(cubit.state.found?.issuer, 'Linear');
      expect(cubit.state.matches, isEmpty);
      expect(cubit.state.targetId, isNull);
    });

    test('what gives no code is said; the same code not again at once', () {
      cubit.read('https://www.dropbox.com');
      expect(cubit.state.notice, ScanNotice.notACode);
      expect(cubit.state.notices, 1);
      cubit.read('https://www.dropbox.com');
      expect(cubit.state.notices, 1);

      clock = clock.add(ScanCubit.rereadAfter);
      cubit.read('https://www.dropbox.com');
      expect(cubit.state.notices, 2);

      cubit.read('otpauth://totp/A?secret=JBSWY3DPEHPK3PXP&digits=8');
      expect(cubit.state.notice, ScanNotice.unsupported);
      cubit.read('otpauth://totp/A?secret=NOT-A-KEY');
      expect(cubit.state.notice, ScanNotice.invalidKey);
      expect(cubit.state.found, isNull);
    });

    test('nothing is read while "Code Found" is up; closed, scanning goes '
        'on, the same code after a moment', () {
      cubit.read(kDropboxQr);
      cubit.read('otpauth://totp/Linear:jane?secret=JBSWY3DPEHPK3PXP');
      expect(cubit.state.found?.issuer, 'Dropbox');

      cubit.closeFound();
      expect(cubit.state.found, isNull);
      cubit.read(kDropboxQr);
      expect(cubit.state.found, isNull);
      clock = clock.add(ScanCubit.rereadAfter);
      cubit.read(kDropboxQr);
      expect(cubit.state.found?.issuer, 'Dropbox');
    });

    test('nothing is read on the primer or with the camera off', () {
      cubit.open(CameraAccess.askable);
      cubit.read(kDropboxQr);
      expect(cubit.state.found, isNull);
    });
  });

  group('saving (plan, Part 15 rules 6 and 7)', () {
    setUp(() => cubit.open(CameraAccess.allowed));

    test(
      'into the Dropbox login: a 2FA field at the end, as an edit',
      () async {
        cubit.read(kDropboxQr);
        final CodeAdded? added = await cubit.save();
        expect(added?.itemId, 'dropbox');
        expect(added?.name, 'Dropbox');

        final VaultItem dropbox = item('dropbox');
        expect(dropbox.fields.last.type, FieldType.totp);
        expect(dropbox.fields.last.name, 'Authenticator Code');
        expect(dropbox.fields.last.value, 'JBSWY3DPEHPK3PXP');
        expect(dropbox.fields, hasLength(4));
        // The item as it was is in its history.
        expect(dropbox.history.single.fields, hasLength(3));
        expect(cubit.state.status.statusType.name, 'success');
        await pumpEventQueue();
        expect(world.storage.calls, contains('save:google'));
      },
    );

    test('an empty 2FA field is filled', () async {
      cubit.read(
        'otpauth://totp/admin?secret=GEZDGNBVGY3TQOJQ&issuer=Server%20notes',
      );
      await cubit.save();
      expect(totpKeys(item('notes')), <String>['GEZDGNBVGY3TQOJQ']);
    });

    test('a code already there: a second 2FA field, even the same key '
        '(your answer)', () async {
      cubit.read('otpauth://totp/GitHub:janedoe-dev?secret=$kTotpKey');
      await cubit.save();
      expect(totpKeys(item('github')), <String>[kTotpKey, kTotpKey]);
    });

    test('a new Authenticator item in My Vault, the account as its '
        'username (your answer)', () async {
      cubit.read(kDropboxQr);
      cubit.choose(null);
      final CodeAdded? added = await cubit.save();
      final VaultItem created = item(added!.itemId);
      expect(created.name, 'Dropbox');
      expect(created.vaultId, kPersonalVaultId);
      expect(created.icon, 'totp');
      expect(
        created.fields.map((Field f) => (f.type, f.name, f.value)),
        <(FieldType, String, String)>[
          (FieldType.totp, 'Authenticator Code', 'JBSWY3DPEHPK3PXP'),
          (FieldType.username, 'Username', 'jane.doe92@example.com'),
        ],
      );
      expect(added.itemId, isNot('dropbox'));
    });

    test(
      'named after the account without a site, else "Authenticator"',
      () async {
        cubit.read('otpauth://totp/jane%40example.com?secret=JBSWY3DPEHPK3PXP');
        CodeAdded? added = await cubit.save();
        expect(item(added!.itemId).name, 'jane@example.com');

        cubit
          ..closeFound()
          ..read('otpauth://totp/?secret=GEZDGNBVGY3TQOJQ');
        added = await cubit.save();
        final VaultItem created = item(added!.itemId);
        expect(created.name, 'Authenticator');
        expect(created.fields, hasLength(1));
      },
    );

    test('a typed key into the chosen item', () async {
      final CodeAdded? added = await cubit.saveTyped(
        ' MFRG GZDF ',
        itemId: 'dropbox',
      );
      expect(added?.name, 'Dropbox');
      expect(totpKeys(item('dropbox')), <String>['MFRG GZDF']);
    });

    test(
      'a newer version first: nothing saved, the sheet asks to load it',
      () async {
        world.storage.newer[ProviderId.google] = VaultFileInfo(
          modifiedAt: boardsNow,
        );
        cubit.read(kDropboxQr);
        expect(await cubit.save(), isNull);
        expect(item('dropbox').fields, hasLength(3));
        expect(world.sync.state.conflictPrompts, 1);
        expect(cubit.state.saving, isFalse);
      },
    );

    test('the all-items choice is A to Z', () {
      expect(cubit.allItems().map((VaultRow r) => r.item.name), <String>[
        'AWS Console',
        'Cloudflare',
        'Dropbox',
        'GitHub',
        'Server notes',
      ]);
    });
  });
}
