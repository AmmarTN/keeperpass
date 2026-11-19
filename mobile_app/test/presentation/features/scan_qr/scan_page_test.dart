import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/core/enums/field_type.dart';
import 'package:keeperpass/core/utils/crypto/totp.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/services/camera_permission_service.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_live_totp.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart';
import 'package:keeperpass/presentation/features/scan_qr/pages/scan_page.dart';
import 'package:keeperpass/presentation/features/scan_qr/widgets/code_found_sheet.dart';
import 'package:keeperpass/presentation/features/scan_qr/widgets/scan_camera.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  /// 24 seconds left in the period, as the boards draw it.
  final DateTime boardsNow = DateTime(2026, 10, 29, 9, 45, 6);
  late VaultWorld world;
  late StillCamera camera;
  ScanOutcome? outcome;
  bool closed = false;

  setUpAll(initializeDateFormatting);

  /// The scan screens pushed over a launcher, as from Codes or Edit.
  Future<void> pumpScan(
    WidgetTester tester, {
    CameraAccess access = CameraAccess.allowed,
    bool forField = false,
    Brightness brightness = Brightness.light,
  }) async {
    world = VaultWorld(now: boardsNow, snapshot: scanBoardsVault(boardsNow));
    world.camera.access = access;
    await tester.runAsync(world.open);
    addTearDown(() => tester.runAsync(world.close));
    camera = StillCamera();
    outcome = null;
    closed = false;
    await pumpScreen(
      tester,
      Builder(
        builder: (BuildContext context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () async {
                outcome = await Navigator.of(context).push(
                  MaterialPageRoute<ScanOutcome>(
                    fullscreenDialog: true,
                    builder: (_) => BlocProvider<ScanCubit>(
                      create: (_) => world.scanCubit()..open(access),
                      child: ScanScreen(
                        forField: forField,
                        camera: () => camera,
                      ),
                    ),
                  ),
                );
                closed = true;
              },
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

  /// A frame for the camera's stream, then the sheet's way up (the live
  /// ring never settles).
  Future<void> read(WidgetTester tester, String raw) async {
    camera.show(raw);
    for (int i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 150));
    }
  }

  String codeAt(String key) => splitTotpCode(
    generateTotp(key, timestampMs: boardsNow.millisecondsSinceEpoch),
  );

  VaultItem item(String id) =>
      world.vault.snapshot!.items.firstWhere((VaultItem i) => i.id == id);

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S6-27 Before the camera (${brightness.name})', (
      WidgetTester tester,
    ) async {
      await pumpScan(
        tester,
        access: CameraAccess.askable,
        brightness: brightness,
      );
      expect(find.text('Scan QR Code'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Add a 2FA code by scanning'), findsOneWidget);
      expect(
        find.text(
          'When a site turns on two-factor sign-in, it shows a QR code. '
          'KeeperPass reads it with the camera and keeps the setup key in '
          'your vault, so its codes appear in Codes.',
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          'The camera only reads the code. Nothing is recorded, and no '
          'image is kept.',
        ),
        findsOneWidget,
      );
      expect(
        find.text('Your phone asks for camera access next.'),
        findsOneWidget,
      );
      expect(find.text('Enter setup key instead'), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Continue: the phone asks; allowed, the camera starts.
      await tester.tap(find.text('Continue'));
      await tester.pumpAndSettle();
      expect(world.camera.asked, 1);
      expect(
        find.text(
          'Point at the QR code the website shows\n'
          'when you turn on two-factor sign-in.',
        ),
        findsOneWidget,
      );
      expect(camera.starts, 1);
    });
  }

  testWidgets('S6-28 Scanning: the light, the way out, Close', (
    WidgetTester tester,
  ) async {
    await pumpScan(tester);
    expect(find.text('Scan QR Code'), findsOneWidget);
    expect(find.text('Enter setup key'), findsOneWidget);
    expect(find.bySemanticsLabel('Camera view'), findsOneWidget);
    expect(camera.starts, 1);

    final SemanticsHandle semantics = tester.ensureSemantics();
    expect(
      tester.getSemantics(find.bySemanticsLabel('Turn on the light')),
      isSemantics(
        label: 'Turn on the light',
        isButton: true,
        hasToggledState: true,
        isToggled: false,
      ),
    );
    await tester.tap(find.bySemanticsLabel('Turn on the light'));
    await tester.pump();
    expect(camera.light.value, isTrue);
    semantics.dispose();

    // The app away and back: the camera stops and starts again.
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    await tester.pump();
    expect(camera.stops, 1);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(camera.starts, 2);

    await tester.tap(find.bySemanticsLabel('Close'));
    await tester.pumpAndSettle();
    expect(closed, isTrue);
    expect(outcome, isNull);
    expect(camera.disposed, isTrue);
  });

  testWidgets('no light on this camera: no light button', (
    WidgetTester tester,
  ) async {
    await pumpScan(tester);
    camera.noLight();
    await tester.pump();
    expect(find.bySemanticsLabel('Turn on the light'), findsNothing);
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S6-29 Code found (${brightness.name}): the live code, the '
        'Dropbox item offered, saved into it', (WidgetTester tester) async {
      await pumpScan(tester, brightness: brightness);
      await read(tester, kDropboxQr);

      expect(find.text('Code Found'), findsOneWidget);
      expect(find.text('Dropbox'), findsWidgets);
      expect(find.text('jane.doe92@example.com'), findsOneWidget);
      expect(find.text(codeAt('JBSWY3DPEHPK3PXP')), findsOneWidget);
      expect(find.text('SAVE IT TO'), findsOneWidget);
      expect(
        find.text('Existing item · jane.doe92@example.com'),
        findsOneWidget,
      );
      expect(find.text('New Authenticator item'), findsOneWidget);
      expect(find.text('Named Dropbox'), findsOneWidget);
      expect(find.text('Save code'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('Save code'));
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 600));
      expect(closed, isTrue);
      expect(outcome, isA<CodeAdded>());
      expect((outcome! as CodeAdded).itemId, 'dropbox');
      expect(item('dropbox').fields.last.type, FieldType.totp);
    });
  }

  testWidgets('S6-29: a new Authenticator item instead', (
    WidgetTester tester,
  ) async {
    await pumpScan(tester);
    await read(tester, kDropboxQr);
    await tester.tap(find.text('New Authenticator item'));
    await tester.pump();
    await tester.tap(find.text('Save code'));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pump(const Duration(milliseconds: 600));
    final CodeAdded added = outcome! as CodeAdded;
    expect(added.itemId, isNot('dropbox'));
    expect(item(added.itemId).name, 'Dropbox');
    expect(item('dropbox').fields, hasLength(3));
  });

  testWidgets('closing "Code Found" goes back to scanning', (
    WidgetTester tester,
  ) async {
    await pumpScan(tester);
    await read(tester, kDropboxQr);
    await tester.tap(
      find.descendant(
        of: find.byType(CodeFoundSheet),
        matching: find.bySemanticsLabel('Close'),
      ),
    );
    for (int i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 150));
    }
    expect(find.text('Code Found'), findsNothing);
    expect(closed, isFalse);
  });

  testWidgets('from Edit: no choice, the key is for the field', (
    WidgetTester tester,
  ) async {
    await pumpScan(tester, forField: true);
    await read(tester, kDropboxQr);
    expect(find.text('Code Found'), findsOneWidget);
    expect(find.text('SAVE IT TO'), findsNothing);
    await tester.tap(find.text('Save code'));
    await tester.pump(const Duration(milliseconds: 600));
    expect(outcome, isA<FieldKey>());
    expect((outcome! as FieldKey).key, 'JBSWY3DPEHPK3PXP');
    expect(item('dropbox').fields, hasLength(3));
  });

  testWidgets('what gives no code is a toast over the hint', (
    WidgetTester tester,
  ) async {
    await pumpScan(tester);
    await read(tester, 'https://www.dropbox.com');
    expect(find.text('This isn’t a 2FA QR code'), findsOneWidget);
    // Raised over the hint: 34 pt of safe area and 88 pt above it.
    final double toastBottom = tester.getBottomLeft(find.byType(AppToast)).dy;
    expect(852 - toastBottom, closeTo(122, 1));
    await tester.pump(const Duration(seconds: 4));

    await read(tester, 'otpauth://totp/A?secret=JBSWY3DPEHPK3PXP&period=60');
    expect(
      find.text('This code uses settings KeeperPass doesn’t support yet'),
      findsOneWidget,
    );
    await tester.pump(const Duration(seconds: 4));
    camera.fail(ScanCameraProblem.failed);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('The camera couldn’t start'), findsOneWidget);
    await tester.pump(const Duration(seconds: 4));
  });

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S6-31 Camera off (${brightness.name}); allowed in '
        'Settings, scanning starts on return', (WidgetTester tester) async {
      await pumpScan(
        tester,
        access: CameraAccess.refused,
        brightness: brightness,
      );
      expect(find.text('Camera access is off'), findsOneWidget);
      expect(
        find.text(
          'KeeperPass needs the camera only to read QR codes. Turn it on in '
          'Settings, or type the setup key instead.',
        ),
        findsOneWidget,
      );
      expect(find.text('Enter setup key instead'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('Open Settings'));
      await tester.pump();
      expect(world.camera.settingsOpened, 1);

      world.camera.access = CameraAccess.allowed;
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(find.text('Enter setup key'), findsOneWidget);
      expect(camera.starts, 1);
    });
  }

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S6-30 Enter setup key (${brightness.name}): the Item '
        'choice, saved into Dropbox', (WidgetTester tester) async {
      await pumpScan(tester, brightness: brightness);
      await tester.tap(find.text('Enter setup key'));
      await tester.pumpAndSettle();

      expect(find.text('Enter Setup Key'), findsOneWidget);
      expect(
        find.text(
          'Sites show a setup key next to the QR code, often under “Can’t '
          'scan it?”.',
        ),
        findsOneWidget,
      );
      expect(find.text('Spaces and capitals don’t matter.'), findsOneWidget);
      expect(find.text('Item'), findsOneWidget);
      expect(find.text('New Authenticator item'), findsOneWidget);
      expect(find.text('6 digits · every 30 seconds · SHA-1'), findsOneWidget);
      expect(tester.takeException(), isNull);

      await tester.enterText(find.byType(TextField), 'jbsw y3dp ehpk 3pxp');
      await tester.tap(find.text('New Authenticator item'));
      await tester.pumpAndSettle();
      // The choice: a new item first, then every item A to Z.
      expect(find.text('AWS Console'), findsOneWidget);
      expect(find.text('Server notes'), findsOneWidget);
      await tester.tap(find.text('Dropbox'));
      await tester.pumpAndSettle();
      expect(find.text('Dropbox'), findsOneWidget);

      await tester.tap(find.text('Save code'));
      await tester.runAsync(() => Future<void>.delayed(Duration.zero));
      await tester.pumpAndSettle();
      expect(outcome, isA<CodeAdded>());
      expect(
        item('dropbox').fields.last,
        isA<Field>().having(
          (Field f) => f.value,
          'value',
          'jbsw y3dp ehpk 3pxp',
        ),
      );
    });
  }

  testWidgets('S6-30: a typed key for a new item is named later', (
    WidgetTester tester,
  ) async {
    await pumpScan(tester, access: CameraAccess.askable);
    await tester.tap(find.text('Enter setup key instead'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'JBSWY3DPEHPK3PXP');
    await tester.pump();
    await tester.tap(find.text('Save code'));
    await tester.pumpAndSettle();
    expect(outcome, isA<NewItemKey>());
    expect((outcome! as NewItemKey).key, 'JBSWY3DPEHPK3PXP');
  });

  testWidgets('S6-30 from Edit: no Item choice; the key for the field', (
    WidgetTester tester,
  ) async {
    await pumpScan(tester, forField: true);
    await tester.tap(find.text('Enter setup key'));
    await tester.pumpAndSettle();
    expect(find.text('Item'), findsNothing);
    expect(find.text('6 digits · every 30 seconds · SHA-1'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'JBSWY3DPEHPK3PXP');
    await tester.pump();
    await tester.tap(find.text('Save code'));
    await tester.pumpAndSettle();
    expect((outcome! as FieldKey).key, 'JBSWY3DPEHPK3PXP');
  });
}
