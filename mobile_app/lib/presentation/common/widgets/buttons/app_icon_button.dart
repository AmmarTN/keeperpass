import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_haptics.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/widgets/base/app_pressable.dart';

/// Icon-button looks (board C1 "Icon buttons": 44 pt targets).
enum AppIconButtonVariant {
  /// `.ib` — header and bar actions: the icon in a 36 pt circle filled like
  /// the search field (your answer, 2026-11-03; the board draws the icon
  /// alone).
  header,

  /// `.act` / `.fact` — field and field-row actions, muted, 10 pt corners.
  field,
}

/// A 44 pt icon button (48 dp target on Android). The label is required: it is
/// what a screen reader says.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    required this.semanticLabel,
    required this.onPressed,
    this.variant = AppIconButtonVariant.header,
    this.iconSize,
    this.stroke,
    this.color,
    super.key,
  });

  final AppIconName icon;
  final String semanticLabel;
  final VoidCallback? onPressed;
  final AppIconButtonVariant variant;

  /// 18 for header actions, 20 for field actions by default.
  final double? iconSize;

  /// The circle of a header action.
  static const double headerCircle = 36;
  final double? stroke;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    if (variant == AppIconButtonVariant.header) {
      // As the sheets' close button: the circle inside the full target.
      return _IconButtonFrame(
        semanticLabel: semanticLabel,
        onPressed: onPressed,
        radius: 22,
        child: Container(
          width: headerCircle.r,
          height: headerCircle.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.secondary,
            shape: BoxShape.circle,
          ),
          child: AppIcon(
            icon,
            size: iconSize ?? 18,
            stroke: stroke ?? 2,
            color: color ?? colors.foreground,
          ),
        ),
      );
    }
    return _IconButtonFrame(
      semanticLabel: semanticLabel,
      onPressed: onPressed,
      radius: 10,
      child: AppIcon(
        icon,
        size: iconSize ?? AppIconSizes.md,
        stroke: stroke ?? 1.75,
        color: color ?? colors.mutedForeground,
      ),
    );
  }
}

/// `.xbtn` — the round close button of sheets.
class AppCloseButton extends StatelessWidget {
  const AppCloseButton({
    required this.onPressed,
    this.semanticLabel,
    super.key,
  });

  final VoidCallback onPressed;

  /// "Close" by default.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return _IconButtonFrame(
      semanticLabel: semanticLabel ?? t.common.close,
      onPressed: onPressed,
      radius: 22,
      child: Container(
        width: 30.r,
        height: 30.r,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: colors.secondary,
          shape: BoxShape.circle,
        ),
        child: AppIcon(
          AppIconName.x,
          size: AppIconSizes.xs,
          stroke: 2.75,
          color: colors.mutedForeground,
        ),
      ),
    );
  }
}

/// Copy-button looks.
enum AppCopyButtonVariant {
  /// `.cp` — a row's trailing copy, 44 pt.
  row,

  /// `.fact` — a field row's copy, no fill when done.
  field,

  /// `.ccp` — a card's 40 pt copy on the neutral fill.
  card,

  /// `.cpb` — a favourite card's 36 pt copy on the neutral fill.
  favorite,
}

/// Copies, then shows the check for 1 s (board: "copied" state), with the
/// copy haptic. [onCopy] does the copying.
class AppCopyButton extends StatefulWidget {
  const AppCopyButton({
    required this.semanticLabel,
    required this.onCopy,
    this.variant = AppCopyButtonVariant.row,
    super.key,
  });

  /// "Copy password for GitHub".
  final String semanticLabel;
  final VoidCallback onCopy;
  final AppCopyButtonVariant variant;

  @override
  State<AppCopyButton> createState() => _AppCopyButtonState();
}

class _AppCopyButtonState extends State<AppCopyButton> {
  bool _copied = false;
  Timer? _reset;

  @override
  void dispose() {
    _reset?.cancel();
    super.dispose();
  }

  void _copy() {
    widget.onCopy();
    _reset?.cancel();
    setState(() => _copied = true);
    _reset = Timer(AppMotion.copiedHold, () {
      if (mounted) setState(() => _copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool filled =
        widget.variant == AppCopyButtonVariant.card ||
        widget.variant == AppCopyButtonVariant.favorite;
    final bool filledWhenDone = widget.variant != AppCopyButtonVariant.field;
    final Color? background = _copied && filledWhenDone
        ? colors.primary15
        : (filled ? colors.secondary : null);
    final (double dimension, double radius) = switch (widget.variant) {
      AppCopyButtonVariant.row => (44.0, 12.0),
      AppCopyButtonVariant.field => (44.0, 10.0),
      AppCopyButtonVariant.card => (40.0, 12.0),
      AppCopyButtonVariant.favorite => (36.0, 11.0),
    };

    return _IconButtonFrame(
      semanticLabel: _copied ? t.common.copied : widget.semanticLabel,
      onPressed: _copy,
      haptic: AppHaptics.copy,
      radius: radius,
      child: Container(
        width: dimension.r,
        height: dimension.r,
        alignment: Alignment.center,
        decoration: background == null
            ? null
            : BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(radius.r),
              ),
        child: AppIcon(
          _copied ? AppIconName.check : AppIconName.copy,
          size: AppIconSizes.md,
          stroke: _copied ? 2.25 : 1.75,
          color: _copied ? colors.accentStrong : colors.mutedForeground,
        ),
      ),
    );
  }
}

/// The shared 44 pt frame: a square target (48 dp on Android) with the
/// pressed overlay on the visible shape.
class _IconButtonFrame extends StatelessWidget {
  const _IconButtonFrame({
    required this.semanticLabel,
    required this.onPressed,
    required this.radius,
    required this.child,
    this.haptic,
  });

  final String semanticLabel;
  final VoidCallback? onPressed;
  final double radius;
  final Widget child;
  final Future<void> Function()? haptic;

  @override
  Widget build(BuildContext context) {
    final double target = AppPressable.minTarget(context);
    return AppPressable(
      onTap: onPressed,
      enabled: onPressed != null,
      semanticLabel: semanticLabel,
      haptic: haptic,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius.r),
      ),
      child: SizedBox.square(
        dimension: target,
        child: Center(child: child),
      ),
    );
  }
}
