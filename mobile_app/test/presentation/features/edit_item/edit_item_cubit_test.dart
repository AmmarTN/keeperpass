import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/history_entry.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/features/edit_item/cubit/edit_item_cubit.dart';

import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;
  late EditItemCubit cubit;

  setUp(() async {
    world = VaultWorld(
      now: kItemBoardsNow,
      snapshot: itemBoardsVault(kItemBoardsNow),
    );
    await world.open();
    cubit = world.editCubit();
  });

  tearDown(() async {
    await cubit.close();
    await world.close();
  });

  VaultItem? item(String id) => world.vault.snapshot!.items
      .where((VaultItem i) => i.id == id)
      .firstOrNull;

  Future<void> settle() async {
    for (int i = 0; i < 5; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  int saves() =>
      world.storage.calls.where((String c) => c == 'save:google').length;

  void website() => cubit.startNew(
    vaultId: kWorkVaultId,
    icon: 'web',
    fields: const <({FieldType type, String name})>[
      (type: FieldType.username, name: 'Username'),
      (type: FieldType.password, name: 'Password'),
      (type: FieldType.url, name: 'URL'),
    ],
  );

  group('Edit opens while its check runs (your answer, 2026-11-05)', () {
    test('after Load the latest, Edit starts over from the latest item, so '
        'Save can never write the older copy back', () {
      cubit
        ..startEdit('visa')
        ..setName('Typed before the sheet');
      world.vault.reload(
        world.vault.snapshot!.copyWith(
          items: <VaultItem>[
            for (final VaultItem i in world.vault.snapshot!.items)
              i.id == 'visa' ? i.copyWith(name: 'Visa (from the web)') : i,
          ],
        ),
        kItemBoardsNow,
      );
      expect(cubit.state.name, 'Visa (from the web)');
      expect(cubit.state.changed, isFalse);
    });

    test('Save while the opening check still runs waits for it, then '
        'saves', () async {
      cubit.startEdit('visa');
      world.storage.holdNewer = Completer<void>();
      unawaited(world.sync.checkBeforeEditing());
      cubit.setName('Visa card');
      final Future<String?> saving = cubit.save();
      await settle();
      expect(cubit.state.saving, isTrue);
      world.storage.holdNewer!.complete();
      expect(await saving, 'visa');
      expect(item('visa')!.name, 'Visa card');
    });
  });

  group('a new item (web ItemDraftStore + createItem)', () {
    test('starts from its template; nothing in the vault yet', () {
      final int before = world.vault.snapshot!.items.length;
      website();
      expect(cubit.state.isNew, isTrue);
      expect(cubit.state.fields.map((EditableField f) => f.name), <String>[
        'Username',
        'Password',
        'URL',
      ]);
      expect(cubit.state.fields[1].secret, isTrue);
      expect(cubit.state.changed, isFalse);
      expect(world.vault.snapshot!.items, hasLength(before));
    });

    test('Save waits for a name', () async {
      website();
      expect(cubit.state.canSave, isFalse);
      expect(await cubit.save(), isNull);
      cubit.setName('Figma');
      expect(cubit.state.changed, isTrue);
      expect(cubit.state.canSave, isTrue);
    });

    test('Save adds it, registers its tags, checks it and saves', () async {
      website();
      cubit
        ..setName('  Figma ')
        ..setFieldValue(cubit.state.fields[0].key, 'jane')
        ..setFieldValue(cubit.state.fields[1].key, kWeakPassword)
        ..setIcon('f084');
      expect(cubit.addTag(' design '), isTrue);
      final String? id = await cubit.save();
      await settle();

      final VaultItem created = item(id!)!;
      expect(created.name, 'Figma');
      expect(created.vaultId, kWorkVaultId);
      expect(created.icon, 'web');
      expect(created.iconGlyph, 'f084');
      expect(created.tags, <String>['design']);
      expect(created.created, kItemBoardsNow.toUtc());
      expect(created.updated, kItemBoardsNow.toUtc());
      expect(created.history, isEmpty);
      // The Secret flag is stored only when it differs from the type's.
      expect(created.fields.map((Field f) => f.secret), <bool?>[
        null,
        null,
        null,
      ]);
      expect(
        world.vault.snapshot!.tagRegistry.map((TagRegistryEntry e) => e.name),
        contains('design'),
      );
      expect(world.audit.state.hasFinding(id, AuditTypeForTest.weak), isTrue);
      expect(saves(), 1);
    });
  });

  group('an existing item (web updateItem)', () {
    test('opens as stored; unchanged, Save waits', () {
      cubit.startEdit('github');
      expect(cubit.state.name, 'GitHub');
      expect(cubit.state.tags, <String>['work', 'dev']);
      expect(cubit.state.fields, hasLength(4));
      expect(cubit.state.changed, isFalse);
      expect(cubit.state.canSave, isFalse);
      // Tags in another order are not a change.
      cubit
        ..removeTag('work')
        ..addTag('work');
      expect(cubit.state.changed, isFalse);
    });

    test('Save keeps the old version first and changes the rest', () async {
      final VaultItem before = item('github')!;
      cubit.startEdit('github');
      cubit
        ..setName('GitHub (work)')
        ..setFieldValue(cubit.state.fields[1].key, 'N3w-l0ng-passphrase')
        ..setFieldSecret(cubit.state.fields[0].key, true);
      final int key = cubit.addField(FieldType.pin, 'PIN');
      cubit.setFieldValue(key, '1234');
      await cubit.save();
      await settle();

      final VaultItem after = item('github')!;
      expect(after.name, 'GitHub (work)');
      expect(after.fields, hasLength(5));
      expect(after.fields[0].secret, isTrue);
      expect(after.fields[1].value, 'N3w-l0ng-passphrase');
      expect(after.fields[4].typeValue, 'pin');
      expect(after.updated, kItemBoardsNow.toUtc());
      expect(after.history, hasLength(3));
      final HistoryEntry snapshot = after.history.first;
      expect(snapshot.name, 'GitHub');
      expect(snapshot.fields, before.fields);
      expect(snapshot.updated, before.updated);
      expect(saves(), 1);
    });

    test('keys this version does not know are written back (X9)', () async {
      final VaultSnapshot s = world.vault.snapshot!;
      world.vault.update(
        s.copyWith(
          items: <VaultItem>[
            for (final VaultItem i in s.items)
              i.id == 'wifi'
                  ? i.copyWith(
                      fields: <Field>[
                        i.fields[0].copyWith(
                          unknown: const <String, Object?>{'hint': 'x'},
                        ),
                        i.fields[1],
                      ],
                    )
                  : i,
          ],
        ),
      );
      cubit.startEdit('wifi');
      cubit.setFieldValue(cubit.state.fields[0].key, 'Doe-Home-6G');
      await cubit.save();
      expect(item('wifi')!.fields[0].value, 'Doe-Home-6G');
      expect(item('wifi')!.fields[0].unknown, <String, Object?>{'hint': 'x'});
    });

    test('removing a field, and an invalid value, block nothing but Save', () {
      cubit.startEdit('apple');
      cubit.removeField(cubit.state.fields.last.key);
      expect(cubit.state.fields, hasLength(3));
      expect(cubit.state.canSave, isTrue);
      cubit.setFieldValue(cubit.state.fields[0].key, 'a\nb');
      expect(cubit.state.canSave, isFalse);
    });

    test('deleted elsewhere while open', () {
      cubit.startEdit('github');
      final VaultSnapshot s = world.vault.snapshot!;
      world.vault.update(
        s.copyWith(
          items: s.items.where((VaultItem i) => i.id != 'github').toList(),
        ),
      );
      expect(cubit.state.gone, isTrue);
    });

    test('a newer version on Dropbox: nothing is written', () async {
      world.auth.current = world.auth.current!.copyWith(
        provider: ProviderId.dropbox,
      );
      world.storage.newer[ProviderId.dropbox] = VaultFileInfo(
        modifiedAt: DateTime.utc(2026, 11),
      );
      cubit.startEdit('github');
      cubit.setName('Other');
      expect(await cubit.save(), isNull);
      expect(world.sync.state.phase, SyncPhase.conflict);
      expect(item('github')!.name, 'GitHub');
      expect(cubit.state.saving, isFalse);
    });
  });

  group('tags (web addTag)', () {
    test('trimmed, once, and typed names validated', () {
      cubit.startEdit('apple');
      expect(cubit.addTag('  '), isFalse);
      expect(cubit.addTag('personal'), isFalse);
      expect(cubit.addTag('x' * 101), isFalse);
      expect(cubit.addTag('x' * 101, typed: false), isTrue);
      expect(cubit.addTag(' travel '), isTrue);
      expect(cubit.state.tags.last, 'travel');
    });
  });

  group('fixing a finding (Part 11)', () {
    late VaultWorld security;
    late EditItemCubit fix;

    setUp(() async {
      security = VaultWorld(
        now: kItemBoardsNow,
        snapshot: securityBoardsVault(kItemBoardsNow),
      );
      security.breaches.compromised.add(kBreachedPassword);
      await security.open();
      fix = security.editCubit();
    });

    tearDown(() async {
      await fix.close();
      await security.close();
    });

    int keyOf(String fieldName) => fix.state.fields
        .firstWhere((EditableField f) => f.name == fieldName)
        .key;

    test('a field knows its findings from the last audit', () {
      fix.startEdit('netflix');
      expect(fix.findingsOn(keyOf('Password')), <AuditType>[
        AuditType.weakPassword,
      ]);
      expect(fix.findingsOn(keyOf('Account Password')), <AuditType>[
        AuditType.reusedPassword,
      ]);
      expect(fix.findingsOn(keyOf('Email')), isEmpty);
      fix.startEdit('facebook');
      expect(fix.findingsOn(keyOf('Old Password')), <AuditType>[
        AuditType.compromisedPassword,
      ]);
    });

    test('what a new password clears: weak by its strength, reused when '
        'nothing else holds it', () {
      fix.startEdit('netflix');
      const List<AuditType> both = <AuditType>[
        AuditType.weakPassword,
        AuditType.reusedPassword,
      ];
      final int key = keyOf('Password');
      expect(fix.clears(key, 'Fresh-Generated-Passphrase-88', both), (
        weak: true,
        reused: true,
      ));
      // Still weak; and another item already holds it.
      expect(fix.clears(key, 'spotify', both), (weak: false, reused: false));
      // Another field of this item holds it.
      expect(fix.clears(key, kSharedPassword, both), (
        weak: true,
        reused: false,
      ));
      // Only what the field had is said.
      expect(
        fix.clears(key, 'Fresh-Generated-Passphrase-88', const <AuditType>[
          AuditType.compromisedPassword,
        ]),
        (weak: false, reused: false),
      );
    });

    test('Save hands back the item’s re-check', () async {
      fix.startEdit('spotify');
      fix.setFieldValue(keyOf('Password'), 'Fresh-Generated-Passphrase-88');
      expect(await fix.save(), 'spotify');
      expect(await fix.recheck, isTrue);
      expect(security.audit.state.findingsFor('spotify'), isEmpty);
    });
  });

  test('the catalogue and country names load once', () async {
    expect(await cubit.iconCatalog(), hasLength(1402));
    expect(
      identical(await cubit.iconCatalog(), await cubit.iconCatalog()),
      isTrue,
    );
    expect((await cubit.countryNames())['en'], isNotNull);
  });
}

/// The audit's weak-password finding.
abstract final class AuditTypeForTest {
  static const AuditType weak = AuditType.weakPassword;
}
