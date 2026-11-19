import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/cards/app_code_card.dart';
import 'package:keeperpass/presentation/common/widgets/cards/app_report_cards.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_avatar.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_totp_ring.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_unlock_dial.dart';
import 'package:keeperpass/presentation/common/widgets/data/app_vault_file_card.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_banner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_empty_and_loading.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_status.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_toast.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/copied_toast.dart';

import '../../../helpers/component_harness.dart';

const Widget _tile = AppIconTile(AppTileLetter('G'), tone: AppTileTone.white);

void main() {
  group('AppToastHost', () {
    testWidgets('shows a toast for 3 s', (WidgetTester tester) async {
      await pumpComponent(
        tester,
        Builder(
          builder: (BuildContext context) => AppButton(
            label: 'Move',
            onPressed: () => AppToastHost.of(context).show(
              const AppToastData(
                icon: AppIconName.folderInput,
                title: 'Moved 3 items to My Vault',
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Move'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Moved 3 items to My Vault'), findsOneWidget);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(find.text('Moved 3 items to My Vault'), findsNothing);
    });

    testWidgets('a clipboard toast stays for its countdown', (
      WidgetTester tester,
    ) async {
      await pumpComponent(
        tester,
        Builder(
          builder: (BuildContext context) => AppButton(
            label: 'Copy',
            onPressed: () => AppToastHost.of(context).show(
              const AppToastData(
                icon: AppIconName.clipboardCheck,
                title: 'Password copied',
                countdown: Duration(seconds: 10),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Copy'));
      await tester.pump(const Duration(seconds: 5));
      expect(find.text('Password copied'), findsOneWidget);
      await tester.pump(const Duration(seconds: 5));
      await tester.pumpAndSettle();
      expect(find.text('Password copied'), findsNothing);
    });

    testWidgets('a copy toast lasts the usual 3 s and says when the '
        'clipboard clears (your answer, 2026-11-03)', (
      WidgetTester tester,
    ) async {
      await pumpComponent(
        tester,
        Builder(
          builder: (BuildContext context) => AppButton(
            label: 'Copy',
            onPressed: () => AppToastHost.of(context).show(
              copiedToast(
                title: 'Password copied',
                from: 'From GitHub',
                clearsIn: const Duration(seconds: 30),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Copy'));
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('From GitHub · Clears in 30 s'), findsOneWidget);
      expect(find.byType(FractionallySizedBox), findsNothing);
      await tester.pump(const Duration(seconds: 3));
      await tester.pumpAndSettle();
      expect(find.text('Password copied'), findsNothing);
    });
  });

  testWidgets('AppBanner tones in both themes', (WidgetTester tester) async {
    await inBothThemes((Brightness brightness) async {
      await pumpComponent(
        tester,
        const Column(
          children: <Widget>[
            AppBanner(
              tone: AppBannerTone.error,
              icon: AppIconName.cloudOff,
              title: 'Your vault was not saved',
              key: Key('e'),
            ),
            AppBanner(
              tone: AppBannerTone.warning,
              icon: AppIconName.cloudAlert,
              title: 'Reconnect',
              key: Key('w'),
            ),
          ],
        ),
        brightness: brightness,
      );
      final AppColors colors = tester.element(find.byType(Column).first).colors;
      expect(
        fillUnder(tester, find.byKey(const Key('e'))),
        colors.destructiveTint,
      );
      expect(fillUnder(tester, find.byKey(const Key('w'))), colors.warningTint);
      expect(
        tester.widget<Text>(find.text('Your vault was not saved')).style!.color,
        colors.destructiveStrong,
      );
    });
  });

  testWidgets(
    'AppStrengthMeter: red only for Very weak and Weak; spoken as “Strength: …”',
    (WidgetTester tester) async {
      await pumpComponent(
        tester,
        Column(
          children: <Widget>[
            for (final AppStrength s in AppStrength.values) AppStrengthMeter(s),
          ],
        ),
      );
      final AppColors colors = tester.element(find.byType(Column).first).colors;
      expect(
        tester.widget<Text>(find.text('Weak')).style!.color,
        colors.destructiveStrong,
      );
      expect(
        tester.widget<Text>(find.text('Fair')).style!.color,
        colors.foreground,
      );
      expect(find.bySemanticsLabel('Strength: Very strong'), findsOneWidget);
    },
  );

  testWidgets(
    'spinners stand still under reduce motion; staged progress shows each state',
    (WidgetTester tester) async {
      await pumpComponent(
        tester,
        const AppStagedProgress(
          steps: <AppProgressStep>[
            AppProgressStep(
              label: 'Encrypting your vault',
              state: AppStepState.done,
            ),
            AppProgressStep(
              label: 'Saving to Google Drive…',
              state: AppStepState.running,
              progress: 0.64,
            ),
            AppProgressStep(
              label: 'Renaming the old file',
              state: AppStepState.failed,
              detail: 'Nothing was changed.',
            ),
          ],
        ),
        reduceMotion: true,
      );
      expect(findAppIcon(AppIconName.circleCheck), findsOneWidget);
      expect(find.byType(AppSpinner), findsOneWidget);
      expect(findAppIcon(AppIconName.circleX), findsOneWidget);
      expect(find.text('Nothing was changed.'), findsOneWidget);
      expect(tester.hasRunningAnimations, isFalse);
    },
  );

  testWidgets('saving pill, status line, empty state and skeleton render', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      Column(
        children: <Widget>[
          const AppSavingPill(
            state: AppSaveState.saved,
            label: 'Saved to Google Drive',
          ),
          const AppStatusLine(
            state: AppSaveState.notSaved,
            label: '1 change not saved',
          ),
          AppEmptyState(
            icon: const AppTileGlyph(FaGlyphs.tag),
            title: 'No tags yet',
            message: 'Tags are created from an item, or here.',
            action: AppButton(
              label: 'Add tag',
              expand: false,
              onPressed: () {},
            ),
          ),
          const AppSkeletonRows(semanticLabel: 'Loading'),
        ],
      ),
      reduceMotion: true,
    );
    expect(findAppIcon(AppIconName.cloudCheck), findsOneWidget);
    expect(findAppIcon(AppIconName.cloudOff), findsOneWidget);
    expect(find.text('No tags yet'), findsOneWidget);
    expect(find.bySemanticsLabel('Loading'), findsOneWidget);
  });

  group('2FA', () {
    testWidgets('the ring is spoken and turns amber in the last five seconds', (
      WidgetTester tester,
    ) async {
      await pumpComponent(
        tester,
        const Column(
          children: <Widget>[
            AppTotpCode(code: '482 913', secondsLeft: 24),
            AppTotpCode(code: '482 913', secondsLeft: 4),
          ],
        ),
      );
      expect(find.bySemanticsLabel('24 seconds left'), findsOneWidget);
      expect(find.bySemanticsLabel('4 seconds left'), findsOneWidget);
      expect(find.text('4 s'), findsOneWidget);
      final AppColors colors = tester.element(find.byType(Column).first).colors;
      expect(
        tester.widgetList<Text>(find.text('482 913')).last.style!.color,
        colors.warningStrong,
      );
      await pumpComponent(tester, const AppTotpRing(secondsLeft: 1));
      expect(find.bySemanticsLabel('1 second left'), findsOneWidget);
    });

    testWidgets('a code card copies; an invalid one offers the fix', (
      WidgetTester tester,
    ) async {
      int copies = 0;
      int fixes = 0;
      await pumpComponent(
        tester,
        Column(
          children: <Widget>[
            AppCodeCard(
              tile: _tile,
              name: 'GitHub',
              subtitle: 'Work',
              code: '482 913',
              secondsLeft: 24,
              copyLabel: 'Copy code for GitHub',
              onCopy: () => copies++,
            ),
            AppCodeCard.invalid(
              tile: _tile,
              name: 'Cloudflare',
              subtitle: 'My Vault',
              onFix: () => fixes++,
            ),
          ],
        ),
      );
      await tester.tap(find.bySemanticsLabel('Copy code for GitHub'));
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.text('Fix it in Edit'));
      expect(copies, 1);
      expect(fixes, 1);
      expect(find.text('Invalid code'), findsOneWidget);
    });
  });

  testWidgets('finding, health and stat cards', (WidgetTester tester) async {
    int shown = 0;
    await pumpComponent(
      tester,
      Column(
        children: <Widget>[
          AppFindingCard(
            icon: AppIconName.repeat2,
            title: 'Reused Passwords',
            count: 2,
            infoLabel: 'About Reused Passwords',
            onInfo: () {},
            onShowAll: () => shown++,
            rows: <Widget>[
              AppFindingRow(
                tile: _tile,
                name: 'Netflix',
                detail: 'Same as Instagram',
                onTap: () {},
              ),
            ],
          ),
          const AppHealthCard(
            title: 'Vault health',
            score: 75,
            band: AppHealthBand.needsWork,
            bandLabel: 'Needs work',
            note: '16 items checked',
            semanticLabel: 'Vault health 75 percent',
          ),
          AppStatTile(
            icon: AppIconName.shieldX,
            count: 0,
            label: 'Compromised',
            semanticLabel: 'Compromised: 0',
            onTap: () {},
          ),
        ],
      ),
    );
    await tester.tap(find.text('Show all 2'));
    expect(shown, 1);
    expect(find.text('75'), findsOneWidget);
    expect(find.bySemanticsLabel('Compromised: 0'), findsOneWidget);
    expect(find.bySemanticsLabel('Vault health 75 percent'), findsOneWidget);
  });

  testWidgets('health card and stat tile while the check runs (S4-15)', (
    WidgetTester tester,
  ) async {
    await pumpComponent(
      tester,
      const Column(
        children: <Widget>[
          AppStatTile.waiting(
            label: 'Weak',
            semanticLabel: 'Weak: not checked yet',
          ),
          AppHealthCard.checking(
            title: 'Vault health',
            progress: 0.5,
            note: 'Checking for breaches · 8 of 16',
          ),
        ],
      ),
      settle: false,
    );
    expect(find.bySemanticsLabel('Weak: not checked yet'), findsOneWidget);
    expect(find.text('Checking for breaches · 8 of 16'), findsOneWidget);
    // No score and no band until the check is done.
    expect(find.text('%'), findsNothing);
    expect(find.byType(AppPill), findsNothing);
  });

  testWidgets('avatar, vault file card and dial in their states', (
    WidgetTester tester,
  ) async {
    await inBothThemes((Brightness brightness) async {
      await pumpComponent(
        tester,
        const Column(
          children: <Widget>[
            AppAvatar(initials: 'JD', provider: AppProvider.google, size: 64),
            AppVaultFileCard(
              fileName: 'vault.json.enc',
              meta: 'Saved to Google Drive',
              cipherPreview: 'Q2lw',
            ),
            AppVaultFileCard(
              fileName: 'vault.json.enc',
              meta: 'Encrypting on this phone…',
              cipherPreview: 'Q2lw',
              highlight: '0a5e',
              icon: AppIconName.lockKeyhole,
              badge: AppVaultFileBadge.working,
            ),
            AppVaultFileCard(
              fileName: 'vault.json.enc',
              meta: 'Looking in Google Drive…',
              provider: AppProvider.google,
              badge: AppVaultFileBadge.working,
              skeleton: true,
              tag: 'What your storage sees',
            ),
            AppVaultFileCard(
              fileName: 'vault.json.enc',
              meta: 'Not saved',
              icon: AppIconName.cloudOff,
              tone: AppVaultFileTone.destructive,
              badge: AppVaultFileBadge.failed,
              note: 'Starts empty under your new secret.',
            ),
            AppUnlockDial(state: AppDialState.error, child: SizedBox()),
          ],
        ),
        brightness: brightness,
        settle: false,
      );
      expect(find.text('JD'), findsOneWidget);
      expect(find.byType(AppProviderLogo), findsNWidgets(2));
      expect(find.byType(AppSpinner), findsNWidgets(2));
      expect(findAppIcon(AppIconName.check), findsOneWidget);
      expect(find.text('WHAT YOUR STORAGE SEES'), findsOneWidget);
      expect(find.text('Starts empty under your new secret.'), findsOneWidget);
      expect(findAppIcon(AppIconName.x), findsOneWidget);
    });
  });
}
