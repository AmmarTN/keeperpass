import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';

/// A row of My Vaults or Tags (`.r`, boards `S5-01`, `S5-07`): the 40 pt
/// tile, the name with an optional badge ("Default"), one grey line, an
/// optional count and the chevron. With [selected] set it leads with the
/// round tick and tints when chosen (`.r.sel`, board `S5-08`); a row that
/// cannot be chosen is dimmed and has no tick.
class AppManageRow extends StatelessWidget {
  const AppManageRow({
    required this.tile,
    required this.title,
    required this.onTap,
    this.badge,
    this.subtitle,
    this.count,
    this.countLabel,
    this.height = 64,
    this.selected,
    this.selectable = true,
    this.onLongPress,
    super.key,
  });

  final Widget tile;
  final String title;

  /// "Default".
  final String? badge;

  /// "4 items · created Mar 3, 2026", "since Jan 4, 2025".
  final String? subtitle;

  /// The count pill ("7"), read as [countLabel] ("7 items").
  final int? count;
  final String? countLabel;

  /// 72 pt on My Vaults, 64 on Tags.
  final double height;

  /// Null outside selection mode.
  final bool? selected;
  final bool selectable;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final bool selecting = selected != null;
    final bool chosen = selected == true;
    final bool enabled = !selecting || selectable;

    final Widget row = Container(
      constraints: BoxConstraints(minHeight: height.h),
      padding: EdgeInsets.only(left: 14.w, right: 14.w),
      // Opaque, as `.r`: a swiped row slides over its actions.
      color: chosen
          ? Color.alphaBlend(colors.primary10, colors.card)
          : colors.card,
      child: Row(
        spacing: 12.w,
        children: <Widget>[
          if (selecting)
            selectable
                ? AppCheckCircle(checked: chosen)
                : SizedBox(width: 24.r),
          tile,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 1.h,
              children: <Widget>[
                Row(
                  spacing: 6.w,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: styles.rowTitle().copyWith(
                          color: colors.foreground,
                        ),
                      ),
                    ),
                    if (badge != null) AppPill.badge(badge!),
                  ],
                ),
                if (subtitle != null && subtitle!.isNotEmpty)
                  Text(
                    subtitle!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.secondary().copyWith(
                      color: colors.mutedForeground,
                    ),
                  ),
              ],
            ),
          ),
          if (count != null)
            Semantics(
              label: countLabel,
              excludeSemantics: countLabel != null,
              child: AppPill.count(count!),
            ),
          if (!selecting)
            AppIcon(
              AppIconName.chevronRight,
              size: 18,
              stroke: 2,
              color: colors.mutedForeground,
            ),
        ],
      ),
    );

    return AppPressable(
      enabled: enabled,
      selected: selecting && selectable ? chosen : null,
      onTap: onTap,
      onLongPress: onLongPress,
      pressedFill: colors.accent,
      child: row,
    );
  }
}
