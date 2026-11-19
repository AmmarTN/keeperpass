import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/enums/audit_type.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/erros/failures.dart';
import 'package:keeperpass/core/erros/network_failure.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/widgets/cards/app_report_cards.dart';
import 'package:keeperpass/presentation/features/edit_item/cubit/edit_item_cubit.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/edit_item_page.dart';
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart';
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart';
import 'package:keeperpass/presentation/features/item_detail/pages/item_detail_page.dart';
import 'package:keeperpass/presentation/features/security/cubit/security_cubit.dart';
import 'package:keeperpass/presentation/features/security/pages/security_page.dart';
import 'package:keeperpass/presentation/features/vault_list/pages/vault_list_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  /// The check ran at 9:41; the boards look at 9:45 (`S4-13`).
  final DateTime checkedAt = DateTime(2026, 11, 1, 9, 41);
  final DateTime boardsNow = DateTime(2026, 11, 1, 9, 45);
  late VaultWorld world;

  setUpAll(initializeDateFormatting);

  Future<void> pumpSecurity(
    WidgetTester tester, {
    VaultSnapshot? snapshot,
    Brightness brightness = Brightness.light,
  }) async {
    world = VaultWorld(
      now: checkedAt,
      snapshot: snapshot ?? securityBoardsVault(checkedAt),
    );
    world.breaches.compromised.add(kBreachedPassword);
    await tester.runAsync(world.open);
    getIt
      ..registerFactory<ItemDetailCubit>(world.itemCubit)
      ..registerFactory<EditItemCubit>(world.editCubit)
      ..registerFactory<GeneratorCubit>(world.generatorCubit);
    addTearDown(() async {
      await getIt.unregister<ItemDetailCubit>();
      await getIt.unregister<EditItemCubit>();
      await getIt.unregister<GeneratorCubit>();
      await tester.runAsync(world.close);
    });
    await pumpScreen(
      tester,
      BlocProvider<SecurityCubit>(
        create: (_) => world.securityCubit(at: boardsNow),
        child: const SecurityScreen(),
      ),
      providers: world.providers,
      brightness: brightness,
    );
    await tester.pump();
    // The health bar's fill.
    await tester.pump(const Duration(milliseconds: 600));
  }

  /// Every password made unique and strong; [keep] keeps some as they are.
  VaultSnapshot cleaned({Set<String> keep = const <String>{}}) {
    final VaultSnapshot boards = securityBoardsVault(checkedAt);
    return boards.copyWith(
      items: <VaultItem>[
        for (final VaultItem item in boards.items)
          keep.contains(item.id)
              ? item
              : item.copyWith(
                  fields: <Field>[
                    for (final Field f in item.fields)
                      f.type == FieldType.password
                          ? f.copyWith(
                              value: '${item.id}-${f.name}-unique-phrase-9',
                            )
                          : f,
                  ],
                ),
      ],
    );
  }

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S4-13 Report (${brightness.name}): health, the three tiles, '
        'a card per kind with its items, the trust line', (
      WidgetTester tester,
    ) async {
      await pumpSecurity(tester, brightness: brightness);

      expect(find.text('Security Report'), findsWidgets);
      expect(
        find.text('How well your saved passwords hold up'),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel('Check again'), findsOneWidget);
      expect(find.text('Vault health'), findsOneWidget);
      expect(find.text('Needs work'), findsOneWidget);
      expect(find.text('75'), findsOneWidget);
      expect(find.text('16 items with a password checked'), findsOneWidget);
      expect(find.bySemanticsLabel('Vault health 75 percent'), findsOneWidget);
      expect(find.bySemanticsLabel('Weak: 2'), findsOneWidget);
      expect(find.bySemanticsLabel('Reused: 3'), findsOneWidget);
      expect(find.bySemanticsLabel('Compromised: 1'), findsOneWidget);

      expect(find.text('Weak Passwords'), findsOneWidget);
      expect(find.text('My Vault'), findsNWidgets(2));
      expect(find.text('Show all 2'), findsOneWidget);
      expect(find.text('Reused Passwords'), findsOneWidget);
      expect(find.text('Same as Instagram and Facebook'), findsOneWidget);
      expect(find.text('Same as Netflix and Facebook'), findsOneWidget);
      expect(find.text('Same as Netflix and Instagram'), findsOneWidget);
      expect(find.text('Show all 3'), findsOneWidget);
      expect(find.text('Compromised Passwords'), findsOneWidget);
      expect(find.text('Found in a known breach'), findsOneWidget);
      expect(find.text('Show all 1'), findsOneWidget);
      // Items in vault order (web `itemsWithFinding`).
      final List<String> names = tester
          .widgetList<AppFindingRow>(find.byType(AppFindingRow))
          .map((AppFindingRow r) => r.name)
          .toList();
      expect(names, <String>[
        'Netflix',
        'Spotify',
        'Netflix',
        'Instagram',
        'Facebook',
        'Facebook',
      ]);

      await tester.scrollUntilVisible(
        find.text('Last checked today at 9:41 AM'),
        200,
      );
      expect(
        find.text(
          'Breach checks use Have I Been Pwned with k-anonymity: only the '
          'first 5 characters of a SHA-1 hash ever leave this phone.',
        ),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a tile jumps to its card', (WidgetTester tester) async {
    await pumpSecurity(tester);
    final Finder breach = find.text('Found in a known breach');
    expect(tester.getTopLeft(breach).dy, greaterThan(852));
    await tester.tap(find.bySemanticsLabel('Compromised: 1'));
    await tester.pumpAndSettle();
    // The last card: the page scrolls as far as it goes.
    expect(tester.getTopLeft(breach).dy, lessThan(852));
  });

  testWidgets('S4-14 Why it matters: the web’s words, three steps, Show all '
      'to the Vault list filtered', (WidgetTester tester) async {
    await pumpSecurity(tester);
    await tester.tap(find.bySemanticsLabel('About Reused Passwords'));
    await tester.pumpAndSettle();

    expect(find.text('Reused Passwords'), findsNWidgets(2));
    expect(find.text('3 items flagged'), findsOneWidget);
    expect(
      find.textContaining(
        'One password used in several places means a '
        'single breach anywhere unlocks all of them',
      ),
      findsOneWidget,
    );
    expect(find.text('HOW TO FIX IT'), findsOneWidget);
    expect(find.text('Open the item'), findsOneWidget);
    expect(
      find.text('Tap Edit, then Generate on the password'),
      findsOneWidget,
    );
    expect(find.text('Save — the finding clears by itself'), findsOneWidget);

    // The sheet's button, over the card's footer.
    await tester.tap(find.text('Show all 3').last);
    await tester.pumpAndSettle();
    expect(find.text('3 items flagged'), findsNothing);
    expect(world.bottomNav.state.selectedIndex, 0);
    expect(world.list.state.report, AuditType.reusedPassword);
  });

  testWidgets('a compromised password is also changed on its site', (
    WidgetTester tester,
  ) async {
    await pumpSecurity(tester);
    await tester.tap(find.bySemanticsLabel('Compromised: 1'));
    await tester.pumpAndSettle();
    await tester.tap(find.bySemanticsLabel('About Compromised Passwords'));
    await tester.pumpAndSettle();
    expect(find.text('1 item flagged'), findsOneWidget);
    expect(find.text('Save, then change it on the site too'), findsOneWidget);
    expect(find.text('Save — the finding clears by itself'), findsNothing);
  });

  testWidgets('a card’s Show all opens the Vault list on that finding', (
    WidgetTester tester,
  ) async {
    await pumpSecurity(tester);
    await tester.tap(find.text('Show all 2'));
    await tester.pump();
    expect(world.bottomNav.state.selectedIndex, 0);
    expect(world.list.state.report, AuditType.weakPassword);
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S4-15 Checking (${brightness.name}): the first check of the '
        'session — everything waits, the bar and a row show how far', (
      WidgetTester tester,
    ) async {
      await pumpSecurity(tester, brightness: brightness);
      world.audit.clear();
      world.breaches.gate = Completer<void>();
      unawaited(world.audit.runFullAudit());
      await tester.pump();
      await tester.pump();

      expect(find.text('%'), findsNothing);
      expect(find.text('Needs work'), findsNothing);
      for (final String kind in <String>['Weak', 'Reused', 'Compromised']) {
        expect(find.bySemanticsLabel('$kind: not checked yet'), findsOneWidget);
      }
      expect(find.text('Checking for breaches · 0 of 16'), findsOneWidget);
      expect(find.text('Checking 16 passwords'), findsOneWidget);
      expect(find.text('0 of 16'), findsOneWidget);
      expect(find.textContaining('Last checked'), findsNothing);

      world.breaches.gate!.complete();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(find.text('75'), findsOneWidget);
      expect(find.text('Checking 16 passwords'), findsNothing);
    });
  }

  testWidgets('Check again keeps the findings shown; “Last checked” reads '
      '“Checking…” meanwhile', (WidgetTester tester) async {
    await pumpSecurity(tester);
    world.breaches.gate = Completer<void>();
    await tester.tap(find.bySemanticsLabel('Check again'));
    await tester.pump();
    expect(find.text('75'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Checking…'), 200);
    expect(find.text('Checking…'), findsOneWidget);

    world.breaches.gate!.complete();
    await tester.pump();
    await tester.pump();
    expect(find.text('Last checked today at 9:41 AM'), findsOneWidget);
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S4-16 All clear (${brightness.name}): 100 %, Strong, and the '
        'web’s “No problems found”', (WidgetTester tester) async {
      await pumpSecurity(tester, snapshot: cleaned(), brightness: brightness);

      expect(find.text('100'), findsOneWidget);
      expect(find.text('Strong'), findsOneWidget);
      expect(find.bySemanticsLabel('Weak: 0'), findsOneWidget);
      expect(find.bySemanticsLabel('Reused: 0'), findsOneWidget);
      expect(find.bySemanticsLabel('Compromised: 0'), findsOneWidget);
      expect(find.text('No problems found'), findsOneWidget);
      expect(
        find.text('Every password in your vaults passed the last audit.'),
        findsOneWidget,
      );
      expect(find.byType(AppFindingCard), findsNothing);
      expect(world.audit.state.flaggedCount, 0);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('a kind with nothing found keeps its card, with the web’s '
      'sentence (your answer, Part 11)', (WidgetTester tester) async {
    await pumpSecurity(tester, snapshot: cleaned(keep: <String>{'spotify'}));
    expect(find.bySemanticsLabel('Weak: 1'), findsOneWidget);
    expect(find.text('Show all 1'), findsOneWidget);
    expect(
      find.text('Every password in your vault is used exactly once.'),
      findsOneWidget,
    );
    await tester.scrollUntilVisible(
      find.text('None of your passwords turned up in a known breach.'),
      200,
    );
    expect(find.byType(AppFindingCard), findsNWidgets(3));
  });

  testWidgets('S4-17 Offline before any result: the banner and Try again, '
      'nothing else (your answer, Part 11)', (WidgetTester tester) async {
    await pumpSecurity(tester);
    world.network.connected = false;
    await world.connectivity.recheck();
    await tester.pump(Duration.zero);
    world.audit.clear();
    world.breachesOffline();
    await world.audit.runFullAudit();
    await tester.pump();
    await tester.pump();

    expect(find.text('You’re offline'), findsOneWidget);
    expect(
      find.text(
        'Your passwords could not be checked. The check needs a connection.',
      ),
      findsOneWidget,
    );
    expect(find.text('%'), findsNothing);
    expect(find.byType(AppStatTile), findsNothing);

    world.network.connected = true;
    await world.connectivity.recheck();
    await tester.pump(Duration.zero);
    world.breaches.failure = null;
    await tester.tap(find.text('Try again'));
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    expect(find.text('You’re offline'), findsNothing);
    expect(find.text('75'), findsOneWidget);
  });

  testWidgets('a failed check keeps the last findings under the banner; '
      'online, it says the check could not finish', (
    WidgetTester tester,
  ) async {
    await pumpSecurity(tester);
    world.breaches.failure = const Failure.networkFailure(
      NetworkFailure.defaultError('Breach lookup failed with status 429'),
    );
    await tester.tap(find.bySemanticsLabel('Check again'));
    await tester.pump();
    await tester.pump();

    expect(find.text('The check could not finish'), findsOneWidget);
    expect(find.text('Try again in a moment.'), findsOneWidget);
    expect(find.text('75'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Last checked today at 9:41 AM'),
      200,
    );
  });

  testWidgets('S4-18 Nothing to check yet: what will be checked, and where; '
      'New item', (WidgetTester tester) async {
    final VaultSnapshot boards = securityBoardsVault(checkedAt);
    await pumpSecurity(
      tester,
      snapshot: boards.copyWith(
        items: <VaultItem>[
          for (final VaultItem item in boards.items)
            if (!item.fields.any((Field f) => f.type == FieldType.password))
              item,
        ],
      ),
    );
    expect(find.text('Nothing to check yet'), findsOneWidget);
    expect(
      find.text(
        'Save an item with a password and it is checked here, on this '
        'phone, for weak, reused and breached passwords.',
      ),
      findsOneWidget,
    );
    expect(find.text('%'), findsNothing);
    await tester.tap(find.text('New item'));
    await tester.pumpAndSettle();
    expect(find.text('New Vault Item'), findsOneWidget);
  });

  group('fixing a finding', () {
    Future<void> useGenerated(WidgetTester tester) async {
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Use this password'));
      await tester.pumpAndSettle();
    }

    Future<void> saveAndLand(WidgetTester tester) async {
      await tester.tap(find.text('Save'));
      await tester.pump();
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pumpAndSettle();
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 50)),
      );
      await tester.pump();
    }

    testWidgets('S4-20 → S4-22: the item says what is wrong; Change password '
        'opens Edit with Generate up; Save lands on the report updated', (
      WidgetTester tester,
    ) async {
      await pumpSecurity(tester);
      await tester.tap(find.text('Spotify'));
      await tester.pumpAndSettle();

      // S4-20: the item, back to the report.
      expect(find.byType(ItemDetailScreen), findsOneWidget);
      expect(find.text('Security Report'), findsWidgets);
      expect(find.text('Weak password'), findsOneWidget);
      expect(
        find.textContaining('A password is weak when the space an attacker'),
        findsOneWidget,
      );
      await tester.tap(find.text('Change password'));
      await tester.pumpAndSettle();

      // S4-21: Edit with the Generate sheet already up.
      expect(find.byType(EditItemScreen), findsOneWidget);
      expect(find.text('Generate a password'), findsOneWidget);
      await useGenerated(tester);
      expect(find.text('No longer weak'), findsOneWidget);
      expect(find.text('Very strong'), findsOneWidget);

      // S4-22: back on the report, updated, with the toast.
      await saveAndLand(tester);
      expect(find.byType(EditItemScreen), findsNothing);
      expect(find.byType(ItemDetailScreen), findsNothing);
      expect(find.text('Saved · Spotify is no longer flagged'), findsOneWidget);
      expect(find.text('Your vault was saved to Google Drive'), findsOneWidget);
      expect(find.text('81'), findsOneWidget);
      expect(find.bySemanticsLabel('Weak: 1'), findsOneWidget);
      expect(world.audit.state.flaggedCount, 3);
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('a fix that leaves something says the item is still flagged', (
      WidgetTester tester,
    ) async {
      await pumpSecurity(tester);
      await tester.tap(find.text('Netflix').first);
      await tester.pumpAndSettle();
      // Its weak password is fixed; the shared one stays.
      expect(find.text('Weak and reused password'), findsOneWidget);
      await tester.tap(find.text('Change password'));
      await tester.pumpAndSettle();
      await useGenerated(tester);
      expect(find.text('No longer weak'), findsOneWidget);

      await saveAndLand(tester);
      expect(find.text('Saved · Netflix is still flagged'), findsOneWidget);
      expect(find.bySemanticsLabel('Weak: 1'), findsOneWidget);
      expect(find.bySemanticsLabel('Reused: 3'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
    });

    testWidgets('Cancel in Edit changes nothing and stays on the item', (
      WidgetTester tester,
    ) async {
      await pumpSecurity(tester);
      await tester.tap(find.text('Spotify'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Change password'));
      await tester.pumpAndSettle();
      // The Generate sheet is up: close it, then Cancel (nothing changed).
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pumpAndSettle();
      await tester.tap(find.bySemanticsLabel('Close'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(find.byType(EditItemScreen), findsNothing);
      expect(find.byType(ItemDetailScreen), findsOneWidget);
    });
  });

  group('S4-19 the Vault list on a finding', () {
    Future<void> pumpList(
      WidgetTester tester,
      AuditType report, {
      VaultSnapshot? snapshot,
    }) async {
      world = VaultWorld(
        now: checkedAt,
        snapshot: snapshot ?? securityBoardsVault(checkedAt),
      );
      world.breaches.compromised.add(kBreachedPassword);
      await tester.runAsync(world.open);
      addTearDown(() => tester.runAsync(world.close));
      world.list.showReport(report);
      await pumpScreen(
        tester,
        const VaultListScreen(),
        providers: world.providers,
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
    }

    testWidgets('Reused: “3 of 23 items”, one section under its name, and '
        'the hint for one shared password', (WidgetTester tester) async {
      await pumpList(tester, AuditType.reusedPassword);
      expect(find.text('3 of 23 items · Reused passwords'), findsOneWidget);
      expect(find.text('REUSED PASSWORDS'), findsOneWidget);
      expect(find.text('TODAY'), findsNothing);
      expect(
        find.text(
          'These 3 share one password. Give each its own: open one, tap '
          'Edit, then Generate.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('two shared passwords: the hint for several', (
      WidgetTester tester,
    ) async {
      final VaultSnapshot boards = securityBoardsVault(checkedAt);
      await pumpList(
        tester,
        AuditType.reusedPassword,
        snapshot: boards.copyWith(
          items: <VaultItem>[
            for (final VaultItem item in boards.items)
              item.id == 'github' || item.id == 'gitlab'
                  ? item.copyWith(
                      fields: <Field>[
                        for (final Field f in item.fields)
                          f.type == FieldType.password
                              ? f.copyWith(value: 'Dev-Shared-Passphrase-77')
                              : f,
                      ],
                    )
                  : item,
          ],
        ),
      );
      expect(find.text('5 of 23 items · Reused passwords'), findsOneWidget);
      expect(
        find.text(
          'Some of these share a password. Give each its own: open one, tap '
          'Edit, then Generate.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('Weak and Compromised have their own hint', (
      WidgetTester tester,
    ) async {
      await pumpList(tester, AuditType.weakPassword);
      expect(find.text('2 of 23 items · Weak passwords'), findsOneWidget);
      expect(
        find.text(
          'Give each a stronger one: open it, tap Edit, then Generate.',
        ),
        findsOneWidget,
      );
      world.list.showReport(AuditType.compromisedPassword);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 400));
      expect(
        find.text('1 of 23 items · Compromised passwords'),
        findsOneWidget,
      );
      expect(
        find.text(
          'These are in known breaches. Change each one: open it, tap Edit, '
          'then Generate.',
        ),
        findsOneWidget,
      );
    });
  });

  testWidgets('a fix from anywhere else stays on the item, with the toast', (
    WidgetTester tester,
  ) async {
    await pumpSecurity(tester);
    final BuildContext context = tester.element(find.byType(SecurityScreen));
    unawaited(openItem(context, itemId: 'spotify', backLabel: 'All Vaults'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Change password'));
    await tester.pumpAndSettle();
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Use this password'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pump();
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pumpAndSettle();
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pump();

    expect(find.byType(ItemDetailScreen), findsOneWidget);
    expect(find.text('Saved · Spotify is no longer flagged'), findsOneWidget);
    // Its card goes with the finding.
    expect(find.text('Change password'), findsNothing);
    await tester.pump(const Duration(seconds: 5));
  });
}
