import 'package:flutter/widgets.dart';

/// Motion timings (board: Motion and haptics). Short and functional, matched
/// to the web. Sheets, push and back keep each platform's own motion; every
/// other animation uses these and has a Reduce Motion alternative.
abstract final class AppMotion {
  /// 150 ms — fades, dialogs, Reduce Motion crossfades.
  static const Duration fast = Duration(milliseconds: 150);

  /// 200 ms — copy swap, toast out, tab change.
  static const Duration base = Duration(milliseconds: 200);

  /// 250 ms — toast and banner in.
  static const Duration enter = Duration(milliseconds: 250);

  /// 300 ms — regenerate bounce, strength meter.
  static const Duration slow = Duration(milliseconds: 300);

  /// 500 ms — health bar on first view.
  static const Duration fill = Duration(milliseconds: 500);

  /// 1 s, linear — the 2FA countdown ring.
  static const Duration tick = Duration(seconds: 1);

  /// Tailwind's ease-out, as on the web: cubic-bezier(0, 0, 0.2, 1).
  static const Curve easeOut = Cubic(0, 0, 0.2, 1);

  /// The countdown ring ticks without easing.
  static const Curve tickCurve = Curves.linear;

  // The moments on the board.

  /// "Copied" holds over the label for 1 s.
  static const Duration copiedHold = Duration(seconds: 1);

  /// A toast stays 3 s, then fades out over [base].
  static const Duration toastVisible = Duration(seconds: 3);

  /// A toast slides in by 12 pt while fading in over [enter].
  static const double toastSlide = 12;

  /// A dialog zooms 95% → 100% while fading in over [fast].
  static const double dialogStartScale = 0.95;

  /// Regenerate bounces 0.97 → 1.02 → 1 over [slow].
  static const List<double> regenerateBounce = <double>[0.97, 1.02, 1];

  /// A wrong secret shakes for 400 ms, three cycles of ±8 pt.
  static const Duration shake = Duration(milliseconds: 400);
  static const int shakeCycles = 3;
  static const double shakeDistance = 8;

  /// Skeletons pulse opacity 1 → 0.5 over 1.5 s.
  static const Duration skeletonPulse = Duration(milliseconds: 1500);
  static const double skeletonMinOpacity = 0.5;

  /// A spinner turns once per 0.8 s.
  static const Duration spinnerTurn = Duration(milliseconds: 800);

  /// One turn of the unlock dial's arc while the key is derived (board
  /// C7-Tiles-data: 1.4 s linear; still under reduce motion).
  static const Duration dialTurn = Duration(milliseconds: 1400);

  /// Whether the person asked for less motion (iOS Reduce Motion, Android
  /// "Remove animations"). Each animation then uses its board alternative —
  /// usually a [fast] crossfade, or no animation at all.
  static bool reduceMotion(BuildContext context) =>
      MediaQuery.disableAnimationsOf(context);
}
