import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_motion.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';

/// The unlock dial's states (board C7 "Dial").
enum AppDialState {
  /// Resting.
  resting,

  /// Turning while the key is derived.
  turning,

  /// Ringing red: the secret was wrong.
  error,

  /// A 3 pt accent track: storage and secret joined (How it works, step 3).
  joined,
}

/// The unlock dial (`.dial`): a ring of ticks, a track, and the knob holding
/// the avatar; an accent arc turns while the key is derived (1.4 s a turn,
/// still under reduce motion), and the track rings red on a wrong secret.
class AppUnlockDial extends StatefulWidget {
  const AppUnlockDial({
    required this.child,
    this.state = AppDialState.resting,
    this.size = 140,
    this.tickReveal = 1,
    super.key,
  });

  /// The avatar in the knob ([AppAvatar] at 56).
  final Widget child;
  final AppDialState state;
  final double size;

  /// How many of the 60 ticks are drawn, 0–1, clockwise from the top: the
  /// launch motion draws them in around the knob.
  final double tickReveal;

  @override
  State<AppUnlockDial> createState() => _AppUnlockDialState();
}

class _AppUnlockDialState extends State<AppUnlockDial>
    with SingleTickerProviderStateMixin {
  late final AnimationController _turn = AnimationController(
    vsync: this,
    duration: AppMotion.dialTurn,
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sync();
  }

  @override
  void didUpdateWidget(covariant AppUnlockDial oldWidget) {
    super.didUpdateWidget(oldWidget);
    _sync();
  }

  void _sync() {
    if (widget.state == AppDialState.turning &&
        !AppMotion.reduceMotion(context)) {
      if (!_turn.isAnimating) _turn.repeat();
    } else {
      _turn.stop();
    }
  }

  @override
  void dispose() {
    _turn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final double size = widget.size.r;
    final double scale = size / 140;

    return SizedBox.square(
      dimension: size,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          RepaintBoundary(
            child: CustomPaint(
              size: Size.square(size),
              painter: _DialPainter(
                tick: colors.tick,
                track: switch (widget.state) {
                  AppDialState.error => colors.destructive,
                  AppDialState.joined => colors.accentStrong,
                  _ => colors.secondary,
                },
                trackWidth: widget.state == AppDialState.joined ? 3 : 2,
                tickReveal: widget.tickReveal,
                scale: scale,
              ),
            ),
          ),
          if (widget.state == AppDialState.turning)
            RepaintBoundary(
              child: RotationTransition(
                turns: _turn,
                child: CustomPaint(
                  size: Size.square(116 * scale),
                  painter: _ArcPainter(
                    color: colors.accentStrong,
                    scale: scale,
                  ),
                ),
              ),
            ),
          Container(
            width: 92 * scale,
            height: 92 * scale,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.card,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                ...context.shadows.shadowFloat,
                BoxShadow(color: colors.hairline, spreadRadius: 1.r),
              ],
            ),
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

/// 60 ticks (1.2° on, 4.8° off) in the outer 7 pt, and the 2 pt track inset
/// 12 pt.
class _DialPainter extends CustomPainter {
  _DialPainter({
    required this.tick,
    required this.track,
    required this.trackWidth,
    required this.tickReveal,
    required this.scale,
  });

  final Color tick;
  final Color track;
  final double trackWidth;
  final double tickReveal;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = size.center(Offset.zero);
    final double outer = size.width / 2;
    final Paint tickPaint = Paint()
      ..color = tick
      ..style = PaintingStyle.stroke
      ..strokeWidth = 7 * scale;
    final Rect ring = Rect.fromCircle(
      center: center,
      radius: outer - 3.5 * scale,
    );
    const double on = 1.2 * math.pi / 180;
    final int ticks = (60 * tickReveal.clamp(0, 1)).round();
    for (int i = 0; i < ticks; i++) {
      canvas.drawArc(
        ring,
        -math.pi / 2 + i * 6 * math.pi / 180,
        on,
        false,
        tickPaint,
      );
    }
    // The track is an inset ring (`box-shadow: inset 0 0 0 2px`), so its
    // outer edge stays put as it thickens.
    canvas.drawCircle(
      center,
      outer - 12 * scale - trackWidth / 2 * scale,
      Paint()
        ..color = track
        ..style = PaintingStyle.stroke
        ..strokeWidth = trackWidth * scale,
    );
  }

  @override
  bool shouldRepaint(_DialPainter old) =>
      old.tick != tick ||
      old.track != track ||
      old.trackWidth != trackWidth ||
      old.tickReveal != tickReveal ||
      old.scale != scale;
}

/// The turning arc: r 56.5, 3 pt, round caps, 92.3 of 355 long, from the top.
class _ArcPainter extends CustomPainter {
  _ArcPainter({required this.color, required this.scale});

  final Color color;
  final double scale;

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = 56.5 * scale;
    canvas.drawArc(
      Rect.fromCircle(center: size.center(Offset.zero), radius: radius),
      -math.pi / 2,
      2 * math.pi * 92.3 / 355,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3 * scale
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_ArcPainter old) =>
      old.color != color || old.scale != scale;
}
