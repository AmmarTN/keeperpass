import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/crypto/totp.dart';
import 'package:keeperpass/infrastructure/models/vault/vault_snapshot.dart';
import 'package:keeperpass/infrastructure/services/camera_permission_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/common/widgets/cards/app_code_card.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_live_totp.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_totp_ring.dart';
import 'package:keeperpass/presentation/features/codes/cubit/codes_cubit.dart';
import 'package:keeperpass/presentation/features/codes/pages/codes_page.dart';
import 'package:keeperpass/presentation/features/edit_item/cubit/edit_item_cubit.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/edit_item_page.dart';
import 'package:keeperpass/presentation/features/edit_item/widgets/field_editor.dart';
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart';
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart';
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart';
import 'package:keeperpass/presentation/features/scan_qr/pages/scan_page.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  /// 24 seconds left in the period, as the boards draw it.
  final DateTime boardsNow = DateTime(2026, 10, 29, 9, 45, 6);
  late VaultWorld world;

  setUpAll(initializeDateFormatting);

  Future<void> pumpCodes(
    WidgetTester tester, {
    DateTime? now,
    VaultSnapshot? snapshot,
    Brightness brightness = Brightness.light,
  }) async {
    final DateTime at = now ?? boardsNow;
    world = VaultWorld(now: at, snapshot: snapshot ?? codesBoardsVault(at));
    await tester.runAsync(world.open);
    getIt
      ..registerFactory<EditItemCubit>(world.editCubit)
      ..registerFactory<GeneratorCubit>(world.generatorCubit)
      ..registerFactory<ItemDetailCubit>(world.itemCubit);
    addTearDown(() async {
      await getIt.unregister<EditItemCubit>();
      await getIt.unregister<GeneratorCubit>();
      await getIt.unregister<ItemDetailCubit>();
      await tester.runAsync(world.close);
    });
    await pumpScreen(
      tester,
      BlocProvider<CodesCubit>(
        create: (_) => world.codesCubit(),
        child: const CodesScreen(),
      ),
      providers: world.providers,
      brightness: brightness,
    );
    await tester.pump();
  }

  List<int> secondsLeft(WidgetTester tester) => tester
      .widgetList<AppTotpRing>(find.byType(AppTotpRing))
      .map((AppTotpRing r) => r.secondsLeft)
      .toList();

  String code(String key) => splitTotpCode(
    generateTotp(key, timestampMs: world.now.millisecondsSinceEpoch),
  );

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S4-01 Default (${brightness.name}): every code, A to Z, '
        'with the trust line', (WidgetTester tester) async {
      await pumpCodes(tester, brightness: brightness);

      expect(find.text('Codes'), findsWidgets);
      expect(
        find.text('2FA codes from your vault, made on this phone'),
        findsOneWidget,
      );
      expect(find.bySemanticsLabel('Scan QR code'), findsOneWidget);
      expect(find.text('Search 3 codes'), findsOneWidget);
      final List<String> names = tester
          .widgetList<AppCodeCard>(find.byType(AppCodeCard))
          .map((AppCodeCard c) => c.name)
          .toList();
      expect(names, <String>['AWS Console', 'Cloudflare', 'GitHub']);
      expect(find.text('My Vault'), findsNWidgets(2));
      expect(find.text('janedoe-dev · Work'), findsOneWidget);
      expect(find.text(code(kTotpKey)), findsOneWidget);
      // All 30-second codes turn over together.
      expect(secondsLeft(tester), <int>[24, 24, 24]);
      expect(find.text('4 s'), findsNothing);
      expect(
        find.text(
          'Made on this phone from the setup keys in your vault. '
          'Nothing new is stored.',
        ),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('S4-02 Copied: the code, the item counts as used, the card '
      'confirms for 1 s and the toast says where from', (
    WidgetTester tester,
  ) async {
    final List<MethodCall> haptics = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (MethodCall call) async {
        haptics.add(call);
        return null;
      },
    );
    await pumpCodes(tester);

    await tester.tap(find.text('GitHub'));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump();

    expect(world.clipboard.copied, <String>[
      code(kTotpKey).replaceAll(' ', ''),
    ]);
    expect(world.recent.ids, <String>['github']);
    expect(find.text('Code copied'), findsOneWidget);
    expect(find.text('From GitHub · Clears in 30 s'), findsOneWidget);
    expect(find.bySemanticsLabel('Copied'), findsOneWidget);
    expect(
      haptics.where((MethodCall c) => c.method == 'HapticFeedback.vibrate'),
      isNotEmpty,
    );

    await tester.pump(const Duration(seconds: 1));
    expect(find.bySemanticsLabel('Copied'), findsNothing);
    expect(find.bySemanticsLabel('Copy code for GitHub'), findsOneWidget);
    // The clipboard's 30 s run out.
    await tester.pump(const Duration(seconds: 30));
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S4-03 Last 5 seconds (${brightness.name}): amber with the '
        'count', (WidgetTester tester) async {
      await pumpCodes(
        tester,
        now: DateTime(2026, 10, 29, 9, 45, 26),
        brightness: brightness,
      );
      expect(find.text('4 s'), findsNWidgets(3));
      expect(secondsLeft(tester), <int>[4, 4, 4]);
    });
  }

  testWidgets('the code is read with the card and announced when it changes', (
    WidgetTester tester,
  ) async {
    final SemanticsHandle semantics = tester.ensureSemantics();
    await pumpCodes(tester);
    final SemanticsNode card = tester.getSemantics(
      find.bySemanticsLabel('Copy code for GitHub'),
    );
    expect(card.value, code(kTotpKey));
    expect(card.flagsCollection.isLiveRegion, isTrue);
    semantics.dispose();
  });

  testWidgets('S4-04 Invalid setup key: no ring and no code; Fix it in Edit '
      'opens Edit on that field', (WidgetTester tester) async {
    await pumpCodes(
      tester,
      snapshot: codesBoardsVault(boardsNow, invalidCloudflare: true),
    );
    expect(find.text('Invalid code'), findsOneWidget);
    expect(
      find.text('The setup key isn’t valid, so no code can be made.'),
      findsOneWidget,
    );
    expect(secondsLeft(tester), <int>[24, 24]);

    await tester.tap(find.text('Fix it in Edit'));
    await tester.pumpAndSettle();
    expect(find.byType(EditItemScreen), findsOneWidget);
    expect(find.text('Edit Item'), findsOneWidget);
    final FieldEditor field = tester.widget<FieldEditor>(
      find.byType(FieldEditor),
    );
    expect(field.field.type, FieldType.totp);
    expect(field.highlighted, isTrue);
    expect(find.text('Invalid code'), findsWidgets);

    // The focused look stays until the screen is touched.
    await tester.tap(find.text('Edit Item'));
    await tester.pump();
    expect(
      tester.widget<FieldEditor>(find.byType(FieldEditor)).highlighted,
      isFalse,
    );
  });

  testWidgets('S4-05 Search: item names, marked, with the count; the trust '
      'line steps aside; nothing found says "0 codes"', (
    WidgetTester tester,
  ) async {
    await pumpCodes(tester);
    await tester.enterText(find.byType(TextField), 'cloud');
    await tester.pump();

    expect(find.text('1 code'), findsOneWidget);
    final AppCodeCard card = tester.widget<AppCodeCard>(
      find.byType(AppCodeCard),
    );
    expect(card.name, 'Cloudflare');
    expect(card.highlight, <String>['cloud']);
    expect(find.textContaining('Made on this phone'), findsNothing);

    await tester.enterText(find.byType(TextField), 'janedoe');
    await tester.pump();
    expect(find.text('0 codes'), findsOneWidget);
    expect(find.byType(AppCodeCard), findsNothing);

    await tester.tap(find.bySemanticsLabel('Clear search'));
    await tester.pump();
    expect(find.byType(AppCodeCard), findsNWidgets(3));
    expect(find.textContaining('Made on this phone'), findsOneWidget);
  });

  VaultSnapshot noCodes() {
    final VaultSnapshot all = codesBoardsVault(boardsNow);
    return all.copyWith(
      items: all.items.where((i) => i.id == 'notes').toList(),
    );
  }

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S4-06 Empty (${brightness.name}): the two ways in', (
      WidgetTester tester,
    ) async {
      await pumpCodes(tester, snapshot: noCodes(), brightness: brightness);
      expect(find.text('No 2FA codes yet'), findsOneWidget);
      expect(
        find.text(
          'When a site offers two-factor sign-in, scan its QR code here, '
          'or add an Authenticator item.',
        ),
        findsOneWidget,
      );
      expect(find.text('Scan QR code'), findsOneWidget);
      expect(find.text('Create an Authenticator item'), findsOneWidget);
      expect(find.byType(TextField), findsNothing);
      expect(find.textContaining('Made on this phone'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }

  /// Frames for the screens to move (the live rings never settle).
  Future<void> frames(WidgetTester tester, [int count = 8]) async {
    for (int i = 0; i < count; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  /// "Scan QR code" with the camera off (no camera in tests), then "Enter
  /// setup key instead" with [key].
  Future<void> typeKeyFromScan(WidgetTester tester, String key) async {
    getIt
      ..registerSingleton<CameraPermissionService>(world.camera)
      ..registerFactory<ScanCubit>(world.scanCubit);
    addTearDown(() async {
      await getIt.unregister<CameraPermissionService>();
      await getIt.unregister<ScanCubit>();
    });
    world.camera.access = CameraAccess.refused;
    await tester.tap(find.bySemanticsLabel('Scan QR code').first);
    await frames(tester);
    expect(find.text('Camera access is off'), findsOneWidget);
    await tester.tap(find.text('Enter setup key instead'));
    await frames(tester);
    await tester.enterText(find.byType(TextField), key);
    await tester.pump();
  }

  testWidgets('tapping Scan QR code again while it opens opens one scanner '
      '(2026-11-05)', (WidgetTester tester) async {
    await pumpCodes(tester);
    getIt
      ..registerSingleton<CameraPermissionService>(world.camera)
      ..registerFactory<ScanCubit>(world.scanCubit);
    addTearDown(() async {
      await getIt.unregister<CameraPermissionService>();
      await getIt.unregister<ScanCubit>();
    });
    world.camera
      ..access = CameraAccess.refused
      ..holdStatus = Completer<void>();
    await tester.tap(find.bySemanticsLabel('Scan QR code').first);
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Scan QR code').first);
    await tester.pump();
    world.camera.holdStatus!.complete();
    await frames(tester);
    expect(find.byType(ScanScreen, skipOffstage: false), findsOneWidget);
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S6-32 Added (${brightness.name}): the code lands on its '
        'card with the toast, no New mark (your answer, Part 15)', (
      WidgetTester tester,
    ) async {
      await pumpCodes(
        tester,
        snapshot: scanBoardsVault(boardsNow),
        brightness: brightness,
      );
      expect(find.text('Dropbox'), findsNothing);
      await typeKeyFromScan(tester, 'KRSXG5CTMVRXEZLU');
      await tester.tap(find.text('New Authenticator item'));
      await frames(tester);
      await tester.tap(find.text('Dropbox'));
      await frames(tester);
      await tester.tap(find.text('Save code'));
      await frames(tester, 10);

      expect(find.text('Code added to Dropbox'), findsOneWidget);
      expect(find.text('Tap the card to copy it.'), findsOneWidget);
      expect(find.text('Dropbox'), findsOneWidget);
      expect(find.text('jane.doe92@example.com · My Vault'), findsOneWidget);
      expect(find.text(code('KRSXG5CTMVRXEZLU')), findsOneWidget);
      expect(find.text('New'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pump(const Duration(seconds: 4));
    });
  }

  testWidgets('a typed key for a new item: the new item, key filled in, to '
      'be named (your answer, Part 15)', (WidgetTester tester) async {
    await pumpCodes(tester, snapshot: noCodes());
    await typeKeyFromScan(tester, 'JBSWY3DPEHPK3PXP');
    await tester.tap(find.text('Save code'));
    await frames(tester, 10);

    expect(find.text('New Item'), findsOneWidget);
    final EditItemState state = tester
        .element(find.byType(EditItemScreen))
        .read<EditItemCubit>()
        .state;
    expect(state.vaultId, kPersonalVaultId);
    expect(state.icon, 'totp');
    expect(
      state.fields.map((EditableField f) => (f.type, f.value)),
      <(FieldType, String)>[(FieldType.totp, 'JBSWY3DPEHPK3PXP')],
    );
    expect(state.name, isEmpty);
  });

  testWidgets('Create an Authenticator item: straight to the new item in '
      'your own vault (your answer, Part 10)', (WidgetTester tester) async {
    await pumpCodes(tester, snapshot: noCodes());
    await tester.tap(find.text('Create an Authenticator item'));
    await tester.pumpAndSettle();

    expect(find.text('New Vault Item'), findsNothing);
    expect(find.text('New Item'), findsOneWidget);
    final EditItemState state = tester
        .element(find.byType(EditItemScreen))
        .read<EditItemCubit>()
        .state;
    expect(state.vaultId, kPersonalVaultId);
    expect(state.icon, 'totp');
    expect(state.fields.map((EditableField f) => f.type), <FieldType>[
      FieldType.totp,
    ]);
  });
}
