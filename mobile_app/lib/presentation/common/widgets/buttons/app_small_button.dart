import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// Small-button styles (`.sb`).
enum AppSmallButtonVariant {
  /// No fill — "Dismiss".
  plain,

  /// Card with the hairline ring — "Retry".
  outlined,

  /// Accent fill.
  primary,
}

/// The 36 pt banner action (`.sb`): Retry, Dismiss.
class AppSmallButton extends StatelessWidget {
  const AppSmallButton({
    required this.label,
    required this.onPressed,
    this.variant = AppSmallButtonVariant.plain,
    this.icon,
    this.leading,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppSmallButtonVariant variant;
  final AppIconName? icon;

  /// Instead of [icon]: a logo ("Reconnect" with Google's, board
  /// `Sync-states`).
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color foreground = variant == AppSmallButtonVariant.primary
        ? colors.primaryForeground
        : colors.foreground;
    final OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.r),
    );

    return AppPressable(
      onTap: onPressed,
      enabled: onPressed != null,
      shape: shape,
      child: Container(
        height: 36.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: switch (variant) {
          AppSmallButtonVariant.plain => null,
          AppSmallButtonVariant.outlined => ShapeDecoration(
            color: colors.card,
            shape: shape,
            shadows: <BoxShadow>[
              ...context.shadows.shadowXs,
              BoxShadow(color: colors.hairline, spreadRadius: 1.r),
            ],
          ),
          AppSmallButtonVariant.primary => ShapeDecoration(
            color: colors.primary,
            shape: shape,
          ),
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6.w,
          children: <Widget>[
            ?leading,
            if (icon != null && leading == null)
              AppIcon(icon!, size: 15, stroke: 2.25, color: foreground),
            Text(
              label,
              style: AppTextStyles(context)
                  .button()
                  .resized(14, line: 20, weight: FontWeight.w700)
                  .copyWith(color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pill-shaped small actions: Generate (`.gen`, 34 pt, accent tint), Fill
/// (`.pill`, 28 pt, accent fill) and the "Copied" confirmation (accent tint
/// with a check).
class AppPillButton extends StatelessWidget {
  const AppPillButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.solid = false,
    this.height = 28,
    super.key,
  });

  /// `.gen` — "Generate" with the wand.
  const AppPillButton.generate({
    required this.label,
    required this.onPressed,
    super.key,
  }) : icon = AppIconName.wandSparkles,
       solid = false,
       height = 34;

  final String label;
  final VoidCallback? onPressed;
  final AppIconName? icon;

  /// Accent fill ("Fill") instead of the accent tint.
  final bool solid;
  final double height;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color background = solid ? colors.primary : colors.primary15;
    final Color foreground = solid
        ? colors.primaryForeground
        : colors.accentStrong;
    final bool generate = icon == AppIconName.wandSparkles;

    return AppPressable(
      onTap: onPressed,
      enabled: onPressed != null,
      shape: const StadiumBorder(),
      child: Container(
        height: height.h,
        padding: EdgeInsets.only(left: (generate ? 10 : 12).w, right: 12.w),
        decoration: ShapeDecoration(
          color: background,
          shape: const StadiumBorder(),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 6.w,
          children: <Widget>[
            if (icon != null)
              AppIcon(
                icon!,
                size: generate ? 15 : AppIconSizes.xs,
                stroke: generate ? 2 : 2.5,
                color: foreground,
              ),
            Text(
              label,
              style: AppTextStyles(context)
                  .badge()
                  .resized(
                    generate ? 13 : 12,
                    line: 16,
                    weight: FontWeight.w700,
                  )
                  .copyWith(color: foreground),
            ),
          ],
        ),
      ),
    );
  }
}
