import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/core/utils/items/tag_choices.dart';
import 'package:keeperpass/core/utils/text/fold.dart';
import 'package:keeperpass/core/utils/validation/limits.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_surface.dart';
import 'package:keeperpass/presentation/common/widgets/selection/app_tag_chip.dart';

/// Tags while editing (boards `S3-50`, `S3-51`; web tag combobox): the
/// item's tags with ×, and a box that searches the vault's tags and offers
/// "Create ‘travel’" for a new name, in its own colour; a name over the
/// limit says "That name is too long." and offers nothing.
class TagEditor extends StatefulWidget {
  const TagEditor({
    required this.tags,
    required this.known,
    required this.onAdd,
    required this.onRemove,
    super.key,
  });

  final List<String> tags;

  /// Every tag the vault knows.
  final List<String> known;

  /// A picked tag (`typed: false`) or a new name.
  final bool Function(String tag, {bool typed}) onAdd;
  final ValueChanged<String> onRemove;

  @override
  State<TagEditor> createState() => _TagEditorState();
}

class _TagEditorState extends State<TagEditor> {
  final TextEditingController _typed = TextEditingController();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _focus.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _typed.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _add(String tag, {required bool typed}) {
    if (widget.onAdd(tag, typed: typed)) _typed.clear();
    setState(() {});
  }

  /// Return adds what was typed: an existing tag of that name, else a new
  /// one.
  void _submit(String text) {
    final String name = text.trim();
    if (name.isEmpty) return;
    final String? existing = widget.known
        .where((String tag) => foldText(tag) == foldText(name))
        .firstOrNull;
    if (existing != null) {
      _add(existing, typed: false);
    } else {
      _add(name, typed: true);
    }
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppTextStyles styles = AppTextStyles(context);
    final String typed = _typed.text;
    final bool tooLong = typed.trim().length > InputLimits.tagName;
    final ({List<String> existing, String? create}) choices = tagChoices(
      known: widget.known,
      onItem: widget.tags,
      typed: typed,
    );
    final bool suggest =
        _focus.hasFocus &&
        !tooLong &&
        (choices.existing.isNotEmpty || choices.create != null);

    final Widget box = Semantics(
      container: true,
      label: t.editItem.tags,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        decoration: ShapeDecoration(
          color: colors.card,
          shape: AppRadius.shape(context, AppRadius.xxl),
          shadows: <BoxShadow>[
            BoxShadow(color: colors.hairline, spreadRadius: 1.r),
            ...context.shadows.shadowXs,
            if (tooLong)
              ...context.shadows.error
            else if (_focus.hasFocus)
              ...context.shadows.focus,
          ],
        ),
        child: Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            for (final String tag in widget.tags)
              AppTagChip(
                tag,
                style: AppTagChipStyle.editable,
                onRemove: () => widget.onRemove(tag),
              ),
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 120.w, maxWidth: 320.w),
              child: IntrinsicWidth(
                child: SizedBox(
                  height: 32.h,
                  child: Center(
                    child: TextField(
                      controller: _typed,
                      focusNode: _focus,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: _submit,
                      style: styles
                          .body()
                          .resized(15, line: 20)
                          .copyWith(color: colors.foreground),
                      cursorColor: colors.accentStrong,
                      decoration: InputDecoration.collapsed(
                        hintText: t.editItem.addTag,
                        hintStyle: styles
                            .body()
                            .resized(15, line: 20)
                            .copyWith(color: colors.mutedForeground),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        box,
        if (tooLong)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Semantics(
              liveRegion: true,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 6.w,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 1.h),
                    child: AppIcon(
                      AppIconName.circleAlert,
                      size: 16,
                      stroke: 2,
                      color: colors.destructiveStrong,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      t.editItem.tagTooLong,
                      style: styles
                          .secondary()
                          .resized(13, line: 18, weight: FontWeight.w600)
                          .copyWith(color: colors.destructiveStrong),
                    ),
                  ),
                ],
              ),
            ),
          )
        else if (suggest)
          Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Semantics(
              container: true,
              label: t.editItem.tagSuggestions,
              child: AppSurface(
                radius: AppRadius.xxl,
                clip: true,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 260.h),
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      for (final String tag in choices.existing)
                        _SuggestionRow(
                          onTap: () => _add(tag, typed: false),
                          child: Row(
                            spacing: 10.w,
                            children: <Widget>[
                              AppTagGlyph(tag, size: 14),
                              Expanded(
                                child: Text(
                                  tag,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: styles
                                      .body()
                                      .resized(15, line: 20)
                                      .copyWith(color: colors.foreground),
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (choices.create != null)
                        _SuggestionRow(
                          onTap: () => _add(choices.create!, typed: true),
                          child: Row(
                            spacing: 10.w,
                            children: <Widget>[
                              AppIcon(
                                AppIconName.plus,
                                size: 18,
                                stroke: 2.25,
                                color: colors.accentStrong,
                              ),
                              Expanded(
                                child: Text(
                                  t.editItem.createTag(name: choices.create!),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: styles
                                      .body()
                                      .resized(15, line: 20)
                                      .copyWith(color: colors.foreground),
                                ),
                              ),
                              ExcludeSemantics(
                                child: AppTagChip(
                                  choices.create!,
                                  style: AppTagChipStyle.suggestion,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

/// `.srow` in the suggestions, 52 pt.
class _SuggestionRow extends StatelessWidget {
  const _SuggestionRow({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) => AppPressable(
    onTap: onTap,
    child: Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.colors.border)),
      ),
      child: child,
    ),
  );
}
