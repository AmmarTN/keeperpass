import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// The design's type scale (board: Typography).
///
/// Nunito for every interface word, Space Mono for anything that must not be
/// misread. Both load from the bundled TTFs in `assets/fonts/` —
/// `GoogleFonts.config.allowRuntimeFetching` is off, so the app never
/// contacts Google Fonts. Sizes are design points scaled with ScreenUtil
/// (`.sp`); the system text size applies on top.
///
/// Styles carry no colour: text takes the theme's `foreground` unless a
/// widget sets one from `context.colors`.
class AppTextStyles {
  AppTextStyles(this.context);

  final BuildContext context;

  /// Display, stat and large-title are already large, so the system text
  /// size may grow them only up to 1.3× (maxFontSizeMultiplier on the board).
  static const double largeStyleMaxTextScale = 1.3;

  /// The text scaler to give a `Text` that uses [display], [stat] or
  /// [largeTitle].
  static TextScaler largeStyleTextScaler(BuildContext context) =>
      MediaQuery.textScalerOf(
        context,
      ).clamp(maxScaleFactor: largeStyleMaxTextScale);

  bool get _isIos => Theme.of(context).platform == TargetPlatform.iOS;

  /// [size] / [line] in points, [tracking] as a fraction of the size
  /// (the board's percentages: −2% → −0.02).
  TextStyle _nunito(
    double size,
    FontWeight weight,
    double line, {
    double tracking = 0,
  }) {
    return GoogleFonts.nunito(
      fontSize: size.sp,
      fontWeight: weight,
      height: line / size,
      letterSpacing: tracking * size.sp,
    );
  }

  TextStyle _mono(
    double size,
    FontWeight weight,
    double line, {
    double tracking = 0,
  }) {
    return GoogleFonts.spaceMono(
      fontSize: size.sp,
      fontWeight: weight,
      height: line / size,
      letterSpacing: tracking * size.sp,
    );
  }

  // Nunito

  /// 56 / 56 · 800 · −2% — the health score.
  TextStyle display() => _nunito(56, FontWeight.w800, 56, tracking: -0.02);

  /// 30 / 34 · 800 · −1.5% — stat cards.
  TextStyle stat() => _nunito(30, FontWeight.w800, 34, tracking: -0.015);

  /// 32 / 38 · 800 · −1.5% — screen titles ("Security Report").
  TextStyle largeTitle() => _nunito(32, FontWeight.w800, 38, tracking: -0.015);

  /// 26 / 32 · 800 · −1% — the item name in item detail.
  TextStyle itemTitle() => _nunito(26, FontWeight.w800, 32, tracking: -0.01);

  /// 22 / 28 · 800 — Android top app bar.
  TextStyle appBarTitle() => _nunito(22, FontWeight.w800, 28);

  /// 20 / 26 · 800 · −0.5% — dialog titles.
  TextStyle title() => _nunito(20, FontWeight.w800, 26, tracking: -0.005);

  /// 17 / 22 · 800 — iOS inline title.
  TextStyle navTitle() => _nunito(17, FontWeight.w800, 22);

  /// 16 / 22 · 700 — row titles.
  TextStyle rowTitle() => _nunito(16, FontWeight.w700, 22);

  /// 15 / 22 · 400.
  TextStyle body() => _nunito(15, FontWeight.w400, 22);

  /// 15 / 22 · 600.
  TextStyle bodyStrong() => _nunito(15, FontWeight.w600, 22);

  /// 16 / 20 · 700 — large buttons ("Create vault").
  TextStyle buttonLg() => _nunito(16, FontWeight.w700, 20);

  /// 15 / 20 · 700 — buttons.
  TextStyle button() => _nunito(15, FontWeight.w700, 20);

  /// 14 / 20 · 600 — form labels ("Repeat secret").
  TextStyle formLabel() => _nunito(14, FontWeight.w600, 20);

  /// 13 / 18 · 400 — secondary lines.
  TextStyle secondary() => _nunito(13, FontWeight.w400, 18);

  /// 12 / 16 · 600 — field labels ("Username").
  TextStyle fieldLabel() => _nunito(12, FontWeight.w600, 16);

  /// 12 / 16 · 700 · +8% — section labels. Shown in capitals: the widget
  /// upper-cases the text (a style cannot).
  TextStyle sectionLabel() => _nunito(12, FontWeight.w700, 16, tracking: 0.08);

  /// 12 / 16 · 700 — badges ("1 item flagged").
  TextStyle badge() => _nunito(12, FontWeight.w700, 16);

  /// 11 / 13 · 700 on iOS, 12 / 16 · 700 on Android — tab bar labels.
  TextStyle tabLabel() => _isIos
      ? _nunito(11, FontWeight.w700, 13)
      : _nunito(12, FontWeight.w700, 16);

  // Space Mono

  /// 16 / 24 · 400 · +2% — revealed passwords.
  TextStyle secret() => _mono(16, FontWeight.w400, 24, tracking: 0.02);

  /// 22 / 28 · 700 · +4% — 2FA codes.
  TextStyle code() => _mono(22, FontWeight.w700, 28, tracking: 0.04);

  /// 28 / 34 · 700 · +4% — large 2FA codes.
  TextStyle codeLg() => _mono(28, FontWeight.w700, 34, tracking: 0.04);

  /// 24 / 34 · 400 · +2% — generated passwords and passphrases.
  TextStyle generated() => _mono(24, FontWeight.w400, 34, tracking: 0.02);

  /// 44 / 56 · 700 — large type.
  TextStyle largeType() => _mono(44, FontWeight.w700, 56);

  /// 13 / 18 · 400 — the vault file name.
  TextStyle fileName() => _mono(13, FontWeight.w400, 18);
}

/// The component stylesheet sets a few sizes that are not named styles (an
/// 11 pt count, a 13 pt chip). Derive them from the nearest named style.
extension AppTextStyleSize on TextStyle {
  /// [size] / [line] in design points (`line` defaults to `size`), weight and
  /// tracking (a fraction of the size, like the named styles) optional.
  TextStyle resized(
    double size, {
    double? line,
    FontWeight? weight,
    double? tracking,
  }) {
    final TextStyle style = copyWith(
      fontSize: size.sp,
      height: (line ?? size) / size,
      fontWeight: weight,
      letterSpacing: tracking == null ? null : tracking * size.sp,
    );
    if (weight == null || weight == fontWeight) return style;
    // Google Fonts gives each weight its own family (`Nunito_700`): a new
    // weight needs its family too, or the old weight is drawn.
    final String family = fontFamily ?? '';
    if (family.startsWith('Nunito')) {
      return GoogleFonts.nunito(textStyle: style);
    }
    if (family.startsWith('SpaceMono')) {
      return GoogleFonts.spaceMono(textStyle: style);
    }
    return style;
  }
}
