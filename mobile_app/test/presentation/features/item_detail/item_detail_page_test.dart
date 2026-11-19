import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/enums/provider_id.dart';
import 'package:keeperpass/core/enums/sync_phase.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_file_info.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/features/edit_item/cubit/edit_item_cubit.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/edit_item_page.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/field_editor.dart';
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart';
import 'package:keeperpass/presentation/features/item_detail/pages/item_detail_page.dart';
import 'package:keeperpass/presentation/features/item_detail/pages/large_type_page.dart';
import 'package:keeperpass/presentation/features/item_detail/widgets/item_header.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';
import 'package:keeperpass/presentation/features/vault_list/widgets/vault_rows.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;
  late ItemDetailCubit cubit;
  final List<String> shownTags = <String>[];

  // The app's localizations load the date formats; here they load once.
  setUpAll(initializeDateFormatting);

  /// The item screen pushed over a plain page, as from the Vault list.
  Future<void> pumpItem(
    WidgetTester tester,
    String id, {
    Brightness brightness = Brightness.light,
    DateTime? now,
    VaultSnapshot Function(VaultSnapshot)? change,
  }) async {
    final DateTime clock = now ?? kItemBoardsNow;
    final VaultSnapshot boards = itemBoardsVault(kItemBoardsNow);
    world = VaultWorld(now: clock, snapshot: change?.call(boards) ?? boards);
    await tester.runAsync(world.open);
    cubit = world.itemCubit();
    await tester.runAsync(() => cubit.open(id));
    addTearDown(
      () => tester.runAsync(() async {
        await cubit.close();
        await world.close();
      }),
    );
    shownTags.clear();
    await pumpScreen(
      tester,
      Builder(
        builder: (BuildContext context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => BlocProvider<ItemDetailCubit>.value(
                    value: cubit,
                    child: ItemDetailScreen(
                      backLabel: 'All Vaults',
                      onShowTag: shownTags.add,
                    ),
                  ),
                ),
              ),
              child: const Text('open'),
            ),
          ),
        ),
      ),
      providers: world.providers,
      brightness: brightness,
    );
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
  }

  VaultItem item(String id) =>
      world.vault.snapshot!.items.firstWhere((VaultItem i) => i.id == id);

  Finder rich(String text) => find.text(text, findRichText: true);

  /// The copy tick, toasts and saves run on timers.
  Future<void> drain(WidgetTester tester) async {
    // Toasts, and a secret's 30 s on the clipboard.
    await tester.pump(const Duration(seconds: 31));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
  }

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S3-19 GitHub: header, fields, history (${brightness.name})', (
      WidgetTester tester,
    ) async {
      await pumpItem(tester, 'github', brightness: brightness);

      expect(find.text('All Vaults'), findsOneWidget);
      expect(find.bySemanticsLabel('Remove from favorites'), findsOneWidget);
      expect(find.text('Edit'), findsOneWidget);
      expect(find.bySemanticsLabel('More options'), findsOneWidget);
      expect(find.text('GitHub'), findsWidgets);
      expect(find.text('Work'), findsOneWidget);
      expect(find.text('Updated 4 minutes ago'), findsOneWidget);
      expect(find.text('work'), findsOneWidget);
      expect(find.text('dev'), findsOneWidget);
      expect(find.text('FIELDS'), findsOneWidget);
      expect(find.text('janedoe-dev'), findsOneWidget);
      expect(
        find.bySemanticsLabel(RegExp(r'Password, hidden')),
        findsOneWidget,
      );
      expect(find.text('Very strong'), findsOneWidget);
      expect(find.bySemanticsLabel('Open github.com'), findsOneWidget);
      expect(find.textContaining(RegExp(r'^\d{3} \d{3}$')), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp(r'30 seconds left')), findsOneWidget);
      expect(find.text('HISTORY'), findsOneWidget);
      expect(find.text('Today, 9:41 AM · 4 minutes ago'), findsOneWidget);
      expect(find.text('Current Version'), findsOneWidget);
      expect(find.text('Oct 21, 2026, 6:54 PM · last week'), findsOneWidget);
      expect(find.text('Aug 23, 2026, 6:54 PM · 2 months ago'), findsOneWidget);
      // The key never appears in view mode (board S3-23).
      expect(find.textContaining(kTotpKey), findsNothing);
      expect(
        tester
            .state<AppToastHostState>(find.byType(AppToastHost))
            .coveringTabBar
            .value,
        1,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('S3-20 revealed and copied: Space Mono, "Copied" for 1 s, '
      'the toast', (WidgetTester tester) async {
    await pumpItem(tester, 'github');

    await tester.tap(find.bySemanticsLabel('Reveal value'));
    await tester.pump();
    expect(rich(kGitHubPassword), findsOneWidget);
    expect(find.bySemanticsLabel('Hide value'), findsOneWidget);
    expect(find.text('Show in large type'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Copy Password'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(world.clipboard.copied, <String>[kGitHubPassword]);
    expect(find.text('Copied'), findsOneWidget);
    expect(find.text('Password copied'), findsOneWidget);
    expect(find.text('From GitHub · Clears in 30 s'), findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('Copied'), findsNothing);
    await drain(tester);
  });

  testWidgets('S3-21 large type: every character numbered; it turns sideways '
      'into one line', (WidgetTester tester) async {
    await pumpItem(tester, 'github');
    await tester.tap(find.bySemanticsLabel('Reveal value'));
    await tester.pump();
    await tester.tap(find.text('Show in large type'));
    await tester.pumpAndSettle();

    expect(find.byType(LargeTypePage), findsOneWidget);
    expect(
      find.bySemanticsLabel('Password shown in large type, 20 characters'),
      findsOneWidget,
    );
    expect(find.text('20'), findsOneWidget);
    expect(find.text('#'), findsOneWidget);
    expect(
      find.text(
        'Turn your phone sideways to read it in one line.\n'
        'It hides again when you leave this screen.',
      ),
      findsOneWidget,
    );
    final double rowOf1 = tester.getTopLeft(find.text('1')).dy;
    expect(tester.getTopLeft(find.text('6')).dy, greaterThan(rowOf1));

    // Sideways: one line, and nothing beneath it overflows.
    tester.view.physicalSize = const Size(852, 393);
    tester.view.padding = const FakeViewPadding(left: 59, right: 59);
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(find.text('20')).dy, rowOf1Sideways(tester));
    expect(tester.takeException(), isNull);

    tester.view.physicalSize = const Size(393, 852);
    tester.view.padding = const FakeViewPadding(top: 59, bottom: 34);
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('Close'));
    await tester.pumpAndSettle();
    expect(find.byType(LargeTypePage), findsNothing);
  });

  testWidgets('S3-22 the code\'s last seconds: amber and counted', (
    WidgetTester tester,
  ) async {
    await pumpItem(
      tester,
      'github',
      now: kItemBoardsNow.add(const Duration(seconds: 26)),
    );
    expect(find.text('4 s'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp(r'4 seconds left')), findsOneWidget);
  });

  testWidgets('S3-23 an invalid setup key says so, with the way to fix it', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'bad-key');
    expect(find.text('Invalid code'), findsOneWidget);
    expect(
      find.text('The setup key isn’t valid, so no code can be made.'),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel('Copy code'), findsNothing);

    getIt.registerFactory<EditItemCubit>(world.editCubit);
    addTearDown(() => getIt.unregister<EditItemCubit>());
    await tester.tap(find.text('Fix it in Edit'));
    await tester.pumpAndSettle();
    expect(find.byType(EditItemScreen), findsOneWidget);
    expect(find.text('Edit Item'), findsOneWidget);
    // Edit opens on the 2FA field, drawn focused (your answer, Part 10).
    final List<FieldEditor> fields = tester
        .widgetList<FieldEditor>(find.byType(FieldEditor))
        .toList();
    expect(
      fields.map((FieldEditor f) => (f.field.type, f.highlighted)),
      <(FieldType, bool)>[(FieldType.ipHost, false), (FieldType.totp, true)],
    );
  });

  testWidgets('S3-24 more: Move to vault… moves it and says so', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'github');
    await tester.tap(find.bySemanticsLabel('More options'));
    await tester.pumpAndSettle();
    expect(find.text('Move to vault…'), findsOneWidget);
    expect(find.text('Delete item'), findsOneWidget);

    await tester.tap(find.text('Move to vault…'));
    await tester.pumpAndSettle();
    expect(find.text('Move to Vault'), findsOneWidget);
    await tester.tap(find.text('My Vault'));
    await tester.pumpAndSettle();
    expect(item('github').vaultId, kPersonalVaultId);
    expect(find.text('Moved GitHub to My Vault'), findsOneWidget);
    expect(find.text('My Vault'), findsOneWidget);
    await drain(tester);
  });

  testWidgets('S3-25 / S3-26 an earlier version, in full; Restore confirms '
      'and brings it back', (WidgetTester tester) async {
    await pumpItem(tester, 'github');
    await tester.scrollUntilVisible(
      find.text('Oct 21, 2026, 6:54 PM · last week'),
      200,
    );
    await tester.tap(find.text('Oct 21, 2026, 6:54 PM · last week'));
    await tester.pumpAndSettle();

    expect(find.text('Earlier Version'), findsOneWidget);
    expect(find.text('Oct 21, 2026, 6:54 PM'), findsOneWidget);
    expect(find.text('last week · read-only'), findsOneWidget);
    expect(rich('old-password-16c'), findsOneWidget);
    expect(find.text('Changed since'), findsOneWidget);
    expect(find.bySemanticsLabel('Reveal value'), findsNothing);
    expect(find.bySemanticsLabel('Open github.com'), findsNothing);

    await tester.tap(find.text('Restore this version'));
    await tester.pumpAndSettle();
    expect(find.text('Restore this version?'), findsOneWidget);
    expect(
      find.text(
        'GitHub goes back to how it was on Oct 21, 2026. The current version '
        'stays in its history.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Restore'));
    await tester.pumpAndSettle();

    expect(find.text('Earlier Version'), findsNothing);
    expect(item('github').fields[1].value, 'old-password-16c');
    expect(item('github').history, hasLength(3));
    expect(find.text('Updated now'), findsOneWidget);
    await drain(tester);
    expect(world.storage.calls, contains('save:google'));
  });

  testWidgets('Delete version confirms in red and removes only that one', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'github');
    await tester.scrollUntilVisible(
      find.text('Aug 23, 2026, 6:54 PM · 2 months ago'),
      200,
    );
    await tester.tap(find.text('Aug 23, 2026, 6:54 PM · 2 months ago'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete version'));
    await tester.pumpAndSettle();
    expect(find.text('Delete This Version'), findsOneWidget);
    expect(
      find.text(
        'Are you sure you want to delete this version from the history? This '
        'cannot be undone.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(item('github').history, hasLength(1));
    expect(find.text('Aug 23, 2026, 6:54 PM · 2 months ago'), findsNothing);
    await drain(tester);
  });

  testWidgets('S3-27 Delete item: the brief\'s words, one red button; back to '
      'the list', (WidgetTester tester) async {
    await pumpItem(tester, 'github');
    await tester.tap(find.bySemanticsLabel('More options'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete item'));
    await tester.pumpAndSettle();
    expect(find.text('Delete Item'), findsOneWidget);
    expect(
      find.text(
        'Are you sure you want to delete ‘GitHub’? This cannot be undone.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Delete item'));
    await tester.pumpAndSettle();

    expect(find.byType(ItemDetailScreen), findsNothing);
    expect(find.text('This item no longer exists.'), findsNothing);
    expect(
      world.vault.snapshot!.items.any((VaultItem i) => i.id == 'github'),
      isFalse,
    );
    await drain(tester);
  });

  testWidgets('S3-28 gone: deleted elsewhere, the way back', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'github');
    final VaultSnapshot snapshot = world.vault.snapshot!;
    world.vault.update(
      snapshot.copyWith(
        items: snapshot.items.where((VaultItem i) => i.id != 'github').toList(),
      ),
    );
    // A state from outside arrives a microtask later.
    await tester.pump();
    await tester.pump();
    expect(find.text('This item no longer exists.'), findsOneWidget);
    expect(
      find.text('It may have been deleted from another device.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Back to vault'));
    await tester.pumpAndSettle();
    expect(find.byType(ItemDetailScreen), findsNothing);
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S3-29 Visa: the card face, masked in fours '
        '(${brightness.name})', (WidgetTester tester) async {
      await pumpItem(tester, 'visa', brightness: brightness);
      expect(
        find.bySemanticsLabel('Visa card, number hidden, expires August 2029'),
        findsOneWidget,
      );
      expect(
        find.bySemanticsLabel(RegExp(r'Card Number, hidden')),
        findsOneWidget,
      );
      expect(find.text('Visa'), findsWidgets);
      // The network's real logo at the top left (your answers,
      // 2026-11-05), its white-letter version on the dark card.
      final SvgPicture logo = tester.widget<SvgPicture>(
        find.descendant(
          of: find.byType(ItemCardFace),
          matching: find.byType(SvgPicture),
        ),
      );
      expect(
        (logo.bytesLoader as SvgAssetLoader).assetName,
        brightness == Brightness.dark
            ? 'assets/card_networks/visa-dark.svg'
            : 'assets/card_networks/visa.svg',
      );
      final Rect card = tester.getRect(find.byType(ItemCardFace));
      final Rect drawn = tester.getRect(
        find.descendant(
          of: find.byType(ItemCardFace),
          matching: find.byType(SvgPicture),
        ),
      );
      expect(drawn.left - card.left, lessThan(card.width / 4));
      expect(drawn.top - card.top, lessThan(card.height / 4));
      expect(find.text('Jane Doe'), findsOneWidget);
      expect(find.text('08/2029'), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp(r'CVC, hidden')), findsOneWidget);
      expect(find.bySemanticsLabel(RegExp(r'PIN, hidden')), findsOneWidget);
      expect(find.text('HISTORY'), findsNothing);
      expect(tester.takeException(), isNull);
    });
  }

  Finder cardOwnIcon() => find.descendant(
    of: find.byType(ItemCardFace),
    matching: find.byType(VaultItemTile),
  );

  testWidgets('a card without an icon of its own shows the card symbol', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'visa');
    expect(cardOwnIcon(), findsNothing);
  });

  testWidgets('a card with a website shows its icon at the top right, as the '
      'list does (your answer, 2026-11-05)', (WidgetTester tester) async {
    await pumpItem(
      tester,
      'visa',
      change: (VaultSnapshot vault) => vault.copyWith(
        items: <VaultItem>[
          for (final VaultItem item in vault.items)
            item.id == 'visa'
                ? item.copyWith(
                    fields: <Field>[
                      ...item.fields,
                      Field.of(
                        name: 'Website',
                        type: FieldType.url,
                        value: 'binance.com',
                      ),
                    ],
                  )
                : item,
        ],
      ),
    );
    expect(cardOwnIcon(), findsOneWidget);
    expect(
      tester.getRect(cardOwnIcon()).right,
      greaterThan(tester.getRect(find.byType(ItemCardFace)).center.dx),
    );
  });

  testWidgets('tapping Edit again while it checks opens one Edit '
      '(2026-11-05)', (WidgetTester tester) async {
    await pumpItem(tester, 'visa');
    getIt.registerFactory<EditItemCubit>(world.editCubit);
    addTearDown(() => getIt.unregister<EditItemCubit>());
    world.storage.holdNewer = Completer<void>();
    await tester.tap(find.text('Edit'));
    await tester.pump();
    await tester.tap(find.text('Edit'));
    await tester.pump();
    world.storage.holdNewer!.complete();
    await tester.pumpAndSettle();
    expect(find.byType(EditItemScreen, skipOffstage: false), findsOneWidget);
    expect(
      world.storage.calls.where((String c) => c == 'newer:google'),
      hasLength(1),
    );
  });

  testWidgets('Edit opens at once while the check runs; a newer version '
      'then asks "Your Vault Changed" over it (your answer, 2026-11-05)', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'visa');
    getIt.registerFactory<EditItemCubit>(world.editCubit);
    addTearDown(() => getIt.unregister<EditItemCubit>());
    world.storage.holdNewer = Completer<void>();
    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    expect(find.byType(EditItemScreen), findsOneWidget);
    expect(world.sync.state.conflictPrompts, 0);

    world.storage.newer[ProviderId.google] = VaultFileInfo(
      modifiedAt: kItemBoardsNow,
    );
    world.storage.holdNewer!.complete();
    await tester.pump();
    expect(world.sync.state.phase, SyncPhase.conflict);
    expect(world.sync.state.conflictPrompts, 1);
  });

  testWidgets('a newer version already known: Edit asks first and stays '
      'closed', (WidgetTester tester) async {
    await pumpItem(tester, 'visa');
    getIt.registerFactory<EditItemCubit>(world.editCubit);
    addTearDown(() => getIt.unregister<EditItemCubit>());
    world.storage.newer[ProviderId.google] = VaultFileInfo(
      modifiedAt: kItemBoardsNow,
    );
    await tester.runAsync(world.sync.checkBeforeEditing);
    expect(world.sync.state.conflictPrompts, 1);

    await tester.tap(find.text('Edit'));
    await tester.pumpAndSettle();
    expect(find.byType(EditItemScreen), findsNothing);
    expect(world.sync.state.conflictPrompts, 2);
  });

  testWidgets('a card number that fails its checksum says so', (
    WidgetTester tester,
  ) async {
    await pumpItem(
      tester,
      'visa',
      change: (VaultSnapshot s) => s.copyWith(
        items: <VaultItem>[
          for (final VaultItem i in s.items)
            i.id == 'visa'
                ? i.copyWith(
                    fields: <Field>[
                      i.fields.first.copyWith(value: '4111111111111112'),
                      ...i.fields.skip(1),
                    ],
                  )
                : i,
        ],
      ),
    );
    expect(
      find.text(
        'That number fails its checksum — one of the digits is probably '
        'wrong.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('S3-30 Savings Account: the IBAN in fours, copied without '
      'spaces', (WidgetTester tester) async {
    await pumpItem(tester, 'savings');
    expect(find.text('DE89 3704 0044 0532 0130 00'), findsOneWidget);
    expect(find.text('COBADEFFXXX'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Copy IBAN'));
    await tester.pump();
    expect(world.clipboard.copied, <String>['DE89370400440532013000']);
    await drain(tester);
  });

  testWidgets('S3-31 Home Wi-Fi: two fields, nothing else', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'wifi');
    expect(find.text('Doe-Home-5G'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp(r'Password, hidden')), findsOneWidget);
    expect(find.text('HISTORY'), findsNothing);
  });

  testWidgets('S3-32 Passport: dates as "Apr 12, 1992", the country\'s flag', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'passport');
    expect(find.text('561942718'), findsOneWidget);
    expect(find.text('United States'), findsOneWidget);
    expect(find.text('🇺🇸'), findsOneWidget);
    expect(find.text('Apr 12, 1992'), findsOneWidget);
    expect(find.text('Jun 3, 2021'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Jun 2, 2031'), 200);
    expect(find.text('Jun 2, 2031'), findsOneWidget);
    expect(find.text('Portland, Oregon'), findsOneWidget);
  });

  testWidgets('S3-33 a note as typed (your answer: plain text)', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'router');
    expect(
      find.text('# Guest network\n- The router is in the hallway cupboard'),
      findsOneWidget,
    );
  });

  testWidgets('S3-34 GitLab: keys masked line for line; recovery codes copy '
      'one at a time or all', (WidgetTester tester) async {
    await pumpItem(tester, 'gitlab');
    expect(
      find.bySemanticsLabel(RegExp(r'SSH / Private Key, hidden, 3 lines')),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel(RegExp(r'Recovery Codes, hidden, 4 lines')),
      findsOneWidget,
    );
    await tester.tap(find.bySemanticsLabel('Reveal value').last);
    await tester.pump();
    expect(find.bySemanticsLabel('Copy code 3'), findsOneWidget);
    expect(find.bySemanticsLabel('Copy code 4'), findsNothing);
    await tester.tap(find.bySemanticsLabel('Copy code 2'));
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Copy all codes'));
    await tester.pump();
    expect(world.clipboard.copied, <String>[
      'm4xz-p8r2',
      '7fq2-9kd1\nm4xz-p8r2\n\nq9w3-ht6v',
    ]);
    await drain(tester);
  });

  testWidgets('S3-35 Apple: the phone calls or messages; empty says so', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'apple');
    expect(find.text('+1 503-555-0142'), findsOneWidget);
    expect(find.text('🇺🇸'), findsOneWidget);
    expect(find.text('Apr 12, 1992'), findsOneWidget);
    expect(find.text('[empty]'), findsOneWidget);
    expect(find.bySemanticsLabel('Copy Recovery Email'), findsNothing);
    await tester.tap(find.bySemanticsLabel('Call'));
    await tester.tap(find.bySemanticsLabel('Message'));
    await tester.pump();
    expect(world.links.opened.map((Uri u) => '$u'), <String>[
      'tel:+15035550142',
      'sms:+15035550142',
    ]);
  });

  testWidgets('S3-36 AWS Console: the live code first, as a card that copies', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'aws');
    expect(find.text('Tap to copy · also on the Codes tab'), findsOneWidget);
    await tester.tap(find.text('Tap to copy · also on the Codes tab'));
    await tester.pump();
    expect(world.clipboard.copied.single, matches(RegExp(r'^\d{6}$')));
    expect(find.text('Copied'), findsOneWidget);
    await drain(tester);
  });

  testWidgets('a tag goes back to the list, filtered by it', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'github');
    await tester.tap(find.text('dev'));
    await tester.pumpAndSettle();
    expect(shownTags, <String>['dev']);
    expect(find.byType(ItemDetailScreen), findsNothing);
  });

  testWidgets('the star toggles the favorite; the name moves into the bar', (
    WidgetTester tester,
  ) async {
    await pumpItem(tester, 'github');
    await tester.tap(find.bySemanticsLabel('Remove from favorites'));
    await tester.pumpAndSettle();
    expect(find.bySemanticsLabel('Add to favorites'), findsOneWidget);
    expect(world.vault.snapshot!.favouriteIds, isNot(contains('github')));

    Opacity barTitle() => tester.widget<Opacity>(
      find.ancestor(
        of: find.text('GitHub').last,
        matching: find.byType(Opacity),
      ),
    );
    expect(barTitle().opacity, 0);
    await tester.drag(find.text('FIELDS'), const Offset(0, -300));
    await tester.pumpAndSettle();
    expect(barTitle().opacity, greaterThan(0));
    await drain(tester);
  });

  testWidgets('from the Vault list: a row opens the item over the tab bar, '
      'back to the list\'s title', (WidgetTester tester) async {
    world = VaultWorld(
      now: kItemBoardsNow,
      snapshot: itemBoardsVault(kItemBoardsNow),
    );
    await tester.runAsync(world.open);
    getIt.registerFactory<ItemDetailCubit>(world.itemCubit);
    addTearDown(() async {
      await getIt.unregister<ItemDetailCubit>();
      await tester.runAsync(world.close);
    });
    await pumpScreen(
      tester,
      const VaultListScreen(),
      providers: world.providers,
    );

    await tester.tap(find.text('GitHub').last);
    await tester.pumpAndSettle();
    expect(find.byType(ItemDetailScreen), findsOneWidget);
    expect(find.text('Updated 4 minutes ago'), findsOneWidget);
    expect(world.recent.ids, <String>['github']);

    await tester.tap(find.text('All Vaults').last);
    await tester.pumpAndSettle();
    expect(find.byType(ItemDetailScreen), findsNothing);
  });
}

/// In landscape every cell sits on the first row.
double rowOf1Sideways(WidgetTester tester) =>
    tester.getTopLeft(find.text('1')).dy;
