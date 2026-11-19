import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/core/utils/items/item_sections.dart';
import 'package:keeperpass/infrastructure/models/general/cubitStatus.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_cubit.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';

import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;
  late VaultListCubit cubit;

  setUp(() async {
    world = VaultWorld();
    await world.open();
    cubit = world.list;
  });

  tearDown(() => world.close());

  List<String> ids() => <String>[
    for (final VaultRow r in cubit.state.view.rows) r.id,
  ];
  VaultItem item(String id) =>
      world.vault.snapshot!.items.firstWhere((VaultItem i) => i.id == id);

  /// Lets saves and stream updates land.
  Future<void> settle() async {
    for (int i = 0; i < 5; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  test('starts on All Vaults, newest first, with the audit findings', () {
    expect(cubit.state.scope, VaultScope.all);
    expect(ids(), hasLength(11));
    final VaultRow facebook = cubit.state.view.rows.firstWhere(
      (VaultRow r) => r.id == 'facebook',
    );
    expect(facebook.findings, <AuditType>[
      AuditType.reusedPassword,
      AuditType.compromisedPassword,
    ]);
  });

  test('scope, tag, report, sort', () {
    cubit.setScope(VaultScope.vault, vaultId: kWorkVaultId);
    expect(ids(), <String>['github', 'slack', 'gitlab', 'docker']);
    cubit.toggleTag('dev');
    expect(cubit.state.tag, 'dev');
    cubit.toggleTag('dev');
    expect(cubit.state.tag, isNull);
    cubit.setSort(ItemSort.aToZ);
    expect(ids(), <String>['docker', 'github', 'gitlab', 'slack']);

    cubit.showReport(AuditType.weakPassword);
    expect(cubit.state.scope, VaultScope.all);
    expect(ids(), <String>['netflix']);
    cubit.clearReport();
    expect(ids(), hasLength(11));
  });

  test('search starts, filters as typed, and Cancel restores the list', () {
    cubit.startSearch();
    cubit.setSearch('work git');
    expect(ids(), <String>['github', 'gitlab']);
    cubit.cancelSearch();
    expect(cubit.state.searching, isFalse);
    expect(cubit.state.search, isEmpty);
    expect(ids(), hasLength(11));
  });

  test('selection: one from the quick sheet, toggles, Select All', () {
    cubit.startSelecting('github');
    expect(cubit.state.selecting, isTrue);
    cubit.toggleSelected('slack');
    cubit.toggleSelected('github');
    expect(cubit.state.selected, <String>{'slack'});
    cubit.toggleSelectAll();
    expect(cubit.state.selected, hasLength(11));
    expect(cubit.state.allSelected, isTrue);
    cubit.toggleSelectAll();
    expect(cubit.state.selected, isEmpty);
    cubit.cancelSelecting();
    expect(cubit.state.selecting, isFalse);
  });

  test(
    'copy: the value, a 2FA code for a 2FA field, and Recently Used',
    () async {
      final VaultItem github = item('github');
      expect(await cubit.copy('github', github.fields[1]), isNotNull);
      expect(world.clipboard.copied.last, github.fields[1].value);
      expect(await cubit.copy('github', github.fields[2]), isNotNull);
      expect(world.clipboard.copied.last, matches(RegExp(r'^\d{6}$')));
      expect(world.recent.ids, <String>['github']);
      expect(
        await cubit.copy(
          'github',
          Field.of(name: 'x', type: github.fields[0].type, value: ''),
        ),
        isNull,
      );
      await settle();
      cubit.setScope(VaultScope.recent);
      expect(ids(), <String>['github']);
    },
  );

  test('a favorite changes and is saved at once', () async {
    expect(await cubit.toggleFavourite('netflix'), isTrue);
    await settle();
    expect(world.vault.snapshot!.favouriteIds, contains('netflix'));
    expect(world.storage.calls, contains('save:google'));
    expect(await cubit.toggleFavourite('netflix'), isFalse);
  });

  test('move: items change vault, selection ends, saved', () async {
    cubit.startSelecting('github');
    cubit.toggleSelected('slack');
    expect(
      await cubit.moveItems(<String>['github', 'slack'], kPersonalVaultId),
      isTrue,
    );
    await settle();
    expect(item('github').vaultId, kPersonalVaultId);
    expect(item('github').tags, <String>['work', 'dev']);
    expect(cubit.state.selecting, isFalse);
    expect(
      world.storage.calls.where((String c) => c == 'save:google'),
      hasLength(1),
    );
  });

  test('New vault…: created, moved into, saved once', () async {
    final Vault? vault = await cubit.moveItemsToNewVault(<String>[
      'visa',
    ], 'Travel');
    await settle();
    expect(vault!.name, 'Travel');
    expect(
      world.vault.snapshot!.vaults.map((Vault v) => v.name),
      contains('Travel'),
    );
    expect(item('visa').vaultId, vault.id);
    expect(
      world.storage.calls.where((String c) => c == 'save:google'),
      hasLength(1),
    );
  });

  test('delete: gone with its favorite mark and recent entry, saved', () async {
    await cubit.copy('paypal', item('paypal').fields[1]);
    expect(await cubit.deleteItems(<String>['paypal']), isTrue);
    await settle();
    expect(
      world.vault.snapshot!.items.any((VaultItem i) => i.id == 'paypal'),
      isFalse,
    );
    expect(world.vault.snapshot!.favouriteIds, isNot(contains('paypal')));
    expect(world.recent.ids, isNot(contains('paypal')));
    expect(ids(), hasLength(10));
  });

  test('a newer version on Dropbox pauses changes', () async {
    world.auth.current = world.auth.current!.copyWith(
      provider: ProviderId.dropbox,
    );
    world.storage.newer[ProviderId.dropbox] = VaultFileInfo(
      modifiedAt: DateTime.utc(2026, 11),
    );
    expect(await cubit.toggleFavourite('netflix'), isNull);
    expect(world.sync.state.phase, SyncPhase.conflict);
    expect(world.vault.snapshot!.favouriteIds, isNot(contains('netflix')));
  });

  group('pull to refresh (your answer, Part 7)', () {
    test('re-reads the vault when nothing is waiting', () async {
      await cubit.refresh();
      expect(world.storage.calls, contains('load:google'));
      expect(cubit.state.refreshing, isFalse);
    });

    test('saves a waiting change instead of re-reading it away', () async {
      world.storage.failures['save:google'] = const Failure.networkFailure(
        NetworkFailure.sendTimeout(),
      );
      await cubit.toggleFavourite('netflix');
      await settle();
      expect(world.sync.state.pendingChanges, 1);
      world.storage.failures.clear();
      world.storage.calls.clear();

      await cubit.refresh();
      expect(world.storage.calls, contains('save:google'));
      expect(world.storage.calls, isNot(contains('load:google')));
      expect(world.vault.snapshot!.favouriteIds, contains('netflix'));
    });

    test('a failed re-read is reported', () async {
      world.storage.failures['load:google'] = const Failure.networkFailure(
        NetworkFailure.receiveTimeout(),
      );
      await cubit.refresh();
      expect(cubit.state.status.action, CubitAction.refreshVault);
      expect(cubit.state.status.statusType, CubitStatusType.failure);
    });
  });

  test('Open website adds https when there is no scheme', () async {
    await cubit.openWebsite('paypal.com');
    await cubit.openWebsite('https://github.com/login');
    expect(world.links.opened.map((Uri u) => '$u'), <String>[
      'https://paypal.com',
      'https://github.com/login',
    ]);
  });

  test('a vault that disappears falls back to All Vaults', () async {
    cubit.setScope(VaultScope.vault, vaultId: 'gone');
    expect(cubit.state.scope, VaultScope.all);
  });
}
