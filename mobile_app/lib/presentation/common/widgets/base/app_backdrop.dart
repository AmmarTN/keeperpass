import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';

/// The step-2 screens' background (boards `U2-*`): one soft pool of accent
/// glow (`.glow`) and, behind Welcome, a dot grid that fades out downwards
/// (`.dots`). Painted once; it never repaints with the content.
class AppBackdrop extends StatelessWidget {
  const AppBackdrop({
    required this.glowLeft,
    required this.glowTop,
    this.glowSize = 540,
    this.glowHeight,
    this.dots = false,
    this.opacity = 1,
    super.key,
  });

  /// The glow circle's top-left corner and size, in design points.
  final double glowLeft;
  final double glowTop;
  final double glowSize;

  /// An oval glow's height (About: 440 × 400); a circle when null.
  final double? glowHeight;

  /// The dot grid (Welcome and Connect only).
  final bool dots;

  /// Fades the whole backdrop (the launch motion).
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    return IgnorePointer(
      child: RepaintBoundary(
        child: CustomPaint(
          size: Size.infinite,
          painter: _BackdropPainter(
            glow: colors.glow,
            dot: colors.dot,
            glowRect: Rect.fromLTWH(
              glowLeft.w,
              glowTop.h,
              glowSize.r,
              (glowHeight ?? glowSize).r,
            ),
            dots: dots,
            dotHeight: 620.h,
            spacing: 24.r,
            opacity: opacity,
          ),
        ),
      ),
    );
  }
}

class _BackdropPainter extends CustomPainter {
  _BackdropPainter({
    required this.glow,
    required this.dot,
    required this.glowRect,
    required this.dots,
    required this.dotHeight,
    required this.spacing,
    required this.opacity,
  });

  final Color glow;
  final Color dot;
  final Rect glowRect;
  final bool dots;
  final double dotHeight;
  final double spacing;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity <= 0) return;
    // `radial-gradient(closest-side, var(--glow), transparent)`: an ellipse
    // touching the box's sides, drawn as a circle scaled to its height.
    final double glowRadius = glowRect.width / 2;
    final Rect circle = Rect.fromCircle(
      center: Offset.zero,
      radius: glowRadius,
    );
    canvas
      ..save()
      ..translate(glowRect.center.dx, glowRect.center.dy)
      ..scale(1, glowRect.height / glowRect.width)
      ..drawCircle(
        Offset.zero,
        glowRadius,
        Paint()
          ..shader = RadialGradient(
            colors: <Color>[
              glow.withValues(alpha: glow.a * opacity),
              glow.withValues(alpha: 0),
            ],
          ).createShader(circle),
      )
      ..restore();
    if (!dots) return;

    // A 24 pt grid of 1.2 pt dots, offset 8 pt down, masked from opaque at
    // 8 % of its height to clear at 78 %.
    final Paint paint = Paint();
    final double radius = 1.45 * spacing / 24;
    for (
      double y = 8 * spacing / 24 + spacing / 2;
      y < dotHeight;
      y += spacing
    ) {
      final double t = y / dotHeight;
      final double fade = t <= 0.08
          ? 1
          : t >= 0.78
          ? 0
          : 1 - (t - 0.08) / 0.70;
      if (fade <= 0) continue;
      paint.color = dot.withValues(alpha: dot.a * fade * opacity);
      for (double x = spacing / 2; x < size.width; x += spacing) {
        canvas.drawCircle(Offset(x, y), radius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_BackdropPainter old) =>
      old.glow != glow ||
      old.dot != dot ||
      old.glowRect != glowRect ||
      old.dots != dots ||
      old.opacity != opacity ||
      old.dotHeight != dotHeight;
}
