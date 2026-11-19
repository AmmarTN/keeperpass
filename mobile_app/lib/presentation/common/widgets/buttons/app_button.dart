import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';
import 'package:keeperpass/presentation/common/widgets/feedback/app_spinner.dart';

/// Button styles (board C1, `.btn`).
enum AppButtonVariant {
  /// Accent fill, always dark text — the main action.
  primary,

  /// A 5 % fill — the other choice (it can still be the stronger one).
  secondary,

  /// Red tint — destructive, but not final.
  destructive,

  /// Solid red — only the final step of something irreversible.
  destructiveSolid,

  /// No fill, accent-strong text (`.btn.g`).
  ghost,

  /// Accent tint, accent-strong text: a confirmation held on the button
  /// ("Copied", board `S4-10`).
  tinted,
}

/// Heights: 52 for primary actions, 44 for medium (`.md`).
enum AppButtonSize {
  large(52, 20),
  medium(44, 18);

  const AppButtonSize(this.height, this.iconSize);

  final double height;
  final double iconSize;
}

/// The board's button: five styles, two heights, and the default, pressed,
/// disabled and busy states. Full width unless [expand] is false.
class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.icon,
    this.glyph,
    this.semanticLabel,
    this.busy = false,
    this.expand = true,
    this.horizontalPadding = 16,
    super.key,
  });

  final String label;

  /// Null disables the button (`.off`).
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final AppIconName? icon;

  /// A Font Awesome glyph in place of [icon] (board `Codes` 03: "Create an
  /// Authenticator item"), at 17 pt.
  final int? glyph;

  /// Read instead of [label] when the label alone is too short ("Copy" →
  /// "Copy password", web `aria-label`).
  final String? semanticLabel;

  /// Shows the spinner in place of the icon, at 50 %, and ignores taps.
  final bool busy;
  final bool expand;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final (Color? background, Color foreground) = switch (variant) {
      AppButtonVariant.primary => (colors.primary, colors.primaryForeground),
      AppButtonVariant.secondary => (colors.secondary, colors.foreground),
      AppButtonVariant.destructive => (
        colors.destructiveTint,
        colors.destructiveStrong,
      ),
      AppButtonVariant.destructiveSolid => (
        colors.destructive,
        AppFixedColors.onDestructive,
      ),
      AppButtonVariant.ghost => (null, colors.accentStrong),
      AppButtonVariant.tinted => (colors.primary15, colors.accentStrong),
    };
    final TextStyle style =
        (size == AppButtonSize.large
                ? AppTextStyles(context).buttonLg()
                : AppTextStyles(context).button())
            .copyWith(color: foreground);
    final OutlinedBorder shape = AppRadius.shape(context, AppRadius.xl);
    final bool enabled = onPressed != null && !busy;

    final Widget content = Container(
      height: size.height.h,
      width: expand ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
      decoration: background == null
          ? null
          : ShapeDecoration(color: background, shape: shape),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8.w,
        children: <Widget>[
          if (busy)
            AppSpinner(size: 18, color: foreground)
          else if (icon != null)
            AppIcon(icon!, size: size.iconSize, color: foreground)
          else if (glyph != null)
            FaGlyph(glyph!, size: 17, color: foreground),
          Flexible(
            child: Text(
              label,
              style: style,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );

    // Busy is the disabled look with a spinner (board: "Unlocking…").
    return AppPressable(
      onTap: onPressed,
      enabled: enabled,
      semanticLabel: semanticLabel,
      shape: shape,
      child: content,
    );
  }
}
