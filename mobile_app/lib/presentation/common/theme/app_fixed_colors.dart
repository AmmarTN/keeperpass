import 'package:flutter/material.dart';

/// The few colours the component stylesheet (board C1-Buttons-fields,
/// `<helmet>`) writes as fixed values instead of theme variables: they are the
/// same in light and dark. Everything else comes from `context.colors`.
abstract final class AppFixedColors {
  /// `.fav`, `.stt.wht`, `.avb`: the white tile behind a favicon, letter or
  /// provider logo, in both themes.
  static const Color tileWhite = Color(0xFFFFFFFF);

  /// `.fav`: the letter on a white favicon tile (the light muted foreground).
  static const Color tileLetter = Color(0xFF60636A);

  /// `.fav`, `.stt.wht`: the 6 % ring around a white tile.
  static const Color tileRing = Color.from(
    alpha: 0.06,
    red: 0,
    green: 0,
    blue: 0,
  );

  /// `.flag`: the 12 % ring around a country flag.
  static const Color flagRing = Color.from(
    alpha: 0.12,
    red: 0,
    green: 0,
    blue: 0,
  );

  /// `.btn` solid destructive: white text on the red fill.
  static const Color onDestructive = Color(0xFFFFFFFF);

  /// `.ios-sw i`, slider thumb: the white knob.
  static const Color knob = Color(0xFFFFFFFF);

  /// `.ios-sw i`: the knob's two shadows.
  static const List<BoxShadow> knobShadow = <BoxShadow>[
    BoxShadow(
      offset: Offset(0, 3),
      blurRadius: 8,
      color: Color.from(alpha: 0.15, red: 0, green: 0, blue: 0),
    ),
    BoxShadow(
      offset: Offset(0, 1),
      blurRadius: 1,
      color: Color.from(alpha: 0.16, red: 0, green: 0, blue: 0),
    ),
  ];

  /// Slider thumb: `0 2px 6px rgb(0 0 0 / 18%)`.
  static const BoxShadow sliderThumbShadow = BoxShadow(
    offset: Offset(0, 2),
    blurRadius: 6,
    color: Color.from(alpha: 0.18, red: 0, green: 0, blue: 0),
  );

  /// `.swact` content edge while swiped: `8px 0 16px -12px rgb(0 0 0 / 30%)`.
  static const BoxShadow swipeEdgeShadow = BoxShadow(
    offset: Offset(8, 0),
    blurRadius: 16,
    spreadRadius: -12,
    color: Color.from(alpha: 0.3, red: 0, green: 0, blue: 0),
  );

  /// `.appicon`: the black square behind the mark (app icon, launch, cover).
  static const Color markBackground = Color(0xFF000000);

  /// The white mark on [markBackground] (launch screen, app icon).
  static const Color markForeground = Color(0xFFFFFFFF);

  /// A search match (`mark`, board `U3-Vault-home` 02): the primary blue at
  /// 35 % in both themes.
  static const Color searchMark = Color(0x5985ADE5);

  /// `.cam` (board `Scan-QR`): the scanner is dark in both themes; this
  /// shows until the camera's picture does.
  static const RadialGradient cameraBackdrop = RadialGradient(
    center: Alignment(0, -0.2),
    radius: 1.2,
    colors: <Color>[Color(0xFF3B3F48), Color(0xFF1B1D22), Color(0xFF0C0D10)],
    stops: <double>[0, 0.6, 1],
  );

  /// Text, icons and the frame's corners over the camera.
  static const Color onCamera = Color(0xFFFFFFFF);

  /// `.glass`, `.gbtn`: 16 % white over a 20 pt blur, on the camera.
  static const Color cameraGlass = Color.from(
    alpha: 0.16,
    red: 1,
    green: 1,
    blue: 1,
  );

  /// The camera under "Code Found": 45 % black.
  static const Color cameraDim = Color.from(
    alpha: 0.45,
    red: 0,
    green: 0,
    blue: 0,
  );

  /// `.qrf .scan`: the line across the frame (the primary blue).
  static const Color scanLine = Color(0xFF85ADE5);

  /// `.qrf .scan`'s glow, `0 0 16px 2px rgb(133 173 229 / 70%)` (a CSS blur
  /// of 16 is a Flutter blur radius of 13, plan O8).
  static const BoxShadow scanLineGlow = BoxShadow(
    blurRadius: 13,
    spreadRadius: 2,
    color: Color.from(
      alpha: 0.7,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
  );

  /// `.pressed`: 10 % black over a pressed control in light, 10 % white in
  /// dark.
  static Color pressedOverlay(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
      ? const Color.from(alpha: 0.1, red: 1, green: 1, blue: 1)
      : const Color.from(alpha: 0.1, red: 0, green: 0, blue: 0);
}
