import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pill.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_tag_chip.dart';
import 'package:keeperpass/presentation/common/widgets/text/highlighted_text.dart';

/// An item row (`.r`, board C2): 40 pt tile, the name with its favourite star
/// and finding marker, one line, one tag pill (+N), and one-tap copy of the
/// item's main secret. Pressed rows take the accent fill; in selection mode a
/// round tick leads and the row tints when selected.
class AppItemRow extends StatelessWidget {
  const AppItemRow({
    required this.tile,
    required this.name,
    required this.subtitle,
    this.favorite = false,
    this.findingLabel,
    this.firstTag,
    this.moreTags = 0,
    this.copyLabel,
    this.onCopy,
    this.onTap,
    this.onLongPress,
    this.selected,
    this.highlight = const <String>[],
    super.key,
  });

  /// [AppIconTile] at [AppTileSize.item]: a letter on white or a glyph.
  final Widget tile;
  final String name;

  /// "janedoe-dev · Work".
  final String subtitle;
  final bool favorite;

  /// "Weak and reused password" — shows the red marker when set.
  final String? findingLabel;
  final String? firstTag;
  final int moreTags;

  /// "Copy password for GitHub"; the copy button shows when [onCopy] is set
  /// and the row is not in selection mode.
  final String? copyLabel;
  final VoidCallback? onCopy;
  final VoidCallback? onTap;

  /// The quick sheet (long-press on both platforms).
  final VoidCallback? onLongPress;

  /// Null outside selection mode; true / false shows the tick.
  final bool? selected;

  /// Search words to mark in the name, the line and the tag.
  final List<String> highlight;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final bool selecting = selected != null;

    final Widget body = Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 1.h,
        children: <Widget>[
          Row(
            spacing: 6.w,
            children: <Widget>[
              Flexible(
                child: Text.rich(
                  highlightedSpan(name, highlight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: styles.rowTitle().copyWith(color: colors.foreground),
                ),
              ),
              if (favorite)
                FaGlyph(
                  FaGlyphs.favourite,
                  size: 11,
                  weight: FaWeight.solid,
                  color: colors.accentStrong,
                ),
              if (findingLabel != null)
                AppPill.finding(semanticLabel: findingLabel!),
            ],
          ),
          Row(
            spacing: 6.w,
            children: <Widget>[
              Flexible(
                child: Text.rich(
                  highlightedSpan(subtitle, highlight),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: styles.secondary().copyWith(
                    color: colors.mutedForeground,
                  ),
                ),
              ),
              if (firstTag != null)
                AppTagChip(
                  firstTag!,
                  style: AppTagChipStyle.list,
                  highlight: highlight,
                ),
              if (moreTags > 0) AppMoreCount(moreTags),
            ],
          ),
        ],
      ),
    );

    final Widget row = Container(
      height: 68.h,
      padding: EdgeInsets.only(left: 14.w, right: 4.w),
      color: selected == true ? colors.primary10 : null,
      child: Row(
        spacing: 12.w,
        children: <Widget>[
          if (selecting) AppCheckCircle(checked: selected!),
          tile,
          body,
          if (selecting)
            SizedBox(width: 8.w)
          else if (onCopy != null)
            AppCopyButton(semanticLabel: copyLabel ?? name, onCopy: onCopy!),
        ],
      ),
    );

    return AppPressable(
      selected: selected == true,
      onTap: onTap,
      onLongPress: onLongPress,
      pressedFill: colors.accent,
      child: row,
    );
  }
}
