// Design colour tokens for light and dark.
//
// Values copied from the design canvas's shared component stylesheet
// (board C1-Buttons-fields, <helmet>: .kp-light / .kp-dark), which the plan
// names as the token source of truth. When the design changes, update this file
// and test/fixtures/design_tokens.json (the stylesheet's raw values) together;
// test/presentation/common/theme/design_tokens_test.dart checks one against the
// other.
import 'package:flutter/material.dart';
import 'package:keeperpass/core/utils/text/tag_color.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.accent,
    required this.accentStrong,
    required this.background,
    required this.border,
    required this.card,
    required this.destructive,
    required this.destructivePressed,
    required this.destructiveStrong,
    required this.destructiveTint,
    required this.dot,
    required this.faviconTile,
    required this.foreground,
    required this.glow,
    required this.hairline,
    required this.input,
    required this.inverse,
    required this.material,
    required this.materialSep,
    required this.mutedForeground,
    required this.onInverse,
    required this.pressOnPrimary,
    required this.primary,
    required this.primary10,
    required this.primary15,
    required this.primary20,
    required this.primary30,
    required this.primary60,
    required this.primaryForeground,
    required this.ring,
    required this.scrim,
    required this.secondary,
    required this.sidebar,
    required this.tagBlue,
    required this.tagGold,
    required this.tagGreen,
    required this.tagOrange,
    required this.tagPink,
    required this.tagSlate,
    required this.tagTeal,
    required this.tagYg,
    required this.tick,
    required this.trackOff,
    required this.warning,
    required this.warningStrong,
    required this.warningTint,
  });

  final Color accent;
  final Color accentStrong;
  final Color background;
  final Color border;
  final Color card;
  final Color destructive;
  final Color destructivePressed;
  final Color destructiveStrong;
  final Color destructiveTint;
  final Color dot;
  final Color faviconTile;
  final Color foreground;
  final Color glow;
  final Color hairline;
  final Color input;
  final Color inverse;
  final Color material;
  final Color materialSep;
  final Color mutedForeground;
  final Color onInverse;
  final Color pressOnPrimary;
  final Color primary;
  final Color primary10;
  final Color primary15;
  final Color primary20;
  final Color primary30;
  final Color primary60;
  final Color primaryForeground;
  final Color ring;
  final Color scrim;
  final Color secondary;
  final Color sidebar;
  final Color tagBlue;
  final Color tagGold;
  final Color tagGreen;
  final Color tagOrange;
  final Color tagPink;
  final Color tagSlate;
  final Color tagTeal;
  final Color tagYg;
  final Color tick;
  final Color trackOff;
  final Color warning;
  final Color warningStrong;
  final Color warningTint;

  static const AppColors light = AppColors(
    accent: Color.from(alpha: 0.1, red: 0 / 255, green: 0 / 255, blue: 0 / 255),
    accentStrong: Color(0xFF24559E),
    background: Color(0xFFE7EAF1),
    border: Color.from(
      alpha: 0.05,
      red: 0 / 255,
      green: 0 / 255,
      blue: 0 / 255,
    ),
    card: Color(0xFFF8F9FC),
    destructive: Color(0xFFDC2626),
    destructivePressed: Color.from(
      alpha: 0.2,
      red: 220 / 255,
      green: 38 / 255,
      blue: 38 / 255,
    ),
    destructiveStrong: Color(0xFFB91C1C),
    destructiveTint: Color.from(
      alpha: 0.1,
      red: 220 / 255,
      green: 38 / 255,
      blue: 38 / 255,
    ),
    dot: Color.from(
      alpha: 0.12,
      red: 58 / 255,
      green: 61 / 255,
      blue: 70 / 255,
    ),
    faviconTile: Color(0xFFFFFFFF),
    foreground: Color(0xFF3A3D46),
    glow: Color.from(
      alpha: 0.35,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    hairline: Color.from(
      alpha: 0.1,
      red: 58 / 255,
      green: 61 / 255,
      blue: 70 / 255,
    ),
    input: Color.from(alpha: 0.05, red: 0 / 255, green: 0 / 255, blue: 0 / 255),
    inverse: Color(0xFF3A3D46),
    material: Color.from(
      alpha: 0.94,
      red: 248 / 255,
      green: 249 / 255,
      blue: 252 / 255,
    ),
    materialSep: Color.from(
      alpha: 0.18,
      red: 60 / 255,
      green: 60 / 255,
      blue: 67 / 255,
    ),
    mutedForeground: Color(0xFF60636A),
    onInverse: Color(0xFFF8F9FC),
    pressOnPrimary: Color.from(
      alpha: 0.1,
      red: 26 / 255,
      green: 28 / 255,
      blue: 34 / 255,
    ),
    primary: Color(0xFF85ADE5),
    primary10: Color.from(
      alpha: 0.1,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primary15: Color.from(
      alpha: 0.15,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primary20: Color.from(
      alpha: 0.2,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primary30: Color.from(
      alpha: 0.3,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primary60: Color.from(
      alpha: 0.6,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primaryForeground: Color(0xFF1A1C22),
    ring: Color(0xFF85ADE5),
    scrim: Color.from(
      alpha: 0.4,
      red: 12 / 255,
      green: 13 / 255,
      blue: 16 / 255,
    ),
    secondary: Color.from(
      alpha: 0.05,
      red: 0 / 255,
      green: 0 / 255,
      blue: 0 / 255,
    ),
    sidebar: Color(0xFFF1F3F8),
    tagBlue: Color(0xFF006FAC),
    tagGold: Color(0xFF8C6100),
    tagGreen: Color(0xFF00794B),
    tagOrange: Color(0xFFA05600),
    tagPink: Color(0xFFBA3A5E),
    tagSlate: Color(0xFF606979),
    tagTeal: Color(0xFF007672),
    tagYg: Color(0xFF487621),
    tick: Color.from(
      alpha: 0.22,
      red: 58 / 255,
      green: 61 / 255,
      blue: 70 / 255,
    ),
    trackOff: Color.from(
      alpha: 0.16,
      red: 58 / 255,
      green: 61 / 255,
      blue: 70 / 255,
    ),
    warning: Color(0xFFF59E0B),
    warningStrong: Color(0xFF92400E),
    warningTint: Color.from(
      alpha: 0.15,
      red: 245 / 255,
      green: 158 / 255,
      blue: 11 / 255,
    ),
  );

  static const AppColors dark = AppColors(
    accent: Color.from(
      alpha: 0.1,
      red: 255 / 255,
      green: 255 / 255,
      blue: 255 / 255,
    ),
    accentStrong: Color(0xFF85ADE5),
    background: Color(0xFF0C0D10),
    border: Color.from(
      alpha: 0.05,
      red: 255 / 255,
      green: 255 / 255,
      blue: 255 / 255,
    ),
    card: Color(0xFF1A1C22),
    destructive: Color(0xFFDC2626),
    destructivePressed: Color.from(
      alpha: 0.3,
      red: 220 / 255,
      green: 38 / 255,
      blue: 38 / 255,
    ),
    destructiveStrong: Color(0xFFF87171),
    destructiveTint: Color.from(
      alpha: 0.2,
      red: 220 / 255,
      green: 38 / 255,
      blue: 38 / 255,
    ),
    dot: Color.from(
      alpha: 0.1,
      red: 232 / 255,
      green: 233 / 255,
      blue: 237 / 255,
    ),
    faviconTile: Color(0xFFFFFFFF),
    foreground: Color(0xFFE8E9ED),
    glow: Color.from(
      alpha: 0.15,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    hairline: Color.from(
      alpha: 0.1,
      red: 232 / 255,
      green: 233 / 255,
      blue: 237 / 255,
    ),
    input: Color.from(
      alpha: 0.05,
      red: 255 / 255,
      green: 255 / 255,
      blue: 255 / 255,
    ),
    inverse: Color(0xFFE8E9ED),
    material: Color.from(
      alpha: 0.94,
      red: 40 / 255,
      green: 42 / 255,
      blue: 48 / 255,
    ),
    materialSep: Color.from(
      alpha: 0.14,
      red: 235 / 255,
      green: 235 / 255,
      blue: 245 / 255,
    ),
    mutedForeground: Color(0xFFAAACB0),
    onInverse: Color(0xFF1A1C22),
    pressOnPrimary: Color.from(
      alpha: 0.1,
      red: 26 / 255,
      green: 28 / 255,
      blue: 34 / 255,
    ),
    primary: Color(0xFF85ADE5),
    primary10: Color.from(
      alpha: 0.1,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primary15: Color.from(
      alpha: 0.15,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primary20: Color.from(
      alpha: 0.2,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primary30: Color.from(
      alpha: 0.3,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primary60: Color.from(
      alpha: 0.6,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    primaryForeground: Color(0xFF1A1C22),
    ring: Color(0xFF85ADE5),
    scrim: Color.from(alpha: 0.6, red: 0 / 255, green: 0 / 255, blue: 0 / 255),
    secondary: Color.from(
      alpha: 0.05,
      red: 255 / 255,
      green: 255 / 255,
      blue: 255 / 255,
    ),
    sidebar: Color(0xFF15171C),
    tagBlue: Color(0xFF3BB7F9),
    tagGold: Color(0xFFE0B23C),
    tagGreen: Color(0xFF4CAF7D),
    tagOrange: Color(0xFFF0A04B),
    tagPink: Color(0xFFF26D8D),
    tagSlate: Color(0xFF8D97A8),
    tagTeal: Color(0xFF3FC7C1),
    tagYg: Color(0xFF8EC06C),
    tick: Color.from(
      alpha: 0.18,
      red: 232 / 255,
      green: 233 / 255,
      blue: 237 / 255,
    ),
    trackOff: Color.from(
      alpha: 0.18,
      red: 232 / 255,
      green: 233 / 255,
      blue: 237 / 255,
    ),
    warning: Color(0xFFF59E0B),
    warningStrong: Color(0xFFFBBF24),
    warningTint: Color.from(
      alpha: 0.2,
      red: 245 / 255,
      green: 158 / 255,
      blue: 11 / 255,
    ),
  );

  /// Every token by its design name (CSS variable without `--`).
  Map<String, Color> get tokens => <String, Color>{
    'accent': accent,
    'accent-strong': accentStrong,
    'background': background,
    'border': border,
    'card': card,
    'destructive': destructive,
    'destructive-pressed': destructivePressed,
    'destructive-strong': destructiveStrong,
    'destructive-tint': destructiveTint,
    'dot': dot,
    'favicon-tile': faviconTile,
    'foreground': foreground,
    'glow': glow,
    'hairline': hairline,
    'input': input,
    'inverse': inverse,
    'material': material,
    'material-sep': materialSep,
    'muted-foreground': mutedForeground,
    'on-inverse': onInverse,
    'press-on-primary': pressOnPrimary,
    'primary': primary,
    'primary-10': primary10,
    'primary-15': primary15,
    'primary-20': primary20,
    'primary-30': primary30,
    'primary-60': primary60,
    'primary-foreground': primaryForeground,
    'ring': ring,
    'scrim': scrim,
    'secondary': secondary,
    'sidebar': sidebar,
    'tag-blue': tagBlue,
    'tag-gold': tagGold,
    'tag-green': tagGreen,
    'tag-orange': tagOrange,
    'tag-pink': tagPink,
    'tag-slate': tagSlate,
    'tag-teal': tagTeal,
    'tag-yg': tagYg,
    'tick': tick,
    'track-off': trackOff,
    'warning': warning,
    'warning-strong': warningStrong,
    'warning-tint': warningTint,
  };

  /// The colour of a tag's chip text and icon (see `tagColorFor`). Dark uses
  /// the palette as it is; light uses darker versions that reach 4.5 : 1.
  Color tag(TagColor color) => switch (color) {
    TagColor.blue => tagBlue,
    TagColor.yellowGreen => tagYg,
    TagColor.green => tagGreen,
    TagColor.orange => tagOrange,
    TagColor.pink => tagPink,
    TagColor.teal => tagTeal,
    TagColor.gold => tagGold,
    TagColor.slate => tagSlate,
  };

  @override
  AppColors copyWith({
    Color? accent,
    Color? accentStrong,
    Color? background,
    Color? border,
    Color? card,
    Color? destructive,
    Color? destructivePressed,
    Color? destructiveStrong,
    Color? destructiveTint,
    Color? dot,
    Color? faviconTile,
    Color? foreground,
    Color? glow,
    Color? hairline,
    Color? input,
    Color? inverse,
    Color? material,
    Color? materialSep,
    Color? mutedForeground,
    Color? onInverse,
    Color? pressOnPrimary,
    Color? primary,
    Color? primary10,
    Color? primary15,
    Color? primary20,
    Color? primary30,
    Color? primary60,
    Color? primaryForeground,
    Color? ring,
    Color? scrim,
    Color? secondary,
    Color? sidebar,
    Color? tagBlue,
    Color? tagGold,
    Color? tagGreen,
    Color? tagOrange,
    Color? tagPink,
    Color? tagSlate,
    Color? tagTeal,
    Color? tagYg,
    Color? tick,
    Color? trackOff,
    Color? warning,
    Color? warningStrong,
    Color? warningTint,
  }) {
    return AppColors(
      accent: accent ?? this.accent,
      accentStrong: accentStrong ?? this.accentStrong,
      background: background ?? this.background,
      border: border ?? this.border,
      card: card ?? this.card,
      destructive: destructive ?? this.destructive,
      destructivePressed: destructivePressed ?? this.destructivePressed,
      destructiveStrong: destructiveStrong ?? this.destructiveStrong,
      destructiveTint: destructiveTint ?? this.destructiveTint,
      dot: dot ?? this.dot,
      faviconTile: faviconTile ?? this.faviconTile,
      foreground: foreground ?? this.foreground,
      glow: glow ?? this.glow,
      hairline: hairline ?? this.hairline,
      input: input ?? this.input,
      inverse: inverse ?? this.inverse,
      material: material ?? this.material,
      materialSep: materialSep ?? this.materialSep,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      onInverse: onInverse ?? this.onInverse,
      pressOnPrimary: pressOnPrimary ?? this.pressOnPrimary,
      primary: primary ?? this.primary,
      primary10: primary10 ?? this.primary10,
      primary15: primary15 ?? this.primary15,
      primary20: primary20 ?? this.primary20,
      primary30: primary30 ?? this.primary30,
      primary60: primary60 ?? this.primary60,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      ring: ring ?? this.ring,
      scrim: scrim ?? this.scrim,
      secondary: secondary ?? this.secondary,
      sidebar: sidebar ?? this.sidebar,
      tagBlue: tagBlue ?? this.tagBlue,
      tagGold: tagGold ?? this.tagGold,
      tagGreen: tagGreen ?? this.tagGreen,
      tagOrange: tagOrange ?? this.tagOrange,
      tagPink: tagPink ?? this.tagPink,
      tagSlate: tagSlate ?? this.tagSlate,
      tagTeal: tagTeal ?? this.tagTeal,
      tagYg: tagYg ?? this.tagYg,
      tick: tick ?? this.tick,
      trackOff: trackOff ?? this.trackOff,
      warning: warning ?? this.warning,
      warningStrong: warningStrong ?? this.warningStrong,
      warningTint: warningTint ?? this.warningTint,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;
    return AppColors(
      accent: Color.lerp(accent, other.accent, t)!,
      accentStrong: Color.lerp(accentStrong, other.accentStrong, t)!,
      background: Color.lerp(background, other.background, t)!,
      border: Color.lerp(border, other.border, t)!,
      card: Color.lerp(card, other.card, t)!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      destructivePressed: Color.lerp(
        destructivePressed,
        other.destructivePressed,
        t,
      )!,
      destructiveStrong: Color.lerp(
        destructiveStrong,
        other.destructiveStrong,
        t,
      )!,
      destructiveTint: Color.lerp(destructiveTint, other.destructiveTint, t)!,
      dot: Color.lerp(dot, other.dot, t)!,
      faviconTile: Color.lerp(faviconTile, other.faviconTile, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      glow: Color.lerp(glow, other.glow, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
      input: Color.lerp(input, other.input, t)!,
      inverse: Color.lerp(inverse, other.inverse, t)!,
      material: Color.lerp(material, other.material, t)!,
      materialSep: Color.lerp(materialSep, other.materialSep, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      onInverse: Color.lerp(onInverse, other.onInverse, t)!,
      pressOnPrimary: Color.lerp(pressOnPrimary, other.pressOnPrimary, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primary10: Color.lerp(primary10, other.primary10, t)!,
      primary15: Color.lerp(primary15, other.primary15, t)!,
      primary20: Color.lerp(primary20, other.primary20, t)!,
      primary30: Color.lerp(primary30, other.primary30, t)!,
      primary60: Color.lerp(primary60, other.primary60, t)!,
      primaryForeground: Color.lerp(
        primaryForeground,
        other.primaryForeground,
        t,
      )!,
      ring: Color.lerp(ring, other.ring, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      sidebar: Color.lerp(sidebar, other.sidebar, t)!,
      tagBlue: Color.lerp(tagBlue, other.tagBlue, t)!,
      tagGold: Color.lerp(tagGold, other.tagGold, t)!,
      tagGreen: Color.lerp(tagGreen, other.tagGreen, t)!,
      tagOrange: Color.lerp(tagOrange, other.tagOrange, t)!,
      tagPink: Color.lerp(tagPink, other.tagPink, t)!,
      tagSlate: Color.lerp(tagSlate, other.tagSlate, t)!,
      tagTeal: Color.lerp(tagTeal, other.tagTeal, t)!,
      tagYg: Color.lerp(tagYg, other.tagYg, t)!,
      tick: Color.lerp(tick, other.tick, t)!,
      trackOff: Color.lerp(trackOff, other.trackOff, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningStrong: Color.lerp(warningStrong, other.warningStrong, t)!,
      warningTint: Color.lerp(warningTint, other.warningTint, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  /// The design's colour tokens for the current theme.
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
}
