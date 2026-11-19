import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_fixed_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_spacing.dart';

/// The tap behaviour every pressable component shares (boards C1–C7): the
/// pressed look (`.pressed`: a 10 % overlay, or a fill such as a row's
/// accent), the disabled look (`.off`: 50 %), the screen-reader role and an
/// optional haptic. It draws nothing at rest.
class AppPressable extends StatefulWidget {
  const AppPressable({
    required this.child,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.semanticLabel,
    this.semanticValue,
    this.liveRegion = false,
    this.isButton = true,
    this.shape = const RoundedRectangleBorder(),
    this.pressedFill,
    this.disabledOpacity = 0.5,
    this.haptic,
    this.checked,
    this.toggled,
    this.selected,
    this.inMutuallyExclusiveGroup = false,
    this.expanded,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool enabled;

  /// Replaces the child's own semantics (icon buttons, rows read as one).
  final String? semanticLabel;

  /// Read after the label ("482 913" on a code card); with [liveRegion], a
  /// new value is announced politely.
  final String? semanticValue;
  final bool liveRegion;
  final bool isButton;

  /// The outline the pressed overlay fills.
  final ShapeBorder shape;

  /// Pressed fill drawn behind the child instead of the overlay (rows).
  final Color? pressedFill;
  final double disabledOpacity;

  /// Played on tap, before [onTap] (`AppHaptics`).
  final Future<void> Function()? haptic;

  /// States a screen reader announces with this control (a choice row's
  /// check, a chip's selection, a toggle). One node carries them all.
  final bool? checked;
  final bool? toggled;
  final bool? selected;
  final bool inMutuallyExclusiveGroup;

  /// An accordion row's state (`aria-expanded`, board `S5-40`).
  final bool? expanded;

  /// The smallest tap target on this platform: 44 pt on iOS, 48 dp on
  /// Android (plan, Part 3).
  static double minTarget(BuildContext context) =>
      (Theme.of(context).platform == TargetPlatform.android
              ? AppSpacing.touchTargetAndroid
              : AppSpacing.touchTargetIos)
          .r;

  @override
  State<AppPressable> createState() => _AppPressableState();
}

class _AppPressableState extends State<AppPressable> {
  bool _pressed = false;

  bool get _active =>
      widget.enabled && (widget.onTap != null || widget.onLongPress != null);

  void _setPressed(bool value) {
    if (_pressed != value && mounted) setState(() => _pressed = value);
  }

  void _handleTap() {
    widget.haptic?.call();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    Widget content = widget.child;

    if (_pressed) {
      content = widget.pressedFill != null
          ? DecoratedBox(
              decoration: ShapeDecoration(
                color: widget.pressedFill,
                shape: widget.shape,
              ),
              child: content,
            )
          : DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: ShapeDecoration(
                color: AppFixedColors.pressedOverlay(context),
                shape: widget.shape,
              ),
              child: content,
            );
    }

    if (!widget.enabled) {
      content = Opacity(opacity: widget.disabledOpacity, child: content);
    }

    // Its own node: a pressable inside another (a row's copy button) stays a
    // separate stop for screen readers instead of merging into the row.
    return Semantics(
      container: true,
      button: widget.isButton,
      checked: widget.checked,
      toggled: widget.toggled,
      selected: widget.selected,
      inMutuallyExclusiveGroup: widget.inMutuallyExclusiveGroup,
      expanded: widget.expanded,
      enabled: widget.enabled,
      label: widget.semanticLabel,
      value: widget.semanticValue,
      liveRegion: widget.liveRegion,
      excludeSemantics: widget.semanticLabel != null,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _active && widget.onTap != null ? _handleTap : null,
        onLongPress: _active ? widget.onLongPress : null,
        onTapDown: _active ? (_) => _setPressed(true) : null,
        onTapUp: _active ? (_) => _setPressed(false) : null,
        onTapCancel: _active ? () => _setPressed(false) : null,
        child: content,
      ),
    );
  }
}
