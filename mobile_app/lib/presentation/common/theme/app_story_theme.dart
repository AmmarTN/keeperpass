import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';

/// The How it works story's own tokens (boards `ALT-HW1-1-Story-First` and
/// `ALT-HW1-2-Story-Last`, their `--x-*` variables and `.al-*` shadows),
/// drawn exactly as the story boards (your decision, 2026-10-31) — a whiter
/// sheet and darker ink than the rest of the app.
///
/// The dark shadows' 1 pt white inset top edge (5–6 %) is not drawn: Flutter
/// shadows have no inset.
@immutable
class AppStoryTheme extends ThemeExtension<AppStoryTheme> {
  const AppStoryTheme._({
    required this.surface,
    required this.ink,
    required this.separator,
    required this.wash,
    required this.scrim,
    required this._card,
    required this._sheet,
    required this._cta,
  });

  /// `--x-surface`: the sheet, cards, chips and nodes.
  final Color surface;

  /// `--x-ink`: titles and names.
  final Color ink;

  /// `--x-sep`: the resting page dots.
  final Color separator;

  /// `--x-wash`: the soft accent glow behind step 3's picture.
  final Color wash;

  /// `.al-scrim`: behind the sheet.
  final Color scrim;

  final List<_StoryShadow> _card;
  final List<_StoryShadow> _sheet;
  final List<_StoryShadow> _cta;

  static const AppStoryTheme light = AppStoryTheme._(
    surface: Color(0xFFFFFFFF),
    ink: Color(0xFF20232B),
    separator: Color.from(
      alpha: 0.08,
      red: 58 / 255,
      green: 61 / 255,
      blue: 70 / 255,
    ),
    wash: Color.from(
      alpha: 0.30,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    scrim: Color.from(
      alpha: 0.38,
      red: 8 / 255,
      green: 10 / 255,
      blue: 14 / 255,
    ),
    card: <_StoryShadow>[
      _StoryShadow(
        0,
        1,
        2,
        0,
        Color.from(alpha: 0.05, red: 16 / 255, green: 24 / 255, blue: 40 / 255),
      ),
      _StoryShadow(
        0,
        10,
        26,
        -14,
        Color.from(alpha: 0.22, red: 16 / 255, green: 24 / 255, blue: 40 / 255),
      ),
    ],
    sheet: _sheetShadow,
    cta: _ctaShadow,
  );

  static const AppStoryTheme dark = AppStoryTheme._(
    surface: Color(0xFF1A1C22),
    ink: Color(0xFFF3F4F7),
    separator: Color.from(
      alpha: 0.08,
      red: 232 / 255,
      green: 233 / 255,
      blue: 237 / 255,
    ),
    wash: Color.from(
      alpha: 0.18,
      red: 133 / 255,
      green: 173 / 255,
      blue: 229 / 255,
    ),
    scrim: Color.from(alpha: 0.58, red: 0, green: 0, blue: 0),
    card: <_StoryShadow>[
      _StoryShadow(
        0,
        12,
        28,
        -14,
        Color.from(alpha: 0.80, red: 0, green: 0, blue: 0),
      ),
    ],
    sheet: _sheetShadow,
    cta: _ctaShadow,
  );

  /// `.al-sheet`: 0 −10px 40px −10px rgb(0 0 0 / 35 %), both themes.
  static const List<_StoryShadow> _sheetShadow = <_StoryShadow>[
    _StoryShadow(
      0,
      -10,
      40,
      -10,
      Color.from(alpha: 0.35, red: 0, green: 0, blue: 0),
    ),
  ];

  /// Step 1's file card (inline on both boards): 0 20px 40px −18px
  /// rgb(16 24 40 / 45 %).
  static const List<_StoryShadow> _fileCardShadow = <_StoryShadow>[
    _StoryShadow(
      0,
      20,
      40,
      -18,
      Color.from(alpha: 0.45, red: 16 / 255, green: 24 / 255, blue: 40 / 255),
    ),
  ];

  /// `.al-cta`: 0 14px 28px −14px rgb(64 110 180 / 75 %), both themes.
  static const List<_StoryShadow> _ctaShadow = <_StoryShadow>[
    _StoryShadow(
      0,
      14,
      28,
      -14,
      Color.from(alpha: 0.75, red: 64 / 255, green: 110 / 255, blue: 180 / 255),
    ),
  ];

  /// `--x-shadow`: cards, chips and nodes.
  List<BoxShadow> get card => _scaled(_card);

  List<BoxShadow> get sheet => _scaled(_sheet);

  List<BoxShadow> get cta => _scaled(_cta);

  /// Step 1's vault file card.
  List<BoxShadow> get fileCard => _scaled(_fileCardShadow);

  static List<BoxShadow> _scaled(List<_StoryShadow> shadows) => <BoxShadow>[
    for (final _StoryShadow s in shadows)
      BoxShadow(
        color: s.color,
        offset: Offset(s.x.r, s.y.r),
        blurRadius: AppShadows.cssBlurToBlurRadius(s.blur.r),
        spreadRadius: s.spread.r,
      ),
  ];

  @override
  AppStoryTheme copyWith() => this;

  @override
  AppStoryTheme lerp(covariant AppStoryTheme? other, double t) =>
      other == null || t < 0.5 ? this : other;
}

@immutable
class _StoryShadow {
  const _StoryShadow(this.x, this.y, this.blur, this.spread, this.color);

  final double x;
  final double y;
  final double blur;
  final double spread;
  final Color color;
}

extension AppStoryThemeContext on BuildContext {
  /// The How it works story's tokens for the current theme.
  AppStoryTheme get story => Theme.of(this).extension<AppStoryTheme>()!;
}
