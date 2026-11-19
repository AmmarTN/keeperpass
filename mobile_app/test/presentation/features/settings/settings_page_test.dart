import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/enums/auto_lock_delay.dart';
import 'package:keeperpass/core/enums/clipboard_clear_delay.dart';
import 'package:keeperpass/core/enums/session_phase.dart';
import 'package:keeperpass/infrastructure/constants/app_links.dart';
import 'package:keeperpass/infrastructure/models/vault/export_record.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/file_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/export_cubit.dart';
import 'package:keeperpass/presentation/features/data_io/cubit/import_cubit.dart';
import 'package:keeperpass/presentation/features/settings/cubit/settings_cubit.dart';
import 'package:keeperpass/presentation/features/settings/pages/settings_page.dart';
import 'package:keeperpass/presentation/features/vault_list/cubit/vault_list_view.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;

  setUpAll(initializeDateFormatting);

  /// The Settings tab, its cubits from [world].
  Future<void> pumpSettings(
    WidgetTester tester, {
    TargetPlatform platform = TargetPlatform.iOS,
  }) async {
    world = VaultWorld(now: DateTime(2026, 11, 1, 9, 41));
    await tester.runAsync(world.open);
    addTearDown(() => tester.runAsync(world.close));
    getIt
      ..registerFactory<SettingsCubit>(world.settingsCubit)
      ..registerFactory<ImportCubit>(world.importCubit)
      ..registerFactory<ExportCubit>(world.exportCubit)
      ..registerSingleton<FileService>(world.files);
    addTearDown(() async {
      await getIt.unregister<SettingsCubit>();
      await getIt.unregister<ImportCubit>();
      await getIt.unregister<ExportCubit>();
      await getIt.unregister<FileService>();
    });
    await pumpScreen(
      tester,
      const SettingsPage(),
      providers: world.providers,
      platform: platform,
    );
    await tester.pump();
    await tester.pump();
  }

  Future<void> scrollTo(WidgetTester tester, Finder finder) =>
      tester.scrollUntilVisible(
        finder,
        200,
        scrollable: find.byType(Scrollable).first,
      );

  Future<void> tapRow(WidgetTester tester, Finder row) async {
    await scrollTo(tester, row);
    await tester.ensureVisible(row);
    await tester.pumpAndSettle();
    await tester.tap(row);
    await tester.pumpAndSettle();
  }

  Future<void> open(WidgetTester tester, String row) =>
      tapRow(tester, find.text(row));

  testWidgets('S5-13: every group, each row with its value', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);

    expect(find.text('Jane Doe'), findsOneWidget);
    expect(find.text('jane@example.com · Google Drive'), findsOneWidget);
    for (final String row in <String>[
      'Log out',
      'Lock now',
      'Auto-lock',
      'Clear clipboard',
      'Hide in app switcher',
      'Change secret',
      'Theme',
      'Language',
      'Where your vault lives',
      'Move vault to Dropbox',
      'Import CSV',
      'Export CSV',
      'Recent exports',
      'How KeeperPass works',
      'Questions',
      'About KeeperPass',
      'Archive vault and sign out',
    ]) {
      await scrollTo(tester, find.text(row));
      expect(find.text(row), findsOneWidget, reason: row);
    }
    await scrollTo(tester, find.text('About KeeperPass'));
    expect(find.text('1.0.0'), findsOneWidget);
  });

  testWidgets('S5-14: Log out asks first, then signs out', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    await tester.tap(find.text('Log out'));
    await tester.pumpAndSettle();
    expect(find.text('Log out?'), findsOneWidget);

    await tester.tap(find.text('Log out').last);
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pumpAndSettle();
    expect(world.session.state.phase, SessionPhase.signedOut);
  });

  testWidgets('S5-15: Auto-lock saves the choice', (WidgetTester tester) async {
    await pumpSettings(tester);
    await open(tester, 'Auto-lock');
    expect(find.text('Immediately on leaving the app'), findsOneWidget);

    await tester.tap(find.text('After 1 minute'));
    await tester.pumpAndSettle();
    expect(world.lock.state, AutoLockDelay.oneMinute);
    // "Immediately" has no timer, so none is left running.
    await tester.tap(find.text('Immediately on leaving the app'));
    await tester.pumpAndSettle();
    expect(world.lock.state, AutoLockDelay.immediately);
  });

  testWidgets('S5-16: Clear clipboard, with its preview', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    expect(find.text('After 30 s'), findsOneWidget);
    await open(tester, 'Clear clipboard');
    expect(find.text('From GitHub · Clears in 30 s'), findsOneWidget);

    await tester.tap(find.text('Never'));
    await tester.pumpAndSettle();
    expect(world.lockSettings.clipboard, ClipboardClearDelay.never);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('Never'), findsOneWidget);
  });

  testWidgets('Hide in app switcher is saved on the phone', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    await tester.tap(find.text('Hide in app switcher'));
    await tester.pumpAndSettle();
    expect(world.lockSettings.hideInSwitcher, isFalse);
  });

  testWidgets('S6-12: Block screenshots, on Android only', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    expect(find.text('Block screenshots'), findsNothing);
    expect(
      find.text('Shows a cover instead of your vault, and blocks screenshots'),
      findsOneWidget,
    );
  });

  testWidgets('S6-12 on Android: held on while hiding, its own when not', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester, platform: TargetPlatform.android);
    expect(find.text('Block screenshots'), findsOneWidget);
    expect(find.text('On while “Hide in app switcher” is on'), findsOneWidget);

    await tester.tap(find.text('Hide in app switcher'));
    await tester.pumpAndSettle();
    expect(world.privacy.hideInSwitcher, isFalse);
    expect(
      find.text('Android only · also blocks screen recording'),
      findsOneWidget,
    );

    await tester.tap(find.text('Block screenshots'));
    await tester.pumpAndSettle();
    expect(world.lockSettings.blockScreenshots, isFalse);
    expect(world.privacy.blockScreenshots, isFalse);
  });

  testWidgets('S5-17: Language lists the five', (WidgetTester tester) async {
    await pumpSettings(tester);
    await open(tester, 'Language');
    for (final String name in <String>[
      'English',
      'Deutsch',
      'Español',
      'Français',
      'Português',
    ]) {
      expect(find.text(name), findsWidgets, reason: name);
    }
  });

  testWidgets('S5-24: Storage, its file and its access pages', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    await open(tester, 'Where your vault lives');

    expect(
      find.text('Where your vault lives, and what can reach it'),
      findsOneWidget,
    );
    expect(
      find.bySemanticsLabel(
        'Encrypted on this phone, stored in your Google Drive',
      ),
      findsOneWidget,
    );
    expect(find.text('vault.json.enc'), findsOneWidget);
    expect(find.textContaining('keeperpass folder'), findsOneWidget);
    expect(find.text('Move vault to Dropbox'), findsOneWidget);

    await scrollTo(tester, find.text('Dropbox connected apps'));
    await tester.tap(find.text('Google account permissions'));
    await tester.pump();
    expect(world.links.opened, <Uri>[AppLinks.googlePermissions]);
  });

  testWidgets('S5-32: Import from Settings ends on the Vault tab', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    world.files.picked = const PickedTextFile(
      name: 'bitwarden_export.csv',
      size: 24 * 1024,
      text: 'name,tags,Password\r\nOne,,a\r\nTwo,,b',
    );
    await open(tester, 'Import CSV');

    expect(find.text('bitwarden_export.csv'), findsOneWidget);
    expect(find.text('24 KB · from Files'), findsOneWidget);
    expect(find.text('Found 2 items to import.'), findsOneWidget);
    expect(find.text('My Vault'), findsOneWidget);

    await tester.tap(find.text('Import 2 items'));
    await tester.pumpAndSettle();
    expect(world.list.state.scope, VaultScope.vault);
    expect(world.list.state.vaultId, kPersonalVaultId);
    expect(world.bottomNav.state.rootSerial, 1);
    expect(world.bottomNav.state.rootTab, 0);
  });

  testWidgets('tapping Import CSV again while the picker opens opens one '
      'picker (2026-11-05)', (WidgetTester tester) async {
    await pumpSettings(tester);
    world.files
      ..picked = const PickedTextFile(
        name: 'bitwarden_export.csv',
        size: 24 * 1024,
        text: 'name,tags,Password\r\nOne,,a\r\nTwo,,b',
      )
      ..holdPick = Completer<void>();
    await open(tester, 'Import CSV');
    await tester.tap(find.text('Import CSV'));
    await tester.pump();
    world.files.holdPick!.complete();
    await tester.pumpAndSettle();
    expect(world.files.picks, 1);
    expect(
      find.text('bitwarden_export.csv', skipOffstage: false),
      findsOneWidget,
    );
  });

  testWidgets('S5-33: a file without items says so', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    world.files.picked = const PickedTextFile(
      name: 'notes.txt',
      size: 3 * 1024,
      text: '',
    );
    await open(tester, 'Import CSV');

    expect(find.text('No items found in this file.'), findsOneWidget);
    expect(find.text('Choose another file'), findsOneWidget);
    expect(find.text('Add them to'), findsNothing);
  });

  testWidgets('S5-34: Export shares the CSV and comes back', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    await open(tester, 'Export CSV');

    expect(find.text('All Vaults'), findsOneWidget);
    expect(find.text('A CSV file is not encrypted'), findsOneWidget);
    final Finder export = find.byWidgetPredicate(
      (Widget w) => w is AppButton && w.label.startsWith('Export '),
    );
    await tester.tap(export);
    await tester.pumpAndSettle();

    expect(world.files.shared.single.fileName, 'keeperpass-all-vaults.csv');
    expect(world.vault.snapshot!.exportHistory, hasLength(1));
    expect(find.text('Source vault'), findsNothing);
  });

  testWidgets('S5-35: Recent exports, empty and then listed', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    await open(tester, 'Recent exports');
    expect(find.text('No exports yet.'), findsOneWidget);
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();

    world.vault.update(
      world.vault.snapshot!.copyWith(
        exportHistory: <ExportRecord>[
          ExportRecord(
            at: DateTime.utc(2026, 10, 21, 16, 54),
            format: 'csv',
            scope: 'All Vaults',
            itemCount: 23,
            fileName: 'keeperpass-all-vaults.csv',
          ),
        ],
      ),
    );
    await tester.pump();
    await open(tester, 'Recent exports');
    expect(find.text('All Vaults · 23 items'), findsOneWidget);
  });

  testWidgets('S5-38: How it works, and Technical details', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    await open(tester, 'How KeeperPass works');

    expect(find.text('How KeeperPass Works'), findsWidgets);
    expect(find.text('Your Google Drive'), findsOneWidget);
    await tapRow(tester, find.text('Technical details'));
    expect(find.text('Technical Details'), findsWidgets);
  });

  testWidgets('S5-40: one answer open at a time; the support address', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    await open(tester, 'Questions');

    expect(find.textContaining('Your vault cannot be recovered'), findsOne);
    await tester.tap(find.text('Can KeeperPass see my passwords?'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Your vault cannot be recovered'), findsNothing);
    expect(find.textContaining('not as a promise'), findsOneWidget);

    await tapRow(tester, find.text('contact@keeperpass.com'));
    expect(world.links.opened, <Uri>[AppLinks.contact]);
  });

  testWidgets('S5-41: About, with its version and links', (
    WidgetTester tester,
  ) async {
    await pumpSettings(tester);
    await open(tester, 'About KeeperPass');

    expect(find.text('Version 1.0.0 (1)'), findsOneWidget);
    expect(find.text('Your cloud. Your keys. Your vault.'), findsOneWidget);
    await tester.tap(find.text('Terms of Service'));
    await tester.pump();
    expect(world.links.opened, <Uri>[AppLinks.terms]);
  });
}
