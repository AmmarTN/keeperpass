import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// A row in a sheet group (`.srow`, board C5): an icon, the label, an
/// optional count, and a check on the chosen row or a chevron. Put rows in
/// `AppInsetGroup.sheet`.
class AppSheetRow extends StatelessWidget {
  const AppSheetRow({
    required this.label,
    required this.onTap,
    this.leading,
    this.count,
    this.selected,
    this.chevron = false,
    this.trailingText,
    super.key,
  });

  final String label;

  /// Null: the row can't be picked (the Move sheet's "Current" vault).
  final VoidCallback? onTap;

  /// An `AppIcon` (20 pt) or a vault glyph.
  final Widget? leading;
  final int? count;

  /// Null outside one-of groups; true draws the check and the bold label.
  final bool? selected;
  final bool chevron;

  /// A muted note at the end ("Current").
  final String? trailingText;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool isSelected = selected == true;
    final Widget row = SizedBox(
      height: 52.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          spacing: 12.w,
          children: <Widget>[
            if (leading != null)
              IconTheme.merge(
                data: IconThemeData(
                  color: isSelected ? colors.accentStrong : colors.foreground,
                ),
                child: leading!,
              ),
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(context)
                    .body()
                    .resized(
                      16,
                      line: 22,
                      weight: isSelected ? FontWeight.w700 : FontWeight.w400,
                    )
                    .copyWith(color: colors.foreground),
              ),
            ),
            if (count != null) AppPill.count(count!),
            if (trailingText != null)
              Text(
                trailingText!,
                style: AppTextStyles(
                  context,
                ).secondary().copyWith(color: colors.mutedForeground),
              ),
            if (selected != null)
              SizedBox(
                width: 18.r,
                child: isSelected
                    ? AppIcon(
                        AppIconName.check,
                        size: 18,
                        stroke: 2.5,
                        color: colors.accentStrong,
                      )
                    : null,
              ),
            if (chevron)
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
    return AppPressable(
      onTap: onTap,
      isButton: selected == null,
      inMutuallyExclusiveGroup: selected != null,
      checked: selected == null ? null : isSelected,
      child: row,
    );
  }
}

/// The quick sheet's header (`.qhead`): the item's tile, name, line, and the
/// favourite pill.
class AppQuickHeader extends StatelessWidget {
  const AppQuickHeader({
    required this.tile,
    required this.name,
    required this.subtitle,
    this.trailing,
    super.key,
  });

  final Widget tile;
  final String name;
  final String subtitle;

  /// `AppPill.vault` — "★ Favorite".
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    return Row(
      spacing: 12.w,
      children: <Widget>[
        tile,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styles.navTitle().copyWith(color: colors.foreground),
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styles.secondary().copyWith(
                  color: colors.mutedForeground,
                ),
              ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}

/// A field chip of the quick sheet (`.fchip`): the field's glyph and name, and
/// its value; tapping copies it.
class AppFieldChip extends StatelessWidget {
  const AppFieldChip({
    required this.glyph,
    required this.label,
    required this.value,
    required this.onTap,
    this.semanticLabel,
    super.key,
  });

  final int glyph;

  /// "Username".
  final String label;

  /// The value line (text, dots, or a code with its ring).
  final Widget value;
  final VoidCallback onTap;

  /// "Copy username".
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.r),
      side: BorderSide(color: colors.hairline, width: 1.r),
    );
    return AppPressable(
      onTap: onTap,
      semanticLabel: semanticLabel,
      shape: shape,
      child: Container(
        constraints: BoxConstraints(minHeight: 60.h),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: ShapeDecoration(color: colors.background, shape: shape),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 3.h,
          children: <Widget>[
            Row(
              spacing: 6.w,
              children: <Widget>[
                FaGlyph(glyph, size: 11, color: colors.accentStrong),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles(
                      context,
                    ).fieldLabel().copyWith(color: colors.mutedForeground),
                  ),
                ),
              ],
            ),
            DefaultTextStyle.merge(
              style: AppTextStyles(
                context,
              ).body().resized(15, line: 20).copyWith(color: colors.foreground),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              child: value,
            ),
          ],
        ),
      ),
    );
  }
}

/// An action row of the quick sheet (`.qrow`): a 22 pt icon and the label;
/// destructive in red.
class AppQuickActionRow extends StatelessWidget {
  const AppQuickActionRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.destructive = false,
    super.key,
  });

  final AppIconName icon;
  final String label;
  final VoidCallback onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color color = destructive
        ? colors.destructiveStrong
        : colors.foreground;
    return AppPressable(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 50.h),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            spacing: 14.w,
            children: <Widget>[
              AppIcon(icon, size: 22, color: color),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles(
                    context,
                  ).body().resized(16, line: 22).copyWith(color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
