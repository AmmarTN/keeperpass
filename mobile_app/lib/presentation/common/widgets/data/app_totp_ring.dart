import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/i18n/strings.g.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// The last seconds of a code turn amber (board C7).
const int kTotpWarningSeconds = 5;

/// The 2FA countdown ring (board C7): what is left of the period, drawn
/// clockwise from the top, moving with a 1 s linear tick; amber in the last
/// five seconds. Sizes 16, 20, 24 and 28.
class AppTotpRing extends StatefulWidget {
  const AppTotpRing({
    required this.secondsLeft,
    this.period = 30,
    this.size = 20,
    super.key,
  });

  final int secondsLeft;
  final int period;
  final double size;

  @override
  State<AppTotpRing> createState() => _AppTotpRingState();
}

class _AppTotpRingState extends State<AppTotpRing>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fraction = AnimationController(
    vsync: this,
    value: _target,
  );

  double get _target => (widget.secondsLeft / widget.period).clamp(0, 1);

  @override
  void didUpdateWidget(covariant AppTotpRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    final double target = _target;
    if (target < _fraction.value && !AppMotion.reduceMotion(context)) {
      // The 1 s linear tick winds the ring down…
      _fraction.animateTo(
        target,
        duration: AppMotion.tick,
        curve: AppMotion.tickCurve,
      );
    } else {
      // …and a new period jumps straight back to full.
      _fraction.value = target;
    }
  }

  @override
  void dispose() {
    _fraction.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool warning = widget.secondsLeft <= kTotpWarningSeconds;
    final Color color = warning ? colors.warningStrong : colors.accentStrong;

    return Semantics(
      label: t.totp.secondsLeft(count: widget.secondsLeft),
      child: RepaintBoundary(
        child: AnimatedBuilder(
          animation: _fraction,
          builder: (BuildContext context, _) => CustomPaint(
            size: Size.square(widget.size.r),
            painter: _RingPainter(fraction: _fraction.value, color: color),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({required this.fraction, required this.color});

  final double fraction;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // The board's SVG: viewBox 20, r 7.5, stroke 3.
    final double scale = size.width / 20;
    final Offset center = size.center(Offset.zero);
    final double radius = 7.5 * scale;
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3 * scale;

    canvas.drawCircle(
      center,
      radius,
      paint..color = color.withValues(alpha: color.a * 0.2),
    );
    if (fraction <= 0) return;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * fraction,
      false,
      paint
        ..color = color
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.fraction != fraction || old.color != color;
}

/// A 2FA code with its ring (`.mono` 22 / 28 + ring), amber with "4 s" in the
/// last five seconds.
class AppTotpCode extends StatelessWidget {
  const AppTotpCode({
    required this.code,
    required this.secondsLeft,
    this.period = 30,
    super.key,
  });

  /// "482 913".
  final String code;
  final int secondsLeft;
  final int period;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final bool warning = secondsLeft <= kTotpWarningSeconds;
    final Color color = warning ? colors.warningStrong : colors.foreground;
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 10.w,
      children: <Widget>[
        Text(code, style: AppTextStyles(context).code().copyWith(color: color)),
        AppTotpRing(secondsLeft: secondsLeft, period: period),
        if (warning)
          ExcludeSemantics(
            child: Text(
              t.totp.secondsShort(count: secondsLeft),
              style: AppTextStyles(context)
                  .badge()
                  .resized(12, line: 16, weight: FontWeight.w800)
                  .copyWith(color: colors.warningStrong),
            ),
          ),
      ],
    );
  }
}
