import 'package:flutter/widgets.dart';

/// Application-wide layout values that are configuration rather than visual
/// design tokens.
abstract final class UiConstants {
  /// The design's iPhone frame (393 × 852 pt), plan decision D13.
  static const Size designSize = Size(393, 852);
  static const double compactContentMaxWidth = 480;
  static const double wideContentMaxWidth = 720;
  static const Duration splashMinimumDisplay = Duration(milliseconds: 650);
}
