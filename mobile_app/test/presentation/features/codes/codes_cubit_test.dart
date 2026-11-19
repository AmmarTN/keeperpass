import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/crypto/totp.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/presentation/features/codes/cubit/codes_cubit.dart';

import '../../../helpers/vault_world.dart';

void main() {
  final DateTime now = DateTime(2026, 10, 29, 9, 45, 6);
  late VaultWorld world;
  late CodesCubit cubit;

  Future<void> start({VaultSnapshot? snapshot}) async {
    world = VaultWorld(now: now, snapshot: snapshot ?? codesBoardsVault(now));
    await world.open();
    cubit = world.codesCubit();
  }

  tearDown(() async {
    await cubit.close();
    await world.close();
  });

  List<String> names() => <String>[
    for (final CodeEntry e in cubit.state.shown) e.row.item.name,
  ];

  test('one card per item with a setup key, A to Z (board Codes 01)', () async {
    await start();
    // "Server notes" has an empty 2FA field: nothing to make, no card.
    expect(names(), <String>['AWS Console', 'Cloudflare', 'GitHub']);
    final CodeEntry github = cubit.state.entries.last;
    expect(github.field.type, FieldType.totp);
    expect(github.row.vaultLabel, 'Work');
    expect(github.row.summary, 'janedoe-dev');
  });

  test('the search matches item names only, every word', () async {
    await start();
    cubit.setSearch('cloud');
    expect(cubit.state.searching, isTrue);
    expect(names(), <String>['Cloudflare']);

    // A username is not a name.
    cubit.setSearch('janedoe');
    expect(names(), isEmpty);

    cubit.setSearch('console aws');
    expect(names(), <String>['AWS Console']);

    cubit.setSearch('  ');
    expect(cubit.state.searching, isFalse);
    expect(names(), hasLength(3));
  });

  test('copy: the current code, and the item counts as used', () async {
    await start();
    expect(await cubit.copy('github'), isNotNull);
    expect(world.clipboard.copied, <String>[
      generateTotp(kTotpKey, timestampMs: now.millisecondsSinceEpoch),
    ]);
    expect(world.recent.ids, <String>['github']);
  });

  test('an invalid setup key copies nothing', () async {
    await start(snapshot: codesBoardsVault(now, invalidCloudflare: true));
    expect(names(), contains('Cloudflare'));
    expect(await cubit.copy('cloudflare'), isNull);
    expect(world.clipboard.copied, isEmpty);
    expect(world.recent.ids, isEmpty);
  });

  test(
    'follows the vault: a new key adds a card, locking empties it',
    () async {
      await start();
      final VaultSnapshot snapshot = world.vault.snapshot!;
      world.vault.update(
        snapshot.copyWith(
          items: <VaultItem>[
            for (final VaultItem item in snapshot.items)
              item.id == 'notes'
                  ? item.copyWith(
                      fields: <Field>[
                        Field.of(
                          name: 'Authenticator Code',
                          type: FieldType.totp,
                          value: 'JBSWY3DPEHPK3PXP',
                        ),
                      ],
                    )
                  : item,
          ],
        ),
      );
      await Future<void>.delayed(Duration.zero);
      expect(names(), <String>[
        'AWS Console',
        'Cloudflare',
        'GitHub',
        'Server notes',
      ]);

      world.vault.wipe();
      await Future<void>.delayed(Duration.zero);
      expect(cubit.state.entries, isEmpty);
    },
  );
}
