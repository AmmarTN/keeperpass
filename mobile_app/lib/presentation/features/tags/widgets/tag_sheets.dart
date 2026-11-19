import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/items/field_editing.dart';
import 'package:keeperpass/core/utils/items/tag_changes.dart';
import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/bottom_sheet/app_sheet.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_button.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_tag_chip.dart';

/// "Add Tag" (board `S5-09`, web `TagsPage` add): a name not yet in use,
/// previewed in the colour it gets from its name. Resolves to the name.
Future<String?> showAddTagSheet(
  BuildContext context, {
  required Set<String> taken,
}) =>
    showAppSheet<String>(context, builder: (_) => _TagNameSheet(taken: taken));

/// "Rename Tag" (board `S5-10`, web `TagsPage` rename): a name another tag
/// has says the two would merge, and — as the web — cannot be used (your
/// answer, Part 12). Resolves to the new name.
Future<String?> showRenameTagSheet(
  BuildContext context, {
  required TagInfo tag,
  required Set<String> taken,
}) => showAppSheet<String>(
  context,
  builder: (_) => _TagNameSheet(taken: taken, renaming: tag),
);

class _TagNameSheet extends StatefulWidget {
  const _TagNameSheet({required this.taken, this.renaming});

  final Set<String> taken;

  /// Null when adding.
  final TagInfo? renaming;

  @override
  State<_TagNameSheet> createState() => _TagNameSheetState();
}

class _TagNameSheetState extends State<_TagNameSheet> {
  late final TextEditingController _name = TextEditingController(
    text: widget.renaming?.name ?? '',
  );

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  String get _trimmed => jsTrim(_name.text);

  bool get _duplicate =>
      _trimmed.isNotEmpty &&
      _trimmed != widget.renaming?.name &&
      widget.taken.contains(_trimmed);

  bool get _canSave =>
      _trimmed.isNotEmpty && tagNameValid(_name.text) && !_duplicate;

  void _save() {
    if (!_canSave) return;
    AppHaptics.selection();
    Navigator.of(context).pop(_trimmed);
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final TagInfo? renaming = widget.renaming;
    final TextStyle note = styles.secondary().resized(13, line: 18);

    return AppSheet(
      title: renaming == null ? t.tags.addTitle : t.tags.renameTitle,
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 14.h,
        children: <Widget>[
          Text(
            renaming == null ? t.tags.addBody : t.tags.renameBody,
            style: styles.body().copyWith(color: colors.mutedForeground),
          ),
          if (renaming != null)
            Row(
              spacing: 8.w,
              children: <Widget>[
                AppTagChip(renaming.name),
                Text(
                  t.tags.itemCount(n: renaming.count),
                  style: note.copyWith(color: colors.mutedForeground),
                ),
              ],
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8.h,
            children: <Widget>[
              AppTextField(
                controller: _name,
                label: t.tags.tagName,
                autofocus: true,
                textInputAction: TextInputAction.done,
                inputFormatters: <TextInputFormatter>[
                  LengthLimitingTextInputFormatter(InputLimits.tagName),
                ],
                // Adding, a taken name is an error; renaming onto one is a
                // merge, said in amber below (board `S5-10`).
                errorText: _duplicate && renaming == null
                    ? t.tags.duplicate
                    : null,
                onChanged: (_) => setState(() {}),
                onSubmitted: (_) => _save(),
              ),
              if (renaming != null && _duplicate)
                Semantics(
                  liveRegion: true,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6.w,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: AppIcon(
                          AppIconName.triangleAlert,
                          size: 16,
                          stroke: 2,
                          color: colors.warningStrong,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          t.tags.mergeNotice(name: _trimmed),
                          style: note
                              .copyWith(fontWeight: FontWeight.w600)
                              .copyWith(color: colors.warningStrong),
                        ),
                      ),
                    ],
                  ),
                )
              else if (renaming == null && _trimmed.isNotEmpty && !_duplicate)
                Row(
                  spacing: 8.w,
                  children: <Widget>[
                    AppTagChip(_trimmed),
                    Expanded(
                      child: Text(
                        t.tags.colorNote,
                        style: note.copyWith(color: colors.mutedForeground),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          AppButton(
            label: renaming == null ? t.tags.addTag : t.common.rename,
            onPressed: _canSave ? _save : null,
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
