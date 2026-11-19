import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_small_button.dart';
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
import 'package:keeperpass/presentation/features/component_gallery/widgets/gallery_section.dart';

const String _cipher =
    'Q2lwaGVyVGV4dE9ubHlZb3VyU2VjcmV0Q2FuT3Blbg.7f3a9c2e1b8d4f60a5e2c9b1d7f4a8e3c6b0d9f2a1e5c8b7d4f3a6e9c2b5d8f1a4e7c0b3d6f9a2e5c8b1d4f7a0e3c6';

/// Board C6 · Feedback and status.
class GalleryFeedback extends StatelessWidget {
  const GalleryFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    return GallerySection(
      title: 'C6 · Feedback and status',
      children: <Widget>[
        GallerySpecimen(
          'Toasts — tap to show one above the bottom',
          child: Column(
            spacing: 10.h,
            children: <Widget>[
              const AppToast(
                AppToastData(
                  icon: AppIconName.clipboardCheck,
                  title: 'Password copied',
                  detail: 'From GitHub · Clears in 30 s',
                  countdown: Duration(seconds: 30),
                ),
                progress: AlwaysStoppedAnimation<double>(0.72),
              ),
              const AppToast(
                AppToastData(
                  icon: AppIconName.circleCheck,
                  title: 'Code added to Dropbox',
                  detail: 'Tap the card to copy it.',
                ),
              ),
              AppButton(
                label: 'Show a toast',
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.medium,
                onPressed: () => AppToastHost.of(context).show(
                  const AppToastData(
                    icon: AppIconName.folderInput,
                    title: 'Moved 3 items to My Vault',
                    detail: 'They keep their history and tags.',
                  ),
                ),
              ),
              AppButton(
                label: 'Show a clipboard toast',
                variant: AppButtonVariant.secondary,
                size: AppButtonSize.medium,
                onPressed: () => AppToastHost.of(context).show(
                  const AppToastData(
                    icon: AppIconName.clipboardCheck,
                    title: 'Password copied',
                    detail: 'From GitHub · Clears in 10 s',
                    countdown: Duration(seconds: 10),
                  ),
                ),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Saving — the pill, and the list’s status line',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10.h,
            children: const <Widget>[
              AppSavingPill(
                state: AppSaveState.working,
                label: 'Encrypting your vault…',
              ),
              AppSavingPill(
                state: AppSaveState.working,
                label: 'Saving to Google Drive…',
              ),
              AppSavingPill(
                state: AppSaveState.saved,
                label: 'Saved to Google Drive',
              ),
              AppStatusLine(
                state: AppSaveState.saved,
                label: '23 items · Saved to Google Drive',
              ),
              AppStatusLine(
                state: AppSaveState.working,
                label: 'Saving to Google Drive…',
              ),
              AppStatusLine(
                state: AppSaveState.notSaved,
                label: '1 change not saved',
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Banners — error, warning, neutral, info',
          child: Column(
            spacing: 10.h,
            children: <Widget>[
              AppBanner(
                tone: AppBannerTone.error,
                icon: AppIconName.cloudOff,
                title: 'Your vault was not saved',
                body: 'Google Drive could not be reached.',
                actions: <Widget>[
                  AppSmallButton(
                    label: 'Retry',
                    icon: AppIconName.rotateCw,
                    variant: AppSmallButtonVariant.outlined,
                    onPressed: galleryNoop,
                  ),
                  AppSmallButton(label: 'Dismiss', onPressed: galleryNoop),
                ],
              ),
              const AppBanner(
                tone: AppBannerTone.warning,
                icon: AppIconName.cloudAlert,
                title: 'Reconnect to Google Drive',
                body: 'Your Google session has expired. Please reconnect.',
              ),
              const AppBanner(
                tone: AppBannerTone.neutral,
                icon: AppIconName.wifiOff,
                title: 'You’re offline',
                body: 'You can keep reading and copying.',
              ),
              const AppBanner(
                tone: AppBannerTone.info,
                icon: AppIconName.info,
                title: 'Your phone restarted, so your secret is needed once.',
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Empty state',
          child: AppEmptyState(
            icon: const AppTileGlyph(FaGlyphs.tag),
            title: 'No tags yet',
            message: 'Tags are created from an item, or here.',
            action: AppButton(
              label: 'Add tag',
              icon: AppIconName.plus,
              expand: false,
              horizontalPadding: 22,
              onPressed: galleryNoop,
            ),
          ),
        ),
        const GallerySpecimen(
          'Skeleton — a list’s first load',
          child: AppSkeletonRows(semanticLabel: 'Loading'),
        ),
        const GallerySpecimen(
          'Staged progress — done, running, waiting, failed',
          child: AppStagedProgress(
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
                label: 'Checking the saved copy',
                state: AppStepState.waiting,
              ),
              AppProgressStep(
                label: 'Renaming the old file',
                state: AppStepState.failed,
                detail: 'Nothing was changed.',
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Strength meter — five steps',
          child: Column(
            spacing: 10.h,
            children: <Widget>[
              for (final AppStrength s in AppStrength.values)
                AppStrengthMeter(s),
            ],
          ),
        ),
        const GallerySpecimen(
          'Spinners — 14, 20, 28',
          child: GalleryWrap(
            children: <Widget>[
              AppSpinner(size: 14),
              AppSpinner(),
              AppSpinner(size: 28),
            ],
          ),
        ),
      ],
    );
  }
}

/// Board C7 · Tiles, badges and data.
class GalleryData extends StatelessWidget {
  const GalleryData({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return GallerySection(
      title: 'C7 · Tiles, badges and data',
      children: <Widget>[
        const GallerySpecimen(
          'Tiles — favicon, glyph, large, destructive, settings, provider, app icon',
          child: GalleryWrap(
            children: <Widget>[
              AppIconTile(AppTileLetter('G'), tone: AppTileTone.white),
              AppIconTile(AppTileGlyph(FaGlyphs.wifi)),
              AppIconTile(
                AppTileLetter('G'),
                size: AppTileSize.large,
                tone: AppTileTone.white,
              ),
              AppIconTile(AppTileGlyph(FaGlyphs.note), size: AppTileSize.large),
              AppIconTile(
                AppTileIcon(AppIconName.shieldAlert),
                tone: AppTileTone.destructive,
              ),
              AppIconTile(
                AppTileIcon(AppIconName.timer),
                size: AppTileSize.settings,
              ),
              AppIconTile(
                AppTileChild(AppProviderLogo(AppProvider.google, size: 16)),
                size: AppTileSize.settings,
                tone: AppTileTone.white,
              ),
              AppAppIcon(),
            ],
          ),
        ),
        GallerySpecimen(
          'Avatars and badges',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16.h,
            children: <Widget>[
              const GalleryWrap(
                children: <Widget>[
                  AppAvatar(initials: 'JD', provider: AppProvider.google),
                  SizedBox(width: 8),
                  AppAvatar(
                    initials: 'JD',
                    provider: AppProvider.dropbox,
                    size: 56,
                  ),
                  SizedBox(width: 8),
                  AppAvatar(
                    initials: 'JD',
                    provider: AppProvider.google,
                    size: 64,
                  ),
                ],
              ),
              GalleryWrap(
                children: <Widget>[
                  AppPill.badge('Default'),
                  AppPill.badge('Current Version'),
                  AppPill.newBadge('New'),
                  AppPill.count(7),
                  AppPill.count(3, flagged: true),
                  AppPill.finding(semanticLabel: 'Flagged'),
                  AppPill.band(
                    'Strong',
                    tone: AppPillTone.accent,
                    icon: AppIconName.shieldCheck,
                  ),
                  AppPill.band(
                    'Needs work',
                    tone: AppPillTone.warning,
                    icon: AppIconName.triangleAlert,
                  ),
                  AppPill.band(
                    'At risk',
                    tone: AppPillTone.destructive,
                    icon: AppIconName.triangleAlert,
                  ),
                  AppPill.vault(
                    'Work',
                    leading: FaGlyph(
                      FaGlyphs.vault,
                      size: 11,
                      color: colors.mutedForeground,
                    ),
                  ),
                  const AppPill(label: 'Last used', tone: AppPillTone.accent),
                ],
              ),
            ],
          ),
        ),
        const GallerySpecimen(
          'Health card',
          child: AppHealthCard(
            title: 'Vault health',
            score: 75,
            band: AppHealthBand.needsWork,
            bandLabel: 'Needs work',
            note: '16 items with a password checked',
            semanticLabel: 'Vault health 75 percent',
          ),
        ),
        const GallerySpecimen(
          'Health card — checking',
          child: AppHealthCard.checking(
            title: 'Vault health',
            progress: 9 / 16,
            note: 'Checking for breaches · 9 of 16',
          ),
        ),
        GallerySpecimen(
          'Stat tiles — red only when flagged',
          child: Row(
            spacing: 8.w,
            children: <Widget>[
              Expanded(
                child: AppStatTile(
                  icon: AppIconName.shieldAlert,
                  count: 2,
                  label: 'Weak',
                  semanticLabel: 'Weak: 2',
                  onTap: galleryNoop,
                ),
              ),
              Expanded(
                child: AppStatTile(
                  icon: AppIconName.repeat2,
                  count: 3,
                  label: 'Reused',
                  semanticLabel: 'Reused: 3',
                  onTap: galleryNoop,
                ),
              ),
              Expanded(
                child: AppStatTile(
                  icon: AppIconName.shieldX,
                  count: 0,
                  label: 'Compromised',
                  semanticLabel: 'Compromised: 0',
                  onTap: galleryNoop,
                ),
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Stat tile — still checking',
          child: Row(
            spacing: 8.w,
            children: const <Widget>[
              Spacer(flex: 2),
              Expanded(
                child: AppStatTile.waiting(
                  label: 'Compromised',
                  semanticLabel: 'Compromised: not checked yet',
                ),
              ),
            ],
          ),
        ),
        const GallerySpecimen('2FA ring — 24 s, 12 s, 4 s', child: _LiveRing()),
        const GallerySpecimen(
          'Small meter',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppStrengthMeter.small(AppStrength.veryStrong),
              AppStrengthMeter.small(AppStrength.weak),
            ],
          ),
        ),
        GallerySpecimen(
          'Vault card — ready, encrypting, saved, old',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 16.h,
            children: const <Widget>[
              AppVaultFileCard(
                fileName: 'vault.json.enc',
                meta: 'Argon2id · AES-256-GCM',
                cipherPreview: _cipher,
              ),
              AppVaultFileCard(
                fileName: 'vault.json.enc',
                meta: 'Encrypting on this phone…',
                cipherPreview:
                    'Q2lwaGVyVGV4dE9ubHlZb3VyU2VjcmV0Q2FuT3Blbg.7f3a9c2e1b8d4f6',
                highlight: '0a5e2c9b',
                icon: AppIconName.lockKeyhole,
                badge: AppVaultFileBadge.working,
              ),
              AppVaultFileCard(
                fileName: 'vault.json.enc',
                meta: 'Saved to Google Drive',
                cipherPreview: _cipher,
              ),
              AppVaultFileCard(
                fileName: 'vault.backup-2026-10-29T14-32-00.json.enc',
                meta: 'Old vault · locked under the old secret',
                icon: AppIconName.archive,
                tone: AppVaultFileTone.muted,
                badge: AppVaultFileBadge.lock,
                dim: true,
              ),
            ],
          ),
        ),
        GallerySpecimen(
          'Dial — resting, turning, ringing red',
          child: FittedBox(
            child: Row(
              spacing: 18.w,
              children: <Widget>[
                for (final AppDialState state in AppDialState.values)
                  AppUnlockDial(
                    state: state,
                    child: AppAvatar(
                      initials: 'JD',
                      provider: AppProvider.google,
                      size: 56,
                      badgeRing: colors.card,
                    ),
                  ),
              ],
            ),
          ),
        ),
        const GallerySpecimen(
          'Wordmark and icon',
          child: GalleryWrap(
            children: <Widget>[
              AppWordmark(),
              AppAppIcon(size: 56),
              AppAppIcon(),
            ],
          ),
        ),
      ],
    );
  }
}

/// Three rings, the first one counting down live.
class _LiveRing extends StatefulWidget {
  const _LiveRing();

  @override
  State<_LiveRing> createState() => _LiveRingState();
}

class _LiveRingState extends State<_LiveRing> {
  late final Stream<int> _seconds = Stream<int>.periodic(
    const Duration(seconds: 1),
    (int i) => 30 - ((6 + i) % 30),
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 18.w,
      children: <Widget>[
        StreamBuilder<int>(
          stream: _seconds,
          initialData: 24,
          builder: (BuildContext context, AsyncSnapshot<int> s) =>
              AppTotpRing(secondsLeft: s.data!, size: 28),
        ),
        const AppTotpRing(secondsLeft: 12, size: 28),
        const AppTotpRing(secondsLeft: 4, size: 28),
        const AppTotpCode(code: '482 913', secondsLeft: 24),
      ],
    );
  }
}
