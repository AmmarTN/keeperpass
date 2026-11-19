import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:keeperpass/infrastructure/models/items/field.dart';
import 'package:keeperpass/infrastructure/models/items/vault_item.dart';
import 'package:keeperpass/infrastructure/models/vault/vault.dart';
import 'package:keeperpass/infrastructure/services/camera_permission_service.dart';
import 'package:keeperpass/injection.dart';
import 'package:keeperpass/presentation/features/edit_item/cubit/edit_item_cubit.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/edit_item_page.dart';
import 'package:keeperpass/presentation/features/edit_item/pages/setup_key_page.dart';
import 'package:keeperpass/presentation/features/generator/cubit/generator_cubit.dart';
import 'package:keeperpass/presentation/features/item_detail/cubit/item_detail_cubit.dart';
import 'package:keeperpass/presentation/features/item_detail/pages/item_detail_page.dart';
import 'package:keeperpass/presentation/features/scan_qr/cubit/scan_cubit.dart';

import '../../../helpers/screen_harness.dart';
import '../../../helpers/vault_world.dart';

void main() {
  late VaultWorld world;

  setUpAll(initializeDateFormatting);

  /// A page with "new" and "edit" buttons, over the item boards' vault.
  Future<void> pumpHost(
    WidgetTester tester, {
    String? vaultInView,
    String editId = 'github',
    Brightness brightness = Brightness.light,
  }) async {
    world = VaultWorld(
      now: kItemBoardsNow,
      snapshot: itemBoardsVault(kItemBoardsNow),
    );
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
      Builder(
        builder: (BuildContext context) => Scaffold(
          body: Column(
            children: <Widget>[
              const SizedBox(height: 120),
              TextButton(
                onPressed: () => openNewItem(
                  context,
                  vaults: world.vault.snapshot!.vaults,
                  vaultInView: vaultInView,
                  backLabel: 'All Vaults',
                ),
                child: const Text('new'),
              ),
              TextButton(
                onPressed: () => openEditItem(context, editId),
                child: const Text('edit'),
              ),
            ],
          ),
        ),
      ),
      providers: world.providers,
      brightness: brightness,
    );
  }

  Future<void> openNew(WidgetTester tester, String template) async {
    await tester.tap(find.text('new'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(template));
    await tester.pumpAndSettle();
  }

  Future<void> openEdit(WidgetTester tester) async {
    await tester.tap(find.text('edit'));
    await tester.pumpAndSettle();
  }

  EditItemState state(WidgetTester tester) =>
      tester.element(find.byType(EditItemScreen)).read<EditItemCubit>().state;

  VaultItem? item(String id) => world.vault.snapshot!.items
      .where((VaultItem i) => i.id == id)
      .firstOrNull;

  /// Scrolls the edit screen's list (its text fields scroll too).
  Future<void> scrollTo(WidgetTester tester, Finder finder) =>
      tester.scrollUntilVisible(
        finder,
        200,
        scrollable: find
            .descendant(
              of: find.byType(ListView),
              matching: find.byType(Scrollable),
            )
            .first,
      );

  Future<void> drain(WidgetTester tester) async {
    await tester.pump(const Duration(seconds: 5));
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
  }

  for (final Brightness brightness in Brightness.values) {
    testWidgets('S3-37 New Vault Item: the vault in view and nine templates '
        '(${brightness.name})', (WidgetTester tester) async {
      await pumpHost(tester, vaultInView: kWorkVaultId, brightness: brightness);
      await tester.tap(find.text('new'));
      await tester.pumpAndSettle();

      expect(find.text('New Vault Item'), findsOneWidget);
      expect(find.text('VAULT'), findsOneWidget);
      expect(find.text('My Vault'), findsOneWidget);
      expect(find.text('Work'), findsOneWidget);
      expect(find.text('TEMPLATE'), findsOneWidget);
      for (final String name in <String>[
        'Website or App',
        'Computer',
        'Credit Card',
        'Bank Account',
        'Wi-Fi Network',
        'Passport',
        'Note',
        'Authenticator',
        'Custom',
      ]) {
        expect(find.text(name), findsOneWidget, reason: name);
      }
      expect(find.text('Number, holder, expiry, CVC, PIN'), findsOneWidget);
      expect(
        find.text(
          'Templates are a head start: rename, remove or add fields at any '
          'time.',
        ),
        findsOneWidget,
      );
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('Computer'));
      await tester.pumpAndSettle();
      expect(find.text('New Item'), findsOneWidget);
      expect(state(tester).vaultId, kWorkVaultId);
    });
  }

  testWidgets('more than three vaults: a row that opens the vault list', (
    WidgetTester tester,
  ) async {
    await pumpHost(tester);
    final List<Vault> vaults = <Vault>[
      ...world.vault.snapshot!.vaults,
      for (final String name in <String>['Family', 'Travel'])
        Vault(id: name, name: name, created: DateTime.utc(2026)),
    ];
    world.vault.update(world.vault.snapshot!.copyWith(vaults: vaults));
    await tester.tap(find.text('new'));
    await tester.pumpAndSettle();
    expect(find.text('Work'), findsNothing);
    await tester.tap(find.text('My Vault'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Travel'));
    await tester.pumpAndSettle();
    expect(find.text('Travel'), findsOneWidget);
    await tester.tap(find.text('Note'));
    await tester.pumpAndSettle();
    expect(state(tester).vaultId, 'Travel');
  });

  testWidgets('S3-38 Website or App: name focused, Save waits for it; after '
      'Save the item opens', (WidgetTester tester) async {
    await pumpHost(tester);
    await openNew(tester, 'Website or App');

    expect(find.text('New Item'), findsOneWidget);
    expect(find.text('Change icon'), findsWidgets);
    expect(find.text('e.g. GitHub'), findsOneWidget);
    expect(find.text('Username or email'), findsOneWidget);
    expect(find.text('https://'), findsOneWidget);
    expect(find.bySemanticsLabel('Generate a password'), findsOneWidget);
    expect(find.text('Generate'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Reorder')), findsNothing);
    await scrollTo(tester, find.text('Add a tag'));
    expect(find.text('Add a tag'), findsOneWidget);
    expect(state(tester).canSave, isFalse);

    final int before = world.vault.snapshot!.items.length;
    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(world.vault.snapshot!.items, hasLength(before));

    await tester.enterText(find.byType(EditableText).first, 'Figma');
    await tester.pump();
    expect(state(tester).canSave, isTrue);
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(world.vault.snapshot!.items, hasLength(before + 1));
    expect(find.byType(EditItemScreen), findsNothing);
    expect(find.byType(ItemDetailScreen), findsOneWidget);
    expect(find.text('Figma'), findsWidgets);
    await drain(tester);
  });

  testWidgets('S3-39 / S3-40 Custom: no fields yet; Add Field offers all 16 '
      'and the new one lands last', (WidgetTester tester) async {
    await pumpHost(tester);
    await openNew(tester, 'Custom');

    expect(find.text('No fields yet'), findsWidgets);
    expect(
      find.text(
        'Add any of the 16 field types — a policy number, a phone number, a '
        'PIN.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Add field'));
    await tester.pumpAndSettle();
    expect(find.text('Add Field'), findsOneWidget);
    for (final String type in <String>[
      'Username',
      'Password',
      'Email',
      'URL',
      'IP / Host',
      'Date',
      'Month',
      'Card Number',
      'Phone',
      'PIN',
      'Authenticator Code',
      'Certificate',
      'SSH / Private Key',
      'Recovery Codes',
      'Formatted Note',
      'Text',
    ]) {
      expect(find.text(type), findsOneWidget, reason: type);
    }
    await tester.tap(find.text('IP / Host'));
    await tester.pumpAndSettle();
    expect(state(tester).fields.single.name, 'IP / Host');
    expect(
      find.text('e.g. 192.168.1.1, ::1, or db.example.com'),
      findsOneWidget,
    );

    await tester.tap(find.text('Add field'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Recovery Codes'));
    await tester.pumpAndSettle();
    expect(state(tester).fields.last.name, 'Recovery Codes');
    expect(state(tester).fields.last.secret, isTrue);
    expect(find.text('One per line — any format works'), findsOneWidget);
  });

  testWidgets('S3-41 Edit GitHub: Edit Item, the current code never the key, '
      'and the tags', (WidgetTester tester) async {
    await pumpHost(tester);
    await openEdit(tester);

    expect(find.text('Edit Item'), findsOneWidget);
    expect(find.text('GitHub'), findsWidgets);
    expect(find.text('Very strong'), findsOneWidget);
    await scrollTo(tester, find.text('Enter setup key'));
    expect(find.text('Scan QR code'), findsOneWidget);
    expect(find.bySemanticsLabel(RegExp('Current code')), findsOneWidget);
    expect(find.textContaining(kTotpKey), findsNothing);
    await scrollTo(tester, find.text('Add a tag'));
    expect(find.text('work'), findsOneWidget);
    expect(find.bySemanticsLabel('Remove tag dev'), findsOneWidget);
    expect(state(tester).canSave, isFalse);
    expect(tester.takeException(), isNull);
  });

  testWidgets('S3-42 / S3-43 the icon picker: Popular, then search; the pick '
      'is saved', (WidgetTester tester) async {
    await pumpHost(tester);
    await openEdit(tester);
    await tester.tap(find.text('Change icon'));
    await tester.pumpAndSettle();

    expect(find.text('Choose Icon'), findsOneWidget);
    expect(find.text('POPULAR'), findsOneWidget);
    expect(find.bySemanticsLabel('Key'), findsOneWidget);
    expect(find.bySemanticsLabel('Passport'), findsOneWidget);
    expect(find.text('Use default icon'), findsOneWidget);

    await tester.enterText(find.byType(EditableText).last, 'bank');
    await tester.pump();
    expect(find.textContaining('MATCHES'), findsOneWidget);
    await tester.tap(find.bySemanticsLabel('Building Columns'));
    await tester.pumpAndSettle();
    expect(state(tester).iconGlyph, 'f19c');

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(item('github')!.iconGlyph, 'f19c');
    await drain(tester);
  });

  testWidgets('S3-44 removing a field asks, names it, and happens on Save', (
    WidgetTester tester,
  ) async {
    await pumpHost(tester);
    await openEdit(tester);
    await tester.tap(find.bySemanticsLabel('Remove Website'));
    await tester.pumpAndSettle();
    expect(
      find.text('Are you sure you want to remove this field?'),
      findsOneWidget,
    );
    expect(
      find.text('“Website” and its value leave GitHub when you save.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Remove'));
    await tester.pumpAndSettle();
    expect(state(tester).fields, hasLength(3));
    expect(item('github')!.fields, hasLength(4));
  });

  testWidgets('S3-45 leaving with changes asks; without, it just closes', (
    WidgetTester tester,
  ) async {
    await pumpHost(tester);
    await openEdit(tester);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(EditItemScreen), findsNothing);

    await openEdit(tester);
    await tester.enterText(find.byType(EditableText).first, 'GitHub!');
    await tester.pump();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Discard changes?'), findsOneWidget);
    expect(
      find.text(
        'Your edits to GitHub have not been saved. Discarding keeps the item '
        'as it was.',
      ),
      findsOneWidget,
    );
    await tester.tap(find.text('Discard'));
    await tester.pumpAndSettle();
    expect(find.byType(EditItemScreen), findsNothing);
    expect(item('github')!.name, 'GitHub');
  });

  testWidgets('a new item asks only once something was typed', (
    WidgetTester tester,
  ) async {
    await pumpHost(tester);
    await openNew(tester, 'Note');
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(EditItemScreen), findsNothing);

    await openNew(tester, 'Note');
    await tester.enterText(find.byType(EditableText).first, 'Lock combo');
    await tester.pump();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.text('Discard this new item?'), findsOneWidget);
    expect(
      find.text('It has not been saved. Discarding throws it away.'),
      findsOneWidget,
    );
  });

  testWidgets('S3-46 Apple: an email that does not look like one, said once '
      'left; the phone\'s country; the date', (WidgetTester tester) async {
    await pumpHost(tester, editId: 'apple');
    await openEdit(tester);

    expect(find.text('+1'), findsOneWidget);
    expect(find.text('503-555-0142'), findsOneWidget);
    expect(find.text('Apr 12, 1992'), findsOneWidget);
    expect(find.text('name@example.com'), findsWidgets);

    final Finder email = find.byType(EditableText).at(2);
    await tester.enterText(email, 'jane.doe92@icloud');
    await tester.pump();
    expect(
      find.text('That does not look like an email address.'),
      findsNothing,
    );
    await tester.tap(find.text('Edit Item'));
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();
    expect(
      find.text('That does not look like an email address.'),
      findsOneWidget,
    );
  });

  testWidgets('the phone\'s country picker changes only the dial code', (
    WidgetTester tester,
  ) async {
    await pumpHost(tester, editId: 'apple');
    await openEdit(tester);
    await tester.tap(find.bySemanticsLabel(RegExp('Country code')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(EditableText).last, 'germ');
    await tester.pump();
    await tester.tap(find.text('Germany'));
    await tester.pumpAndSettle();
    expect(state(tester).fields[1].value, '+49 503-555-0142');
  });

  testWidgets('S3-47 Visa: a card number that fails its checksum', (
    WidgetTester tester,
  ) async {
    await pumpHost(tester, editId: 'visa');
    await openEdit(tester);
    final EditItemState s = state(tester);
    tester
        .element(find.byType(EditItemScreen))
        .read<EditItemCubit>()
        .setFieldValue(s.fields.first.key, '4111111111111112');
    await tester.pump();
    await tester.tap(find.bySemanticsLabel('Show secret').first);
    await tester.pump();
    await tester.showKeyboard(
      find.byWidgetPredicate(
        (Widget w) =>
            w is EditableText && w.controller.text == '4111111111111112',
      ),
    );
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();
    expect(
      find.text(
        'That number fails its checksum — one of the digits is probably '
        'wrong.',
      ),
      findsOneWidget,
    );
  });

  testWidgets('S3-50 / S3-51 tags: create one in its colour; too long says '
      'so', (WidgetTester tester) async {
    await pumpHost(tester);
    await openEdit(tester);
    await scrollTo(tester, find.text('Add a tag'));
    final Finder box = find.byType(EditableText).last;
    await tester.showKeyboard(box);
    await tester.enterText(box, 'travel');
    await tester.pump();
    expect(find.text('Create ‘travel’'), findsOneWidget);
    await tester.tap(find.text('Create ‘travel’'));
    await tester.pump();
    expect(state(tester).tags, <String>['work', 'dev', 'travel']);

    await tester.enterText(box, 'x' * 101);
    await tester.pump();
    expect(find.text('That name is too long.'), findsOneWidget);
    expect(find.textContaining('Create'), findsNothing);
  });

  testWidgets('S3-52 / S3-53 Generate: a passphrase by default, nothing in '
      'the field until used', (WidgetTester tester) async {
    await pumpHost(tester);
    await openNew(tester, 'Computer');
    await tester.tap(find.text('Generate'));
    await tester.pumpAndSettle();
    await tester.runAsync(() => Future<void>.delayed(Duration.zero));
    await tester.pumpAndSettle();

    expect(find.text('Generate a password'), findsOneWidget);
    expect(
      find.text('Nothing is filled in until you accept it.'),
      findsOneWidget,
    );
    expect(find.text('· 4 words'), findsOneWidget);
    expect(find.text('Word separator'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(state(tester).fields[1].value, isEmpty);

    await tester.tap(find.text('Random string'));
    await tester.pumpAndSettle();
    expect(find.text('· 20 characters'), findsOneWidget);
    expect(find.text('a–z'), findsOneWidget);
    await tester.tap(find.text('Use this password'));
    await tester.pumpAndSettle();
    final Field password = state(tester).fields[1].toField();
    expect(password.value, hasLength(20));
    expect(find.text('Very strong'), findsOneWidget);
  });

  testWidgets('a 2FA key, entered by hand', (WidgetTester tester) async {
    await pumpHost(tester);
    await openNew(tester, 'Authenticator');
    await tester.tap(find.text('Enter setup key'));
    await tester.pumpAndSettle();
    expect(find.byType(SetupKeyPage), findsOneWidget);
    expect(find.text('Spaces and capitals don’t matter.'), findsOneWidget);

    await tester.enterText(find.byType(EditableText).last, 'not a key!');
    await tester.pump();
    await tester.tap(find.text('Save code'));
    await tester.pump();
    expect(find.byType(SetupKeyPage), findsOneWidget);

    await tester.enterText(
      find.byType(EditableText).last,
      'jbsw y3dp ehpk 3pxp',
    );
    await tester.pump();
    await tester.tap(find.text('Save code'));
    await tester.pumpAndSettle();
    expect(find.byType(SetupKeyPage), findsNothing);
    expect(state(tester).fields.single.value, 'jbsw y3dp ehpk 3pxp');
    expect(find.bySemanticsLabel(RegExp('Current code')), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('a 2FA key from Scan QR code fills the field (Part 15)', (
    WidgetTester tester,
  ) async {
    await pumpHost(tester);
    getIt
      ..registerSingleton<CameraPermissionService>(world.camera)
      ..registerFactory<ScanCubit>(world.scanCubit);
    addTearDown(() async {
      await getIt.unregister<CameraPermissionService>();
      await getIt.unregister<ScanCubit>();
    });
    // No camera in tests: from "Camera access is off", typed.
    world.camera.access = CameraAccess.refused;
    await openNew(tester, 'Authenticator');
    await tester.tap(find.text('Scan QR code'));
    await tester.pumpAndSettle();
    expect(find.text('Camera access is off'), findsOneWidget);
    await tester.tap(find.text('Enter setup key instead'));
    await tester.pumpAndSettle();
    expect(find.text('Item'), findsNothing);
    await tester.enterText(find.byType(EditableText).last, 'JBSWY3DPEHPK3PXP');
    await tester.pump();
    await tester.tap(find.text('Save code'));
    await tester.pumpAndSettle();
    expect(find.byType(SetupKeyPage), findsNothing);
    expect(find.text('Camera access is off'), findsNothing);
    expect(state(tester).fields.single.value, 'JBSWY3DPEHPK3PXP');
    await tester.pumpWidget(const SizedBox());
  });
}
