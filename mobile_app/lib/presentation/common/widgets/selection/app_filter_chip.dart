import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_tag_chip.dart';

/// A filter chip (`.fc`, board C3): off; on with a check; a finding filter
/// that clears with ×; and the "Manage tags" action.
class AppFilterChip extends StatelessWidget {
  const AppFilterChip({
    required this.label,
    required this.selected,
    required this.onPressed,
    this.leading,
    this.count,
    this.clearable = false,
    super.key,
  });

  /// A tag filter: the tag's glyph in its colour, and its item count.
  factory AppFilterChip.tag({
    required String tag,
    required int count,
    required bool selected,
    required VoidCallback onPressed,
    Key? key,
  }) => AppFilterChip(
    key: key,
    label: tag,
    count: count,
    selected: selected,
    onPressed: onPressed,
    leading: AppTagGlyph(tag),
  );

  final String label;
  final bool selected;
  final VoidCallback onPressed;

  /// Shown when off (a tag glyph, a Lucide icon); a check replaces it when
  /// on, unless the chip is [clearable].
  final Widget? leading;
  final int? count;

  /// A finding filter: keeps its icon when on and ends with ×.
  final bool clearable;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color foreground = selected ? colors.accentStrong : colors.foreground;
    final TextStyle text = AppTextStyles(
      context,
    ).secondary().resized(13, line: 18, weight: FontWeight.w700);

    final Widget? lead = selected && !clearable
        ? AppIcon(
            AppIconName.check,
            size: AppIconSizes.xs,
            stroke: 2.5,
            color: foreground,
          )
        : leading;

    return AppPressable(
      selected: selected,
      onTap: onPressed,
      shape: const StadiumBorder(),
      child: Container(
        height: 32.r,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: ShapeDecoration(
          color: selected ? colors.primary15 : colors.secondary,
          shape: StadiumBorder(
            side: selected
                ? BorderSide(color: colors.primary30, width: 1.r)
                : BorderSide.none,
          ),
        ),
        child: IconTheme.merge(
          data: IconThemeData(color: foreground),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6.w,
            children: <Widget>[
              ?lead,
              Text(label, style: text.copyWith(color: foreground)),
              if (count != null)
                Text(
                  '$count',
                  style: text.copyWith(
                    color: selected
                        ? colors.accentStrong
                        : colors.mutedForeground,
                  ),
                ),
              if (clearable && selected)
                AppIcon(
                  AppIconName.x,
                  size: AppIconSizes.xs,
                  stroke: 2.5,
                  color: foreground,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A row of filter chips that scrolls sideways (`.chips`).
class AppFilterChipBar extends StatelessWidget {
  const AppFilterChipBar({
    required this.children,
    this.semanticLabel,
    super.key,
  });

  final List<Widget> children;

  /// "Filter by tag".
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      container: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(spacing: 8.w, children: children),
      ),
    );
  }
}
