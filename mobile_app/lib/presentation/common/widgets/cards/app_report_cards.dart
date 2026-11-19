import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_empty_and_loading.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';

/// A finding card of the Security report (`.fcard`, board C2): a header with
/// the finding's tile, title, count and ⓘ; the affected items; "Show all".
/// Without a [count] the tile is the accent one and there is no count: a
/// kind still being checked (board `S4-15`) or with nothing found.
class AppFindingCard extends StatelessWidget {
  const AppFindingCard({
    required this.icon,
    required this.title,
    required this.count,
    required this.infoLabel,
    required this.onInfo,
    required this.rows,
    this.onShowAll,
    super.key,
  });

  final AppIconName icon;

  /// "Reused Passwords".
  final String title;
  final int? count;

  /// "About Reused Passwords".
  final String infoLabel;
  final VoidCallback onInfo;

  /// [AppFindingRow]s.
  final List<Widget> rows;
  final VoidCallback? onShowAll;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Widget divider = SizedBox(
      height: 1,
      child: ColoredBox(color: colors.border),
    );
    return AppSurface(
      clip: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 58.h),
            child: Padding(
              padding: EdgeInsets.only(left: 14.w, right: 4.w),
              child: Row(
                spacing: 10.w,
                children: <Widget>[
                  AppIconTile(
                    AppTileIcon(icon),
                    size: AppTileSize.small,
                    tone: count == null
                        ? AppTileTone.accent
                        : AppTileTone.destructive,
                  ),
                  Expanded(
                    child: Semantics(
                      header: true,
                      child: Text(
                        title,
                        style: AppTextStyles(context)
                            .rowTitle()
                            .resized(16, line: 22, weight: FontWeight.w800)
                            .copyWith(color: colors.foreground),
                      ),
                    ),
                  ),
                  if (count != null) AppPill.count(count!, flagged: true),
                  AppIconButton(
                    icon: AppIconName.info,
                    semanticLabel: infoLabel,
                    onPressed: onInfo,
                    iconSize: AppIconSizes.md,
                    color: colors.mutedForeground,
                  ),
                ],
              ),
            ),
          ),
          for (int i = 0; i < rows.length; i++) ...<Widget>[divider, rows[i]],
          if (onShowAll != null) ...<Widget>[
            divider,
            AppPressable(
              onTap: onShowAll,
              child: SizedBox(
                height: 48.h,
                child: Padding(
                  padding: EdgeInsets.only(left: 14.w, right: 12.w),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          t.common.showAll(count: count ?? 0),
                          style: AppTextStyles(
                            context,
                          ).button().copyWith(color: colors.accentStrong),
                        ),
                      ),
                      AppIcon(
                        AppIconName.chevronRight,
                        size: 18,
                        stroke: 2,
                        color: colors.accentStrong,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// An affected item in a finding card (`.frow2`). Without [onTap] it only
/// informs — muted, no chevron (the breach check's progress, board `S4-15`).
class AppFindingRow extends StatelessWidget {
  const AppFindingRow({
    required this.tile,
    required this.name,
    required this.detail,
    required this.onTap,
    this.semanticLabel,
    super.key,
  });

  final Widget tile;
  final String name;

  /// "Same as Instagram and Facebook".
  final String detail;
  final VoidCallback? onTap;

  /// "Open Netflix".
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final bool informs = onTap == null;
    final Widget row = ConstrainedBox(
      constraints: BoxConstraints(minHeight: 64.h),
      child: Padding(
        padding: EdgeInsets.only(left: 14.w, right: 12.w),
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            tile,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 1.h,
                children: <Widget>[
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.rowTitle().copyWith(
                      color: informs
                          ? colors.mutedForeground
                          : colors.foreground,
                    ),
                  ),
                  Text(
                    detail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.secondary().copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
                ],
              ),
            ),
            if (!informs)
              AppIcon(
                AppIconName.chevronRight,
                size: 18,
                stroke: 2,
                color: colors.mutedForeground,
              ),
          ],
        ),
      ),
    );
    if (informs) return MergeSemantics(child: row);
    return AppPressable(
      onTap: onTap,
      pressedFill: colors.accent,
      semanticLabel: semanticLabel,
      child: row,
    );
  }
}

/// The health band.
enum AppHealthBand { strong, needsWork, atRisk }

/// The vault health card (`.hcard`, board C7): the score, its band and bar,
/// and what was checked. The bar fills over 500 ms ease-out the first time
/// it shows (board `Motion`; at once with Reduce Motion). While the first
/// check runs ([AppHealthCard.checking], board `S4-15`) the score waits as
/// a placeholder and the bar shows how far the check is.
class AppHealthCard extends StatelessWidget {
  const AppHealthCard({
    required this.title,
    required int this.score,
    required AppHealthBand this.band,
    required String this.bandLabel,
    required this.note,
    required this.semanticLabel,
    super.key,
  }) : progress = null,
       noteBusy = false;

  const AppHealthCard.checking({
    required this.title,
    required double this.progress,
    required this.note,
    super.key,
  }) : score = null,
       band = null,
       bandLabel = null,
       semanticLabel = null,
       noteBusy = true;

  /// "Vault health".
  final String title;

  /// 0–100; null while checking.
  final int? score;
  final AppHealthBand? band;

  /// "Needs work".
  final String? bandLabel;

  /// "16 items with a password checked"; "Checking for breaches · 9 of 16"
  /// after a spinner while checking.
  final String note;
  final bool noteBusy;

  /// "Vault health 75 percent".
  final String? semanticLabel;

  /// 0–1, while checking.
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final AppHealthBand? band = this.band;
    final (
      AppPillTone tone,
      AppIconName icon,
      Color track,
      Color fill,
    ) = switch (band) {
      null || AppHealthBand.strong => (
        AppPillTone.accent,
        AppIconName.circleCheck,
        colors.primary15,
        colors.primary,
      ),
      AppHealthBand.needsWork => (
        AppPillTone.warning,
        AppIconName.triangleAlert,
        colors.warningTint,
        colors.warning,
      ),
      AppHealthBand.atRisk => (
        AppPillTone.destructive,
        AppIconName.triangleAlert,
        colors.destructiveTint,
        colors.destructive,
      ),
    };
    final Duration fillDuration = AppMotion.reduceMotion(context)
        ? Duration.zero
        : AppMotion.fill;
    final int? score = this.score;
    final double filled = score != null ? score / 100 : progress ?? 0;

    final Widget bar = ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 6.r,
        child: ColoredBox(
          color: track,
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: filled),
            duration: fillDuration,
            curve: AppMotion.easeOut,
            builder: (BuildContext context, double value, _) =>
                FractionallySizedBox(
                  alignment: AlignmentDirectional.centerStart,
                  widthFactor: value,
                  child: DecoratedBox(
                    decoration: ShapeDecoration(
                      color: fill,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
          ),
        ),
      ),
    );

    return AppSurface(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 18.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            spacing: 10.w,
            children: <Widget>[
              const AppIconTile(
                AppTileIcon(AppIconName.shieldCheck),
                size: AppTileSize.small,
              ),
              Expanded(
                child: Text(
                  title,
                  style: styles
                      .button()
                      .resized(15, line: 20, weight: FontWeight.w700)
                      .copyWith(color: colors.foreground),
                ),
              ),
              if (bandLabel != null)
                AppPill.band(bandLabel!, tone: tone, icon: icon),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 60.h,
            child: score == null
                ? const Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AppSkeletonBlock(width: 124, height: 50),
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    spacing: 2.w,
                    children: <Widget>[
                      Text(
                        '$score',
                        textScaler: AppTextStyles.largeStyleTextScaler(context),
                        style: styles
                            .display()
                            .resized(
                              56,
                              line: 60,
                              weight: FontWeight.w800,
                              tracking: -0.03,
                            )
                            .copyWith(color: colors.foreground),
                      ),
                      Text(
                        '%',
                        textScaler: AppTextStyles.largeStyleTextScaler(context),
                        style: styles
                            .display()
                            .resized(
                              26,
                              line: 30,
                              weight: FontWeight.w800,
                              tracking: 0,
                            )
                            .copyWith(color: colors.mutedForeground),
                      ),
                    ],
                  ),
          ),
          SizedBox(height: 12.h),
          if (semanticLabel != null)
            Semantics(
              container: true,
              label: semanticLabel,
              image: true,
              excludeSemantics: true,
              child: bar,
            )
          else
            ExcludeSemantics(child: bar),
          SizedBox(height: 10.h),
          Row(
            spacing: 8.w,
            children: <Widget>[
              if (noteBusy) const AppSpinner(size: 14),
              Expanded(
                child: Text(
                  note,
                  style: styles.secondary().copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// A stat tile (`.stat`, board C7): the tile is red only when something is
/// flagged. [AppStatTile.waiting] is a kind still being checked (board
/// `S4-15`): a spinner in a neutral tile and a placeholder for the number.
class AppStatTile extends StatelessWidget {
  const AppStatTile({
    required this.icon,
    required int this.count,
    required this.label,
    required this.semanticLabel,
    required VoidCallback this.onTap,
    super.key,
  });

  const AppStatTile.waiting({
    required this.label,
    required this.semanticLabel,
    super.key,
  }) : icon = null,
       count = null,
       onTap = null;

  final AppIconName? icon;
  final int? count;

  /// "Weak".
  final String label;

  /// "Weak: 2"; "Compromised: not checked yet".
  final String semanticLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final int? count = this.count;
    final AppIconName? icon = this.icon;
    return AppPressable(
      onTap: onTap,
      semanticLabel: semanticLabel,
      isButton: onTap != null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: AppSurface(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (icon == null || count == null)
              const AppIconTile(
                AppTileChild(AppSpinner(size: 16)),
                size: AppTileSize.small,
                tone: AppTileTone.muted,
              )
            else
              AppIconTile(
                AppTileIcon(icon),
                size: AppTileSize.small,
                tone: count > 0 ? AppTileTone.destructive : AppTileTone.accent,
              ),
            if (count == null)
              Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
                child: const AppSkeletonBlock(width: 30, height: 28),
              )
            else ...<Widget>[
              SizedBox(height: 8.h),
              Text(
                '$count',
                textScaler: AppTextStyles.largeStyleTextScaler(context),
                style: styles
                    .stat()
                    .resized(30, line: 36, weight: FontWeight.w800, tracking: 0)
                    .copyWith(color: colors.foreground),
              ),
            ],
            SizedBox(height: 2.h),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: styles.badge().copyWith(color: colors.mutedForeground),
            ),
          ],
        ),
      ),
    );
  }
}
