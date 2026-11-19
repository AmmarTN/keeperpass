import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_icon_tile.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_checks.dart';

/// A field in edit mode (`.erow`, board C1): the grip to reorder, its own
/// tile (tap to change the icon), its name, the Secret chip, Remove, and the
/// editor underneath.
class AppEditFieldRow extends StatelessWidget {
  const AppEditFieldRow({
    required this.name,
    required this.glyph,
    required this.secret,
    required this.onSecretChanged,
    required this.onRemove,
    required this.onChangeIcon,
    required this.editor,
    this.onRename,
    this.nameField,
    this.reorderable = true,
    this.reorderIndex,
    super.key,
  });

  /// The field's name ("Password").
  final String name;

  /// The field's Font Awesome code point.
  final int glyph;
  final bool secret;
  final ValueChanged<bool> onSecretChanged;
  final VoidCallback onRemove;
  final VoidCallback onChangeIcon;

  /// The value editor ([AppTextField] / [AppSecretField] on the card surface).
  final Widget editor;

  /// Tapping the name renames the field.
  final VoidCallback? onRename;

  /// The name edited in place (`.enm` as a text box), instead of [onRename].
  final Widget? nameField;

  /// Without the grip (fields keep their order — your answer, Part 9).
  final bool reorderable;

  /// Inside a reorderable list: the grip starts the drag for this index.
  final int? reorderIndex;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    Widget grip = Semantics(
      button: true,
      label: t.common.reorderField(field: name),
      excludeSemantics: true,
      child: SizedBox(
        width: 26.w,
        child: Center(
          child: AppIcon(
            AppIconName.gripVertical,
            size: 18,
            stroke: 2,
            color: colors.mutedForeground,
          ),
        ),
      ),
    );
    if (reorderIndex != null) {
      grip = ReorderableDragStartListener(index: reorderIndex!, child: grip);
    }

    final Widget row = Row(
      crossAxisAlignment: reorderable
          ? CrossAxisAlignment.stretch
          : CrossAxisAlignment.start,
      spacing: 2.w,
      children: <Widget>[
        if (reorderable) grip,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8.h,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(minHeight: 36.h),
                child: Row(
                  spacing: 10.w,
                  children: <Widget>[
                    AppPressable(
                      onTap: onChangeIcon,
                      semanticLabel: t.common.changeFieldIcon(field: name),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9.r),
                      ),
                      child: AppIconTile(
                        AppTileGlyph(glyph),
                        size: AppTileSize.editField,
                        tone: AppTileTone.soft,
                      ),
                    ),
                    Expanded(
                      child:
                          nameField ??
                          AppPressable(
                            onTap: onRename,
                            isButton: onRename != null,
                            child: Text(
                              name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles(context)
                                  .formLabel()
                                  .resized(
                                    14,
                                    line: 20,
                                    weight: FontWeight.w700,
                                  )
                                  .copyWith(color: colors.accentStrong),
                            ),
                          ),
                    ),
                    AppToggleChip(
                      value: secret,
                      onChanged: onSecretChanged,
                      fieldName: name,
                    ),
                    Transform.translate(
                      offset: Offset(8.w, 0),
                      child: AppPressable(
                        onTap: onRemove,
                        semanticLabel: t.common.removeField(field: name),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: SizedBox.square(
                          dimension: 36.r,
                          child: Center(
                            child: AppIcon(
                              AppIconName.trash,
                              size: 18,
                              color: colors.mutedForeground,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              editor,
            ],
          ),
        ),
      ],
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(reorderable ? 2.w : 14.w, 12.h, 14.w, 14.h),
      // The grip spans the row's height; without it the row is as tall as
      // its content (an intrinsic height over a text field over-measures).
      child: reorderable ? IntrinsicHeight(child: row) : row,
    );
  }
}
