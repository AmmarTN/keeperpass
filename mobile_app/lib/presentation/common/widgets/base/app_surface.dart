import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_radius.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';

/// How far a surface stands off the screen.
enum AppElevation {
  /// No shadow (`.grp`, sheet groups on a card).
  flat,

  /// `--shadow-xs`: rows, grouped lists, cards.
  resting,

  /// `--shadow-float`: toasts, menus, dialogs.
  floating,

  /// `--lift`: the vault file card.
  lifted,
}

/// The card surface the boards repeat everywhere (`.card`, `.lst`, `.sgrp`,
/// `.flist`, `.dlg`, `.pop`, `.toast` …): a fill, the 1 pt hairline ring and a
/// shadow, on the platform's rounded shape (continuous corners on iOS).
class AppSurface extends StatelessWidget {
  const AppSurface({
    required this.child,
    this.padding,
    this.radius = AppRadius.xxl,
    this.color,
    this.elevation = AppElevation.resting,
    this.ring = true,
    this.ringColor,
    this.ringWidth = 1,
    this.clip = false,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  /// Corner radius in design points.
  final double radius;

  /// Fill; the card colour by default.
  final Color? color;
  final AppElevation elevation;

  /// The `0 0 0 1px var(--hairline)` ring.
  final bool ring;
  final Color? ringColor;

  /// Ring width in design points (1.5 for selected cards).
  final double ringWidth;

  /// Clips the child to the shape (lists whose rows paint backgrounds).
  final bool clip;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = context.colors;
    final AppShadows shadows = context.shadows;
    final OutlinedBorder shape = AppRadius.shape(context, radius);

    final List<BoxShadow> boxShadows = <BoxShadow>[
      ...switch (elevation) {
        AppElevation.flat => const <BoxShadow>[],
        AppElevation.resting => shadows.shadowXs,
        AppElevation.floating => shadows.shadowFloat,
        AppElevation.lifted => shadows.lift,
      },
      if (ring)
        BoxShadow(
          color: ringColor ?? colors.hairline,
          spreadRadius: ringWidth.r,
        ),
    ];

    Widget content = padding == null
        ? child
        : Padding(padding: padding!, child: child);
    if (clip) {
      final BorderRadius borderRadius = BorderRadius.circular(radius.r);
      content = shape is RoundedSuperellipseBorder
          ? ClipRSuperellipse(borderRadius: borderRadius, child: content)
          : ClipRRect(borderRadius: borderRadius, child: content);
    }

    return DecoratedBox(
      decoration: ShapeDecoration(
        color: color ?? colors.card,
        shape: shape,
        shadows: boxShadows,
      ),
      child: content,
    );
  }
}
