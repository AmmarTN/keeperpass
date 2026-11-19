import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// Where a field sits.
enum AppFieldSurface {
  /// On the screen background: card fill, hairline ring, soft shadow (`.fld`).
  screen,

  /// On a card or sheet: background fill and the hairline ring (`.fld.oc`).
  card,
}

/// The label row above a field (`.fl` / `.lbl`), with an optional trailing
/// action such as "Generate".
class AppFieldLabel extends StatelessWidget {
  const AppFieldLabel(this.label, {this.trailing, super.key});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 20.h),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: AppTextStyles(
                context,
              ).formLabel().copyWith(color: context.colors.foreground),
            ),
          ),
          if (trailing != null)
            // The board pulls the 44 pt link into the 20 pt label row
            // (negative margins): the row keeps its height, the link its
            // width.
            Align(
              heightFactor: 20.h / AppPressable.minTarget(context),
              child: trailing,
            ),
        ],
      ),
    );
  }
}

/// The red sentence under a field in error (`.msg`), announced when it
/// appears.
class AppFieldError extends StatelessWidget {
  const AppFieldError(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    final Color red = context.colors.destructiveStrong;
    return Semantics(
      liveRegion: true,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6.w,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: AppIcon(
              AppIconName.circleAlert,
              size: AppIconSizes.sm,
              color: red,
            ),
          ),
          Expanded(
            child: Text(
              message,
              style: AppTextStyles(context)
                  .secondary()
                  .resized(13, line: 18, weight: FontWeight.w600)
                  .copyWith(color: red),
            ),
          ),
        ],
      ),
    );
  }
}

/// The text field (board C1): 48 pt (56 large) with a 12 pt radius; focus is
/// the accent ring, an error the red ring plus a sentence; read-only fades.
/// Field actions (reveal, generate, pick a date) sit at the right edge.
class AppTextField extends StatefulWidget {
  const AppTextField({
    this.controller,
    this.focusNode,
    this.label,
    this.labelTrailing,
    this.placeholder,
    this.errorText,
    this.semanticLabel,
    this.surface = AppFieldSurface.screen,
    this.large = false,
    this.mono = false,
    this.readOnly = false,
    this.dimmed = false,
    this.enabled = true,
    this.obscureText = false,
    this.maxLines = 1,
    this.minHeight,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.autofillHints,
    this.inputFormatters,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.actions = const <Widget>[],
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final Widget? labelTrailing;
  final String? placeholder;

  /// Shows the red ring and this sentence under the field.
  final String? errorText;

  /// For fields without a visible label (the board's typed editors).
  final String? semanticLabel;
  final AppFieldSurface surface;

  /// The sign-in size (`.fld.lg`: 56 pt, 17 pt text).
  final bool large;

  /// Space Mono (`.fld.mono`) for secrets and codes.
  final bool mono;

  /// Not editable by typing (date and month fields open a picker instead).
  final bool readOnly;

  /// The read-only display state: faded to 60 % (`.fld.dim`).
  final bool dimmed;
  final bool enabled;
  final bool obscureText;

  /// Null grows with the text (multi-line editors).
  final int? maxLines;

  /// 116 for multi-line editors (`.tbx.ml`).
  final double? minHeight;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final bool autocorrect;
  final bool enableSuggestions;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;

  /// 44 pt action buttons at the right edge (`.acts`).
  final List<Widget> actions;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode? _ownFocusNode;
  FocusNode get _focusNode =>
      widget.focusNode ?? (_ownFocusNode ??= FocusNode());

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      (oldWidget.focusNode ?? _ownFocusNode)?.removeListener(_onFocusChanged);
      _focusNode.addListener(_onFocusChanged);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    _ownFocusNode?.dispose();
    super.dispose();
  }

  void _onFocusChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppShadows shadows = context.shadows;
    final AppTextStyles styles = AppTextStyles(context);
    final bool hasError = widget.errorText != null;
    final bool focused = _focusNode.hasFocus && !widget.readOnly;
    final bool multiLine = widget.maxLines != 1;

    final TextStyle textStyle = widget.mono
        ? styles.secret().resized(
            widget.large ? 17 : 15,
            line: 22,
            tracking: 0.02,
          )
        : styles.body().resized(widget.large ? 17 : 16, line: 22);

    final List<BoxShadow> ring = hasError
        ? shadows.error
        : focused
        ? shadows.focus
        : <BoxShadow>[
            if (widget.surface == AppFieldSurface.screen) ...shadows.shadowXs,
            BoxShadow(color: colors.hairline, spreadRadius: 1.r),
          ];

    final Widget input = TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      readOnly: widget.readOnly,
      enabled: widget.enabled,
      obscureText: widget.obscureText,
      obscuringCharacter: '•',
      maxLines: widget.obscureText ? 1 : widget.maxLines,
      keyboardType:
          widget.keyboardType ?? (multiLine ? TextInputType.multiline : null),
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      autocorrect: widget.autocorrect && !widget.obscureText,
      enableSuggestions: widget.enableSuggestions && !widget.obscureText,
      autofillHints: widget.autofillHints,
      inputFormatters: widget.inputFormatters,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onTap: widget.onTap,
      style: textStyle.copyWith(color: colors.foreground),
      cursorColor: colors.primary,
      cursorWidth: 2,
      decoration: InputDecoration.collapsed(
        hintText: widget.placeholder,
        hintStyle: textStyle.copyWith(color: colors.mutedForeground),
      ).copyWith(isDense: true),
    );

    final double height = (widget.large ? 56 : 48).h;
    Widget box = Container(
      constraints: BoxConstraints(minHeight: widget.minHeight?.h ?? height),
      padding: EdgeInsets.only(
        left: 16.w,
        right: widget.actions.isEmpty ? 16.w : 2.w,
        top: multiLine ? 13.h : 0,
        bottom: multiLine ? 13.h : 0,
      ),
      decoration: ShapeDecoration(
        color: widget.surface == AppFieldSurface.screen
            ? colors.card
            : colors.background,
        shape: AppRadius.shape(context, widget.large ? 14 : AppRadius.xl),
        shadows: ring,
      ),
      child: Row(
        crossAxisAlignment: multiLine
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(child: input),
          if (widget.actions.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: 12.w),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: widget.actions,
              ),
            ),
        ],
      ),
    );

    if (widget.dimmed) box = Opacity(opacity: 0.6, child: box);
    if (widget.semanticLabel != null) {
      box = Semantics(label: widget.semanticLabel, textField: true, child: box);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (widget.label != null) ...<Widget>[
          AppFieldLabel(widget.label!, trailing: widget.labelTrailing),
          SizedBox(height: 8.h),
        ],
        box,
        if (hasError) ...<Widget>[
          SizedBox(height: 6.h),
          AppFieldError(widget.errorText!),
        ],
      ],
    );
  }
}
