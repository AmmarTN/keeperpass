import 'package:flutter/material.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_icons.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';

/// `.spin` — the loader circle turning once every 0.8 s; still under reduce
/// motion. Board C6: 14, 20 and 28 pt, always next to words.
class AppSpinner extends StatefulWidget {
  const AppSpinner({this.size = 20, this.color, super.key});

  final double size;

  /// Accent-strong by default.
  final Color? color;

  @override
  State<AppSpinner> createState() => _AppSpinnerState();
}

class _AppSpinnerState extends State<AppSpinner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _turn = AnimationController(
    vsync: this,
    duration: AppMotion.spinnerTurn,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (AppMotion.reduceMotion(context)) {
      _turn.stop();
    } else if (!_turn.isAnimating) {
      _turn.repeat();
    }
  }

  @override
  void dispose() {
    _turn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Repaints every frame while visible: keep it off the rest of the screen.
    return RepaintBoundary(
      child: RotationTransition(
        turns: _turn,
        child: AppIcon(
          AppIconName.loaderCircle,
          size: widget.size,
          stroke: 2.25,
          color: widget.color ?? context.colors.accentStrong,
        ),
      ),
    );
  }
}
