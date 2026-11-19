import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/text/tag_color.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/text/highlighted_text.dart';

/// How a tag is shown (board C3 "Tags").
enum AppTagChipStyle {
  /// `.lc` — the neutral pill in list rows (20 pt, 11 pt text).
  list,

  /// `.tchip` — the coloured chip in item detail (28 pt).
  detail,

  /// `.edtag` — removable, in edit (32 pt, with ×).
  editable,

  /// The small coloured preview beside "Create ‘travel’" (24 pt, 12 pt
  /// text, board `S3-50`).
  suggestion,
}

/// A tag: its glyph and name in the tag's own colour (web `tag-color.ts`).
class AppTagChip extends StatelessWidget {
  const AppTagChip(
    this.name, {
    this.style = AppTagChipStyle.detail,
    this.onRemove,
    this.highlight = const <String>[],
    super.key,
  }) : assert(style != AppTagChipStyle.editable || onRemove != null);

  final String name;
  final AppTagChipStyle style;
  final VoidCallback? onRemove;

  /// Search words to mark in the name (Vault search results).
  final List<String> highlight;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final Color tagColor = colors.tag(tagColorFor(name));
    final bool list = style == AppTagChipStyle.list;
    final TextStyle text = AppTextStyles(context)
        .badge()
        .resized(
          switch (style) {
            AppTagChipStyle.list => 11,
            AppTagChipStyle.suggestion => 12,
            _ => 13,
          },
          line: list ? 11 : (style == AppTagChipStyle.suggestion ? 16 : 18),
          weight: FontWeight.w700,
        )
        .copyWith(color: list ? colors.foreground : tagColor);

    return Container(
      height: switch (style) {
        AppTagChipStyle.list => 20,
        AppTagChipStyle.detail => 28,
        AppTagChipStyle.editable => 32,
        AppTagChipStyle.suggestion => 24,
      }.r,
      padding: EdgeInsets.only(
        left: switch (style) {
          AppTagChipStyle.list => 8,
          AppTagChipStyle.suggestion => 9,
          _ => 11,
        }.w,
        right: switch (style) {
          AppTagChipStyle.list => 8,
          AppTagChipStyle.detail => 11,
          AppTagChipStyle.editable => 4,
          AppTagChipStyle.suggestion => 9,
        }.w,
      ),
      decoration: ShapeDecoration(
        color: colors.secondary,
        shape: const StadiumBorder(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: (list ? 4 : 6).w,
        children: <Widget>[
          AppTagGlyph(
            name,
            size: switch (style) {
              AppTagChipStyle.list => 9,
              AppTagChipStyle.suggestion => 10,
              _ => 11,
            },
          ),
          Flexible(
            child: Text.rich(
              highlightedSpan(name, highlight),
              style: text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (style == AppTagChipStyle.editable)
            AppPressable(
              onTap: onRemove,
              semanticLabel: t.common.removeTag(tag: name),
              shape: const CircleBorder(),
              child: SizedBox.square(
                dimension: 28.r,
                child: Center(
                  child: AppIcon(
                    AppIconName.x,
                    size: AppIconSizes.xs,
                    stroke: 2.5,
                    color: colors.mutedForeground,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// `.more` — "+1" after the first tag in a list row.
class AppMoreCount extends StatelessWidget {
  const AppMoreCount(this.count, {super.key});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Text(
      '+$count',
      style: AppTextStyles(context)
          .badge()
          .resized(11, line: 13, weight: FontWeight.w700)
          .copyWith(color: context.colors.mutedForeground),
    );
  }
}

/// The tag glyph in the tag's own colour (web `tag-color.ts`).
class AppTagGlyph extends StatelessWidget {
  const AppTagGlyph(this.tag, {this.size = 12, super.key});

  final String tag;
  final double size;

  @override
  Widget build(BuildContext context) => FaGlyph(
    FaGlyphs.tag,
    size: size,
    color: context.colors.tag(tagColorFor(tag)),
  );
}
