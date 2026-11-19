import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/history_entry.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/tag_registry_entry.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart';

import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;
  late ItemDetailCubit cubit;

  setUp(() async {
    world = VaultWorld(
      now: kItemBoardsNow,
      snapshot: itemBoardsVault(kItemBoardsNow),
    );
    await world.open();
    cubit = world.itemCubit();
  });

  tearDown(() async {
    await cubit.close();
    await world.close();
  });

  VaultItem item(String id) =>
      world.vault.snapshot!.items.firstWhere((VaultItem i) => i.id == id);

  /// Lets saves and stream updates land.
  Future<void> settle() async {
    for (int i = 0; i < 5; i++) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  int saves() =>
      world.storage.calls.where((String c) => c == 'save:google').length;

  test('opening shows the item, counts it as used, loads the tables', () async {
    await cubit.open('github');
    expect(cubit.state.row!.item.name, 'GitHub');
    expect(cubit.state.row!.vaultLabel, 'Work');
    expect(cubit.state.row!.favourite, isTrue);
    expect(cubit.state.gone, isFalse);
    expect(world.recent.ids, <String>['github']);
    expect(cubit.state.relativeTime, isNotNull);
    expect(cubit.state.countryNames['en'], isNotNull);
  });

  test('each secret is revealed on its own', () async {
    await cubit.open('visa');
    cubit.toggleReveal(0);
    cubit.toggleReveal(3);
    expect(cubit.state.revealed, <int>{0, 3});
    cubit.toggleReveal(0);
    expect(cubit.state.revealed, <int>{3});
  });

  group('copy', () {
    test('a value as stored, and the item counts as used', () async {
      await cubit.open('github');
      world.recent.ids = <String>[];
      expect(await cubit.copy(item('github').fields[1]), isNotNull);
      expect(world.clipboard.copied, <String>[kGitHubPassword]);
      expect(world.recent.ids, <String>['github']);
    });

    test('a 2FA field copies its current code, never the key', () async {
      await cubit.open('github');
      expect(await cubit.copy(item('github').fields[3]), isNotNull);
      expect(world.clipboard.copied.single, matches(RegExp(r'^\d{6}$')));
    });

    test(
      'an IBAN without spaces; one recovery code; nothing → false',
      () async {
        await cubit.open('savings');
        await cubit.copy(item('savings').fields[1]);
        expect(world.clipboard.copied.last, 'DE89370400440532013000');
        await cubit.copy(item('savings').fields[0], value: 'm4xz-p8r2');
        expect(world.clipboard.copied.last, 'm4xz-p8r2');

        await cubit.open('apple');
        expect(await cubit.copy(item('apple').fields[3]), isNull);
        await cubit.open('bad-key');
        expect(await cubit.copy(item('bad-key').fields[1]), isNull);
      },
    );
  });

  test('websites, calls and messages open in other apps', () async {
    await cubit.open('apple');
    await cubit.openWebsite('github.com');
    await cubit.call('+1 503-555-0142');
    await cubit.message('+1 503-555-0142');
    expect(world.links.opened.map((Uri u) => '$u'), <String>[
      'https://github.com',
      'tel:+15035550142',
      'sms:+15035550142',
    ]);
  });

  test('favorite: changed and saved at once', () async {
    await cubit.open('visa');
    expect(await cubit.toggleFavourite(), isTrue);
    await settle();
    expect(cubit.state.row!.favourite, isTrue);
    expect(saves(), 1);
  });

  test('move: to a vault, or a new one; saved', () async {
    await cubit.open('visa');
    expect(cubit.vaultCounts[kPersonalVaultId], 8);
    expect(await cubit.moveItems(<String>['visa'], kWorkVaultId), isTrue);
    await settle();
    expect(cubit.state.row!.vaultLabel, 'Work');
    final Vault? travel = await cubit.moveItemsToNewVault(<String>[
      'visa',
    ], 'Travel');
    await settle();
    expect(cubit.state.row!.vaultLabel, 'Travel');
    expect(travel!.name, 'Travel');
    expect(saves(), 2);
  });

  test('delete: gone for good, saved, and no "gone" screen first', () async {
    await cubit.open('github');
    final List<ItemDetailState> states = <ItemDetailState>[];
    cubit.stream.listen(states.add);
    expect(await cubit.delete(), isTrue);
    await settle();
    expect(
      world.vault.snapshot!.items.any((VaultItem i) => i.id == 'github'),
      isFalse,
    );
    expect(world.vault.snapshot!.favouriteIds, isNot(contains('github')));
    expect(world.recent.ids, isNot(contains('github')));
    expect(states.any((ItemDetailState s) => s.gone), isFalse);
    expect(saves(), 1);
  });

  test(
    'an item deleted elsewhere shows "This item no longer exists."',
    () async {
      await cubit.open('github');
      final VaultSnapshot snapshot = world.vault.snapshot!;
      world.vault.update(
        snapshot.copyWith(
          items: snapshot.items
              .where((VaultItem i) => i.id != 'github')
              .toList(),
        ),
      );
      expect(cubit.state.gone, isTrue);
      expect(cubit.state.row, isNull);
    },
  );

  group('history (web restoreHistoryEntry / deleteHistoryEntry)', () {
    test('restore: the old version back, the current one kept first, '
        'tags registered, checked and saved', () async {
      await cubit.open('github');
      cubit.toggleReveal(1);
      final VaultItem before = item('github');

      expect(await cubit.restore(1), isTrue);
      await settle();

      final VaultItem after = item('github');
      expect(after.fields, before.history[1].fields);
      expect(after.tags, <String>['work']);
      expect(after.updated, kItemBoardsNow.toUtc());
      expect(after.history, hasLength(3));
      expect(after.history.first.fields, before.fields);
      expect(after.history.first.tags, <String>['work', 'dev']);
      expect(after.history.first.updated, before.updated);
      expect(
        world.vault.snapshot!.tagRegistry.map((TagRegistryEntry e) => e.name),
        contains('work'),
      );
      // Field positions mean other values now: everything masked again.
      expect(cubit.state.revealed, isEmpty);
      expect(saves(), 1);
    });

    test(
      'delete version: that one gone, nothing else changed, saved',
      () async {
        await cubit.open('github');
        final VaultItem before = item('github');
        expect(await cubit.deleteVersion(0), isTrue);
        await settle();
        final VaultItem after = item('github');
        expect(
          <DateTime>[for (final HistoryEntry e in after.history) e.updated],
          <DateTime>[before.history[1].updated],
        );
        expect(after.fields, before.fields);
        expect(after.updated, before.updated);
        expect(saves(), 1);
      },
    );

    test('a stale version changes nothing', () async {
      await cubit.open('github');
      expect(await cubit.restore(7), isFalse);
      expect(await cubit.deleteVersion(-1), isFalse);
      expect(saves(), 0);
    });
  });

  test('a newer version on Dropbox pauses changes', () async {
    world.auth.current = world.auth.current!.copyWith(
      provider: ProviderId.dropbox,
    );
    world.storage.newer[ProviderId.dropbox] = VaultFileInfo(
      modifiedAt: DateTime.utc(2026, 11),
    );
    await cubit.open('github');
    expect(await cubit.restore(0), isFalse);
    expect(await cubit.delete(), isFalse);
    expect(world.sync.state.phase, SyncPhase.conflict);
    expect(item('github').history, hasLength(2));
    expect(cubit.state.gone, isFalse);
  });

  test('copy uses the field as given (an earlier version)', () async {
    await cubit.open('github');
    final Field old = item('github').history.first.fields[1];
    await cubit.copy(old, value: old.value);
    expect(world.clipboard.copied.last, 'old-password-16c');
  });
}
