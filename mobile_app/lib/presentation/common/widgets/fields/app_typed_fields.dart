import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_date_picker.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';

/// The typed editors of board C1 ("phone with its country picker, date and
/// month with the system pickers, multi-line"). They sit on cards (`.oc`).

/// A country flag at the board's size: 24 × 16, 3 pt corners, 12 % ring.
/// The flag itself is a slot until the flag source is decided (Part 9).
class AppFlagFrame extends StatelessWidget {
  const AppFlagFrame({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 16.r,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3.r),
        boxShadow: <BoxShadow>[
          BoxShadow(color: AppFixedColors.flagRing, spreadRadius: 1.r),
        ],
      ),
      child: child,
    );
  }
}

/// Phone number with its country-code button.
class AppPhoneField extends StatelessWidget {
  const AppPhoneField({
    required this.controller,
    required this.dialCode,
    required this.countryName,
    required this.flag,
    required this.onPickCountry,
    required this.semanticLabel,
    this.errorText,
    this.placeholder,
    this.focusNode,
    this.onChanged,
    super.key,
  });

  final TextEditingController controller;

  /// "+1".
  final String dialCode;

  /// "United States" — for the button's spoken label.
  final String countryName;
  final Widget flag;
  final VoidCallback onPickCountry;

  /// The field's name ("Phone number").
  final String semanticLabel;
  final String? errorText;

  /// "Phone number".
  final String? placeholder;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final OutlinedBorder shape = AppRadius.shape(context, AppRadius.xl);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8.w,
      children: <Widget>[
        AppPressable(
          onTap: onPickCountry,
          semanticLabel: t.common.countryCodeValue(
            country: countryName,
            code: dialCode,
          ),
          shape: shape,
          child: Container(
            height: 48.h,
            padding: EdgeInsets.only(left: 12.w, right: 8.w),
            decoration: ShapeDecoration(
              color: colors.background,
              shape: shape,
              shadows: <BoxShadow>[
                BoxShadow(color: colors.hairline, spreadRadius: 1.r),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.w,
              children: <Widget>[
                // Emoji flags (your answer, Part 9): drawn as they are, no
                // frame.
                flag,
                Text(
                  dialCode,
                  style: AppTextStyles(context)
                      .bodyStrong()
                      .resized(16, line: 22)
                      .copyWith(color: colors.foreground),
                ),
                AppIcon(
                  AppIconName.chevronDown,
                  size: AppIconSizes.sm,
                  stroke: 2,
                  color: colors.mutedForeground,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: AppTextField(
            controller: controller,
            focusNode: focusNode,
            semanticLabel: semanticLabel,
            placeholder: placeholder,
            surface: AppFieldSurface.card,
            keyboardType: TextInputType.phone,
            errorText: errorText,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

/// A date or month field: shows the formatted value and opens the shared
/// wheel picker from the field or its calendar button.
class AppDateField extends StatefulWidget {
  const AppDateField({
    required this.semanticLabel,
    required this.valueText,
    required this.onPick,
    this.mode = AppDatePickerMode.date,
    this.label,
    this.placeholder,
    super.key,
  });

  /// The field's name ("Birthday", "Expires On").
  final String semanticLabel;

  /// "Apr 12, 1992", "08/2029".
  final String valueText;

  /// Called from the field or the button; usually opens [showAppDatePicker].
  final VoidCallback onPick;
  final AppDatePickerMode mode;
  final String? label;

  /// "Choose a date" while empty.
  final String? placeholder;

  @override
  State<AppDateField> createState() => _AppDateFieldState();
}

class _AppDateFieldState extends State<AppDateField> {
  late final TextEditingController _text = TextEditingController(
    text: widget.valueText,
  );

  @override
  void didUpdateWidget(covariant AppDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.valueText != widget.valueText) _text.text = widget.valueText;
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool month = widget.mode == AppDatePickerMode.month;
    return AppTextField(
      controller: _text,
      label: widget.label,
      semanticLabel: widget.semanticLabel,
      placeholder: widget.placeholder,
      surface: AppFieldSurface.card,
      readOnly: true,
      mono: month,
      onTap: widget.onPick,
      actions: <Widget>[
        AppIconButton(
          icon: AppIconName.calendar,
          semanticLabel: month ? t.common.chooseMonth : t.common.chooseDate,
          variant: AppIconButtonVariant.field,
          onPressed: widget.onPick,
        ),
      ],
    );
  }
}

/// A multi-line editor (`.tbx.ml`): 116 pt tall at least, growing with text.
class AppMultilineField extends StatelessWidget {
  const AppMultilineField({
    required this.controller,
    required this.semanticLabel,
    this.placeholder,
    this.mono = false,
    this.secret = false,
    this.focusNode,
    this.autofocus = false,
    this.onChanged,
    this.inputFormatters,
    this.actions = const <Widget>[],
    super.key,
  });

  final TextEditingController controller;
  final String semanticLabel;

  /// "One per line — any format works".
  final String? placeholder;
  final bool mono;

  /// A key or codes: no suggestions or autocorrect.
  final bool secret;
  final FocusNode? focusNode;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;

  /// The reveal button of a multi-line secret.
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      semanticLabel: semanticLabel,
      placeholder: placeholder,
      surface: AppFieldSurface.card,
      mono: mono,
      maxLines: null,
      minHeight: 116,
      autocorrect: !secret,
      enableSuggestions: !secret,
      keyboardType: TextInputType.multiline,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
      actions: actions,
    );
  }
}
