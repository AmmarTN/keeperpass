import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// Search in a 12 pt pill (`.srch`): resting on the neutral fill, focused on
/// the card with the accent ring, and a clear button once there is a query.
class AppSearchField extends StatefulWidget {
  const AppSearchField({
    required this.controller,
    required this.placeholder,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    super.key,
  });

  final TextEditingController controller;

  /// "Search 23 items".
  final String placeholder;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<AppSearchField> createState() => _AppSearchFieldState();
}

class _AppSearchFieldState extends State<AppSearchField> {
  FocusNode? _ownFocusNode;
  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownFocusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_refresh);
    widget.controller.addListener(_refresh);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_refresh);
    widget.controller.removeListener(_refresh);
    _ownFocusNode?.dispose();
    super.dispose();
  }

  void _refresh() => setState(() {});

  void _clear() {
    widget.controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool focused = _focusNode.hasFocus;
    final TextStyle style = AppTextStyles(context).body().resized(16, line: 20);

    return Container(
      height: 40.h,
      padding: EdgeInsets.only(left: 10.w),
      decoration: ShapeDecoration(
        color: focused ? colors.card : colors.secondary,
        shape: AppRadius.shape(context, AppRadius.xl),
        shadows: focused ? context.shadows.focus : null,
      ),
      child: Row(
        spacing: 8.w,
        children: <Widget>[
          AppIcon(
            AppIconName.search,
            size: 18,
            stroke: 2,
            color: colors.mutedForeground,
          ),
          Expanded(
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
              textInputAction: TextInputAction.search,
              style: style.copyWith(color: colors.foreground),
              cursorColor: colors.primary,
              decoration: InputDecoration.collapsed(
                hintText: widget.placeholder,
                hintStyle: style.copyWith(color: colors.mutedForeground),
              ).copyWith(isDense: true),
            ),
          ),
          if (widget.controller.text.isNotEmpty)
            AppPressable(
              onTap: _clear,
              semanticLabel: t.common.clearSearch,
              shape: const CircleBorder(),
              child: SizedBox.square(
                dimension: 40.r,
                child: Center(
                  child: AppIcon(
                    AppIconName.x,
                    size: AppIconSizes.sm,
                    stroke: 2.25,
                    color: colors.mutedForeground,
                  ),
                ),
              ),
            )
          else
            SizedBox(width: 2.w),
        ],
      ),
    );
  }
}
