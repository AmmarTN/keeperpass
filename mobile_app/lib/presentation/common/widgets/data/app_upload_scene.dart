import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/widgets/brand/app_brand.dart';

/// The vault card's road to the storage (boards `U2-Create`,
/// `U2-New-vault`): the provider at the top (`.dst`), a dashed lane
/// (`.lane`) and the card(s) below. While [uploading], a dot travels up the
/// lane (still under reduce motion).
class AppUploadScene extends StatefulWidget {
  const AppUploadScene({
    required this.provider,
    required this.child,
    this.uploading = false,
    super.key,
  });

  final AppProvider provider;

  /// The vault card (or the old and new cards).
  final Widget child;
  final bool uploading;

  @override
  State<AppUploadScene> createState() => _AppUploadSceneState();
}

class _AppUploadSceneState extends State<AppUploadScene>
    with SingleTickerProviderStateMixin {
  late final AnimationController _travel = AnimationController(
    vsync: this,
    duration: AppMotion.dialTurn,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(covariant AppUploadScene oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  void _sync() {
    if (widget.uploading && !AppMotion.reduceMotion(context)) {
      if (!_travel.isAnimating) _travel.repeat();
    } else {
      _travel.stop();
    }
  }

  @override
  void dispose() {
    _travel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 12.h,
      children: <Widget>[
        Container(
          width: 64.r,
          height: 64.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.card,
            shape: BoxShape.circle,
            boxShadow: <BoxShadow>[
              BoxShadow(color: colors.hairline, spreadRadius: 1.r),
              ...context.shadows.lift,
            ],
          ),
          child: AppProviderLogo(widget.provider, size: 26),
        ),
        SizedBox(
          width: 10.r,
          height: 56.h,
          child: RepaintBoundary(
            child: AnimatedBuilder(
              animation: _travel,
              builder: (BuildContext context, _) => CustomPaint(
                painter: _LanePainter(
                  dash: colors.primary30,
                  dot: colors.primary,
                  ring: colors.primary20,
                  // Bottom to top; resting at 38 % under reduce motion.
                  dotAt: widget.uploading
                      ? (_travel.isAnimating ? 1 - _travel.value : 0.38)
                      : null,
                ),
              ),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }
}

class _LanePainter extends CustomPainter {
  _LanePainter({
    required this.dash,
    required this.dot,
    required this.ring,
    required this.dotAt,
  });

  final Color dash;
  final Color dot;
  final Color ring;

  /// Where the dot is, 0 (top) to 1 (bottom); none when null.
  final double? dotAt;

  @override
  void paint(Canvas canvas, Size size) {
    final double x = size.width / 2;
    final double unit = size.height / 56;
    final Paint line = Paint()
      ..color = dash
      ..strokeWidth = 2 * unit;
    for (double y = 0; y < size.height; y += 12 * unit) {
      canvas.drawLine(
        Offset(x, y),
        Offset(x, (y + 6 * unit).clamp(0, size.height)),
        line,
      );
    }
    final double? at = dotAt;
    if (at == null) return;
    final Offset centre = Offset(x, (size.height - 10 * unit) * at + 5 * unit);
    canvas
      ..drawCircle(centre, 9 * unit, Paint()..color = ring)
      ..drawCircle(centre, 5 * unit, Paint()..color = dot);
  }

  @override
  bool shouldRepaint(_LanePainter old) =>
      old.dotAt != dotAt || old.dash != dash || old.dot != dot;
}
