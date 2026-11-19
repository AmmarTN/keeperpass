import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The haptics table on the Motion board, per platform.
///
/// | Moment | iOS | Android |
/// |---|---|---|
/// | Copy a value | impact · light | CONFIRM |
/// | Regenerate | selection | CLOCK_TICK |
/// | Wrong secret | notification · error | REJECT |
/// | Unlocked · saved | notification · success | CONFIRM |
/// | Slider · stepper · segment | selection | CLOCK_TICK |
/// | QR code found (board `Scan-QR`) | impact · light | VIRTUAL_KEY |
///
/// Android has CONFIRM and REJECT only from API 30; on older versions those
/// moments have no haptic (Flutter does nothing there).
abstract final class AppHaptics {
  static bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;

  /// Copying a value.
  static Future<void> copy() => _isAndroid
      ? HapticFeedback.successNotification() // CONFIRM
      : HapticFeedback.lightImpact();

  /// A new generated value.
  static Future<void> regenerate() => HapticFeedback.selectionClick();

  /// A wrong secret.
  static Future<void> wrongSecret() => HapticFeedback.errorNotification();

  /// Unlocked, or saved.
  static Future<void> success() => HapticFeedback.successNotification();

  /// A slider, stepper or segment changing value.
  static Future<void> selection() => HapticFeedback.selectionClick();

  /// A QR code found ("A found code gives a light haptic").
  static Future<void> found() => HapticFeedback.lightImpact();
}
