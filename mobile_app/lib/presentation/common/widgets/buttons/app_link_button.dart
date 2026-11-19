import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// Accent text actions (`.lnk`): "Generate", "Fix it in Edit", and the bar
/// actions — Back, Cancel, Save, Select. 44 pt tall at least.
class AppLinkButton extends StatelessWidget {
  const AppLinkButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.iconSize = AppIconSizes.sm,
    this.fontSize = 15,
    this.weight = FontWeight.w700,
    this.color,
    this.horizontalPadding = 8,
    this.gap = 6,
    this.semanticLabel,
    this.iconAfter = false,
    super.key,
  });

  /// A bar action at 17 pt: Cancel (400 in edit bars, 600 elsewhere), Select
  /// (600), Save (800).
  const AppLinkButton.bar({
    required this.label,
    required this.onPressed,
    this.weight = FontWeight.w600,
    this.horizontalPadding = 10,
    this.semanticLabel,
    super.key,
  }) : icon = null,
       iconSize = AppIconSizes.sm,
       fontSize = 17,
       color = null,
       gap = 6,
       iconAfter = false;

  /// "‹ All Vaults" — back with the previous screen's title.
  const AppLinkButton.back({
    required this.label,
    required this.onPressed,
    this.semanticLabel,
    super.key,
  }) : icon = AppIconName.chevronLeft,
       iconSize = 26,
       fontSize = 17,
       weight = FontWeight.w600,
       color = null,
       horizontalPadding = 0,
       gap = 0,
       iconAfter = false;

  final String label;

  /// Null disables it (`.lnk.off`, e.g. Save before there are changes).
  final VoidCallback? onPressed;
  final AppIconName? icon;
  final double iconSize;
  final double fontSize;
  final FontWeight weight;

  /// Accent-strong by default (red for destructive links).
  final Color? color;
  final double horizontalPadding;
  final double gap;
  final String? semanticLabel;

  /// The icon after the label ("English ⌄").
  final bool iconAfter;

  @override
  Widget build(BuildContext context) {
    final Color foreground = color ?? context.colors.accentStrong;
    final double stroke = icon == AppIconName.chevronLeft
        ? 2.25
        : AppIconSizes.strokeFor(iconSize);
    return AppPressable(
      onTap: onPressed,
      enabled: onPressed != null,
      semanticLabel: semanticLabel,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: AppPressable.minTarget(context)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: gap.w,
            children: <Widget>[
              if (icon != null && !iconAfter)
                AppIcon(
                  icon!,
                  size: iconSize,
                  stroke: stroke,
                  color: foreground,
                ),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context)
                      .button()
                      .resized(fontSize, line: 20, weight: weight)
                      .copyWith(color: foreground),
                ),
              ),
              if (icon != null && iconAfter)
                AppIcon(
                  icon!,
                  size: iconSize,
                  stroke: stroke,
                  color: foreground,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
