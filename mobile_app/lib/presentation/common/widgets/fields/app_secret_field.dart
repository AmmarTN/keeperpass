import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/widgets/buttons/app_icon_button.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_strength_meter.dart';
import 'package:keeperpass/presentation/common/widgets/fields/app_text_field.dart';

/// The secret field (board C1): masked by default; revealed in Space Mono with
/// tinted digits and symbols, wrapping; Generate rides in the label row and
/// the strength meter under it.
class AppSecretField extends StatefulWidget {
  const AppSecretField({
    required this.controller,
    this.label,
    this.labelTrailing,
    this.placeholder,
    this.errorText,
    this.strength,
    this.smallMeter = false,
    this.large = false,
    this.surface = AppFieldSurface.screen,
    this.initiallyRevealed = false,
    this.focusNode,
    this.keyboardType,
    this.autofocus = false,
    this.autofillHints,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.extraActions = const <Widget>[],
    super.key,
  });

  /// Use a `SecretTextEditingController` so the revealed value is tinted.
  final TextEditingController controller;
  final String? label;

  /// "Generate" ([AppLinkButton] at 14 pt) beside the label.
  final Widget? labelTrailing;
  final String? placeholder;
  final String? errorText;

  /// Shows the strength meter under the field.
  final AppStrength? strength;

  /// The small meter (`.fmeter`), as in an edit row.
  final bool smallMeter;

  /// The sign-in size.
  final bool large;
  final AppFieldSurface surface;
  final bool initiallyRevealed;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final bool autofocus;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  /// Actions before the reveal button (e.g. a field row's Generate).
  final List<Widget> extraActions;

  @override
  State<AppSecretField> createState() => _AppSecretFieldState();
}

class _AppSecretFieldState extends State<AppSecretField> {
  late bool _revealed = widget.initiallyRevealed;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.h,
      children: <Widget>[
        AppTextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          label: widget.label,
          labelTrailing: widget.labelTrailing,
          placeholder: widget.placeholder,
          errorText: widget.errorText,
          surface: widget.surface,
          large: widget.large,
          mono: true,
          obscureText: !_revealed,
          keyboardType: widget.keyboardType,
          autofocus: widget.autofocus,
          maxLines: _revealed ? null : 1,
          autocorrect: false,
          enableSuggestions: false,
          autofillHints: widget.autofillHints,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          actions: <Widget>[
            ...widget.extraActions,
            AppIconButton(
              icon: _revealed ? AppIconName.eyeOff : AppIconName.eye,
              semanticLabel: _revealed
                  ? t.common.hideSecret
                  : t.common.showSecret,
              variant: AppIconButtonVariant.field,
              color: _revealed ? colors.foreground : null,
              onPressed: () => setState(() => _revealed = !_revealed),
            ),
          ],
        ),
        if (widget.strength != null)
          widget.smallMeter
              ? AppStrengthMeter.small(widget.strength!)
              : AppStrengthMeter(widget.strength!),
      ],
    );
  }
}
