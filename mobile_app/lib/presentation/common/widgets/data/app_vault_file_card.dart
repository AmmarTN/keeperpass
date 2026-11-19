import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';

/// The colour of the card's tile and badge.
enum AppVaultFileTone {
  /// Accent tint: resting, found, working, saved.
  accent,

  /// Neutral: an old vault kept as a backup.
  muted,

  /// Red tint: could not read or save it.
  destructive,
}

/// The round badge at the end of the card's header (`.vf-b`).
enum AppVaultFileBadge { check, working, lock, plus, failed }

/// The vault file as storage sees it (`.vf`, boards C7 and U2): its name,
/// what is happening to it, and below either a glimpse of the ciphertext,
/// a skeleton while looking for it, or one line. Its state changes instead
/// of the screen.
class AppVaultFileCard extends StatelessWidget {
  const AppVaultFileCard({
    required this.fileName,
    required this.meta,
    this.icon = AppIconName.fileLock,
    this.provider,
    this.tone = AppVaultFileTone.accent,
    this.badge = AppVaultFileBadge.check,
    this.cipherPreview,
    this.highlight,
    this.skeleton = false,
    this.note,
    this.tag,
    this.dim = false,
    this.width,
    super.key,
  });

  /// "vault.json.enc".
  final String fileName;

  /// "Argon2id · AES-256-GCM", "Looking in Google Drive…", "Not saved".
  final String meta;

  /// The tile's icon.
  final AppIconName icon;

  /// The provider's logo in a neutral tile instead of [icon] (while looking
  /// for the file).
  final AppProvider? provider;
  final AppVaultFileTone tone;
  final AppVaultFileBadge badge;

  /// The start of the ciphertext.
  final String? cipherPreview;

  /// While encrypting, the bytes being written, highlighted after
  /// [cipherPreview].
  final String? highlight;

  /// Two loading bars (`.vf-s`) instead of the ciphertext.
  final bool skeleton;

  /// One line (`.vf-e`) instead of the ciphertext.
  final String? note;

  /// A label riding on the top edge (`.vf-tag`): "What your storage sees".
  final String? tag;

  /// Resting shadow instead of lifted (`.vf.dim`): an old file.
  final bool dim;

  /// 300 by default.
  final double? width;

  bool get _hasBody =>
      cipherPreview != null || skeleton || (note?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);

    final Widget card = AppSurface(
      radius: 18,
      elevation: dim ? AppElevation.resting : AppElevation.lifted,
      padding: EdgeInsets.all(16.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            spacing: 12.w,
            children: <Widget>[
              AppIconTile(
                provider == null
                    ? AppTileIcon(icon)
                    : AppTileChild(AppProviderLogo(provider!, size: 20)),
                size: AppTileSize.file,
                tone: provider != null
                    ? AppTileTone.neutral
                    : switch (tone) {
                        AppVaultFileTone.accent => AppTileTone.accent,
                        AppVaultFileTone.muted => AppTileTone.muted,
                        AppVaultFileTone.destructive => AppTileTone.destructive,
                      },
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 2.h,
                  children: <Widget>[
                    Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: styles
                          .fileName()
                          .resized(14, line: 20, weight: FontWeight.w700)
                          .copyWith(color: colors.foreground),
                    ),
                    Text(
                      meta,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: styles
                          .secondary()
                          .resized(12, line: 16)
                          .copyWith(color: colors.mutedForeground),
                    ),
                  ],
                ),
              ),
              _Badge(badge: badge, tone: tone),
            ],
          ),
          if (_hasBody) ...<Widget>[
            Padding(
              padding: EdgeInsets.only(top: 14.h, bottom: 12.h),
              child: SizedBox(
                height: 1,
                child: ColoredBox(color: colors.hairline),
              ),
            ),
            SizedBox(height: 34.h, child: _body(context)),
          ],
        ],
      ),
    );

    return SizedBox(
      width: (width ?? 300).w,
      child: tag == null
          ? card
          : Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                card,
                PositionedDirectional(
                  start: 16.w,
                  top: -11.h,
                  child: _Tag(tag!),
                ),
              ],
            ),
    );
  }

  Widget _body(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    if (cipherPreview != null) {
      return ExcludeSemantics(
        child: Opacity(
          opacity: 0.75,
          child: Text.rich(
            TextSpan(
              style: styles
                  .fileName()
                  .resized(11, line: 17)
                  .copyWith(color: colors.mutedForeground),
              children: <InlineSpan>[
                TextSpan(text: cipherPreview),
                if (highlight != null)
                  TextSpan(
                    text: highlight,
                    style: TextStyle(
                      color: colors.accentStrong,
                      backgroundColor: colors.primary15,
                    ),
                  ),
              ],
            ),
            maxLines: 2,
            overflow: TextOverflow.clip,
          ),
        ),
      );
    }
    if (skeleton) {
      return ExcludeSemantics(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: <Widget>[
            for (final double fraction in <double>[0.92, 0.64])
              FractionallySizedBox(
                widthFactor: fraction,
                child: Container(
                  height: 7.r,
                  decoration: ShapeDecoration(
                    color: colors.secondary,
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
          ],
        ),
      );
    }
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        note!,
        style: styles
            .secondary()
            .resized(12, line: 17)
            .copyWith(color: colors.mutedForeground),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.badge, required this.tone});

  final AppVaultFileBadge badge;
  final AppVaultFileTone tone;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool failed = badge == AppVaultFileBadge.failed;
    final bool muted =
        tone == AppVaultFileTone.muted || badge == AppVaultFileBadge.lock;
    final Color background = failed || tone == AppVaultFileTone.destructive
        ? colors.destructiveTint
        : muted
        ? colors.secondary
        : colors.primary15;

    return Container(
      width: 28.r,
      height: 28.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: switch (badge) {
        AppVaultFileBadge.check => AppIcon(
          AppIconName.check,
          size: AppIconSizes.xs,
          stroke: 2.5,
          color: colors.accentStrong,
        ),
        AppVaultFileBadge.working => AppSpinner(
          size: 16,
          color: muted ? colors.mutedForeground : null,
        ),
        AppVaultFileBadge.lock => AppIcon(
          AppIconName.lock,
          size: 13,
          stroke: 2.25,
          color: colors.mutedForeground,
        ),
        AppVaultFileBadge.plus => AppIcon(
          AppIconName.plus,
          size: AppIconSizes.xs,
          stroke: 2.5,
          color: colors.accentStrong,
        ),
        AppVaultFileBadge.failed => AppIcon(
          AppIconName.x,
          size: AppIconSizes.xs,
          stroke: 2.5,
          color: colors.destructiveStrong,
        ),
      },
    );
  }
}

/// `.vf-tag`: a small capsule riding on the card's top edge.
class _Tag extends StatelessWidget {
  const _Tag(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Container(
      height: 22.h,
      padding: EdgeInsets.symmetric(horizontal: 9.w),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: colors.card,
        shape: StadiumBorder(side: BorderSide(color: colors.hairline)),
      ),
      child: Text(
        label.toUpperCase(),
        maxLines: 1,
        style: AppTextStyles(context)
            .secondary()
            .resized(10, line: 10, weight: FontWeight.w800)
            .copyWith(color: colors.mutedForeground, letterSpacing: 0.08 * 10),
      ),
    );
  }
}
