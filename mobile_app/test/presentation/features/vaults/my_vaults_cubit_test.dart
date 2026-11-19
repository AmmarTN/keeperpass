import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/features/vaults/cubit/my_vaults_cubit.dart';

import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;
  late MyVaultsCubit cubit;

  setUp(() async {
    world = VaultWorld();
    await world.open();
    cubit = world.myVaultsCubit();
  });

  tearDown(() async {
    await cubit.close();
    await world.close();
  });

  Future<void> settle() async {
    for (int i = 0; i < 5; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  List<String> names() => <String>[
    for (final VaultEntry e in cubit.state.vaults) e.vault.name,
  ];

  test('your vaults, the default first, with their item counts', () {
    expect(names(), <String>['My Vault', 'Work']);
    expect(cubit.state.personal!.items, 7);
    expect(cubit.state.others.single.items, 4);
  });

  test('a shared vault is not yours to manage (web ownVaults)', () async {
    final VaultSnapshot s = world.vault.snapshot!;
    world.vault.update(
      s.copyWith(
        vaults: <Vault>[
          ...s.vaults,
          const Vault(id: 'team', name: 'Team', organizationId: 'org'),
        ],
      ),
    );
    await settle();
    expect(names(), <String>['My Vault', 'Work']);
    expect(cubit.state.allVaults.map((Vault v) => v.name), contains('Team'));
  });

  test('new, rename: each saved', () async {
    expect(await cubit.create('Travel'), isTrue);
    await settle();
    expect(names(), <String>['My Vault', 'Work', 'Travel']);
    expect(world.sync.state.phase, SyncPhase.saved);

    final String id = cubit.state.vaults.last.vault.id;
    expect(await cubit.rename(id, '  Trips  '), isTrue);
    await settle();
    expect(names().last, 'Trips');
  });

  test('deleting moves the items to My Vault; My Vault never goes', () async {
    expect(
      await cubit.delete(<String>[kWorkVaultId, kPersonalVaultId]),
      isTrue,
    );
    await settle();
    expect(names(), <String>['My Vault']);
    expect(cubit.state.personal!.items, 11);
    expect(
      world.vault.snapshot!.items.every(
        (VaultItem i) => i.vaultId == kPersonalVaultId,
      ),
      isTrue,
    );
  });

  test('selection: My Vault cannot be chosen; Select all and back', () {
    cubit
      ..startSelecting()
      ..toggle(kPersonalVaultId);
    expect(cubit.state.selected, isEmpty);
    cubit.toggleSelectAll();
    expect(cubit.state.selected, <String>{kWorkVaultId});
    expect(cubit.state.selectedItems, 4);
    cubit.toggleSelectAll();
    expect(cubit.state.selected, isEmpty);
    cubit.toggle(kWorkVaultId);
    cubit.cancelSelecting();
    expect(cubit.state.selecting, isFalse);
    expect(cubit.state.selected, isEmpty);
  });

  test('a deleted selection ends selection mode', () async {
    cubit
      ..startSelecting()
      ..toggle(kWorkVaultId);
    await cubit.delete(cubit.state.selected.toList());
    expect(cubit.state.selecting, isFalse);
  });
}
