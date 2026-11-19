import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/text/secret_text.dart';

/// A row of the item detail's field list (`.frow`, board C2): the field's
/// tile, its name as the label, the value and its actions. Copying swaps the
/// label to "✓ Copied" for 1 s and shows the check on the copy button.
class AppFieldRow extends StatefulWidget {
  const AppFieldRow({
    required this.tile,
    required this.label,
    required this.value,
    this.below,
    this.actions = const <Widget>[],
    this.copyLabel,
    this.onCopy,
    this.alignTop = false,
    this.labelTrailing,
    super.key,
  });

  /// [AppIconTile] at `AppTileSize.field`, `AppTileTone.soft`.
  final Widget tile;

  /// The field's name ("Username").
  final String label;

  /// [AppFieldText], [AppFieldHidden], [AppFieldSecret], [AppFieldCode] …
  final Widget value;

  /// Under the value: the small meter, "Show in large type", an explanation.
  final Widget? below;

  /// Actions before the copy button (reveal, open, call, message).
  final List<Widget> actions;

  /// "Copy username"; the copy button shows when [onCopy] is set.
  final String? copyLabel;
  final VoidCallback? onCopy;

  /// For multi-line values (`.frow.top`).
  final bool alignTop;

  /// After the name (`.flab` wraps with a 6 pt gap): "Changed since".
  final Widget? labelTrailing;

  @override
  State<AppFieldRow> createState() => _AppFieldRowState();
}

class _AppFieldRowState extends State<AppFieldRow> {
  bool _copied = false;
  Timer? _reset;

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  void _copy() {
    widget.onCopy!();
    _reset?.cancel();
    setState(() => _copied = true);
    _reset = Timer(AppMotion.copiedHold, () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final TextStyle labelStyle = AppTextStyles(context).fieldLabel();

    final Widget label = _copied
        ? Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4.w,
            children: <Widget>[
              AppIcon(
                AppIconName.check,
                size: 13,
                stroke: 2.5,
                color: colors.accentStrong,
              ),
              Text(
                t.common.copied,
                style: labelStyle.copyWith(color: colors.accentStrong),
              ),
            ],
          )
        : Text(
            widget.label,
            style: labelStyle.copyWith(color: colors.mutedForeground),
          );
    final Widget labelLine = widget.labelTrailing == null
        ? label
        : Wrap(
            spacing: 6.w,
            runSpacing: 2.h,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[label, widget.labelTrailing!],
          );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 66.h),
      child: Padding(
        padding: EdgeInsets.fromLTRB(14.w, 11.h, 4.w, 11.h),
        child: Row(
          crossAxisAlignment: widget.alignTop
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          spacing: 14.w,
          children: <Widget>[
            widget.tile,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 2.h,
                children: <Widget>[
                  Semantics(liveRegion: _copied, child: labelLine),
                  widget.value,
                  ?widget.below,
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ...widget.actions,
                if (widget.onCopy != null)
                  AppPressable(
                    onTap: _copy,
                    haptic: AppHaptics.copy,
                    semanticLabel: widget.copyLabel ?? widget.label,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: SizedBox.square(
                      dimension: AppPressable.minTarget(context),
                      child: Center(
                        child: AppIcon(
                          _copied ? AppIconName.check : AppIconName.copy,
                          size: AppIconSizes.md,
                          color: _copied
                              ? colors.accentStrong
                              : colors.mutedForeground,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A plain value (`.fval`): 16 / 22, wrapping anywhere; "[empty]" muted.
class AppFieldText extends StatelessWidget {
  const AppFieldText(this.text, {this.leading, this.bold = false, super.key});

  /// "[empty]" when there is no value.
  const AppFieldText.empty({super.key})
    : text = null,
      leading = null,
      bold = false;

  final String? text;

  /// A flag before a phone number.
  final Widget? leading;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final TextStyle style = AppTextStyles(context)
        .body()
        .resized(16, line: 22, weight: bold ? FontWeight.w700 : FontWeight.w400)
        .copyWith(
          color: text == null ? colors.mutedForeground : colors.foreground,
        );
    final Widget value = Text(text ?? t.common.empty, style: style);
    if (leading == null) return value;
    return Row(
      spacing: 8.w,
      children: <Widget>[
        leading!,
        Flexible(child: value),
      ],
    );
  }
}

/// A hidden secret (`.fmono`): dots in Space Mono.
class AppFieldHidden extends StatelessWidget {
  const AppFieldHidden({
    required this.length,
    required this.semanticLabel,
    super.key,
  });

  final int length;

  /// "Password, hidden".
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel,
      excludeSemantics: true,
      child: Text(
        '•' * length,
        style: _monoValue(context).copyWith(color: context.colors.foreground),
      ),
    );
  }
}

/// A revealed secret (`.fmono` with `.dig` / `.sym`).
class AppFieldSecret extends StatelessWidget {
  const AppFieldSecret(this.secret, {super.key});

  final String secret;

  @override
  Widget build(BuildContext context) {
    return SecretText(
      secret,
      style: _monoValue(context).copyWith(color: context.colors.foreground),
    );
  }
}

TextStyle _monoValue(BuildContext context) =>
    AppTextStyles(context).secret().resized(15, line: 22, tracking: 0.02);

/// "Show in large type" under a revealed secret.
class AppLargeTypeButton extends StatelessWidget {
  const AppLargeTypeButton({required this.onPressed, super.key});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: AppPressable(
        onTap: onPressed,
        shape: const StadiumBorder(),
        child: Container(
          height: 32.h,
          padding: EdgeInsets.only(left: 10.w, right: 12.w),
          decoration: ShapeDecoration(
            color: colors.secondary,
            shape: const StadiumBorder(),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6.w,
            children: <Widget>[
              AppIcon(
                AppIconName.type,
                size: 15,
                stroke: 2,
                color: colors.foreground,
              ),
              Text(
                t.common.showInLargeType,
                style: AppTextStyles(context)
                    .secondary()
                    .resized(13, line: 18, weight: FontWeight.w700)
                    .copyWith(color: colors.foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
