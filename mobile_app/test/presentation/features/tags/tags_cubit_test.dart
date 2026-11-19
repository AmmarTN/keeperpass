import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/core/utils/items/tag_changes.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/presentation/features/tags/cubit/tags_cubit.dart';

import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;
  late TagsCubit cubit;

  setUp(() async {
    world = VaultWorld();
    await world.open();
    cubit = world.tagsCubit();
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

  VaultItem item(String id) =>
      world.vault.snapshot!.items.firstWhere((VaultItem i) => i.id == id);

  test('every tag, most used first, with counts and a date', () {
    expect(
      <String>[
        for (final TagInfo t in cubit.state.tags) '${t.name} ${t.count}',
      ],
      <String>[
        'dev 4',
        'work 4',
        'social 2',
        'entertainment 1',
        'finance 1',
        'shopping 1',
      ],
    );
    // No registry date: the first item carrying it (web `VaultStore.tags`).
    expect(cubit.state.tags.first.created, isNotNull);
  });

  test('add: a tag with no items yet, saved', () async {
    expect(await cubit.add('travel'), isTrue);
    await settle();
    expect(cubit.state.has('travel'), isTrue);
    expect(cubit.state.tags.last.count, 0);
    expect(cubit.state.tags.last.created, world.now.toUtc());
    expect(world.sync.state.phase, SyncPhase.saved);
  });

  test('rename: on every item, each keeping its earlier version', () async {
    final int before = item('github').history.length;
    expect(await cubit.rename('dev', 'development'), isTrue);
    await settle();
    expect(item('github').tags, <String>['work', 'development']);
    expect(item('github').history.length, before + 1);
    expect(item('github').history.first.tags, <String>['work', 'dev']);
    expect(cubit.state.has('dev'), isFalse);
  });

  test(
    'delete several: gone from items and the registry; items stay',
    () async {
      cubit
        ..startSelecting()
        ..toggle('work')
        ..toggle('social');
      expect(await cubit.delete(cubit.state.selected.toList()), isTrue);
      await settle();
      expect(item('github').tags, <String>['dev']);
      expect(item('instagram').tags, isEmpty);
      expect(world.vault.snapshot!.items, hasLength(11));
      expect(cubit.state.selecting, isFalse);
      expect(cubit.state.has('work'), isFalse);
    },
  );

  test('Select all, then none', () {
    cubit
      ..startSelecting()
      ..toggleSelectAll();
    expect(cubit.state.selected, hasLength(6));
    cubit.toggleSelectAll();
    expect(cubit.state.selected, isEmpty);
  });

  test('the Vault list lets go of a tag that is gone', () async {
    world.list.toggleTag('shopping');
    expect(world.list.state.tag, 'shopping');
    await cubit.delete(<String>['shopping']);
    await settle();
    expect(world.list.state.tag, isNull);
  });
}
