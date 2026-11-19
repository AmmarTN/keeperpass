import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The design's radii, the web's scale from an 8 pt base (board: Spacing,
/// shape and depth). Raw design points: apply `.r` at use sites.
abstract final class AppRadius {
  /// 8 · rounded-lg — small controls, field chips, field-row tiles.
  static const double lg = 8;

  /// 12 · rounded-xl — rows, item tiles, inputs, buttons.
  static const double xl = 12;

  /// 16 · rounded-2xl — cards, grouped lists, toasts, dialogs.
  static const double xxl = 16;

  /// Full — badges, tags, counts, switches.
  static const double full = 999;

  /// 22 at the top — bottom sheets, one style on both platforms (board
  /// C5-Sheets-menus-dialogs; replaces the 28 the Spacing board gave Android).
  static const double sheetTop = 22;

  /// A rounded shape for [radius] (design points). Corners are continuous
  /// (squircle) on iOS, as on the board, and circular arcs on Android.
  static OutlinedBorder shape(
    BuildContext context,
    double radius, {
    BorderSide side = BorderSide.none,
  }) {
    final BorderRadius borderRadius = BorderRadius.circular(radius.r);
    return Theme.of(context).platform == TargetPlatform.iOS
        ? RoundedSuperellipseBorder(borderRadius: borderRadius, side: side)
        : RoundedRectangleBorder(borderRadius: borderRadius, side: side);
  }
}
