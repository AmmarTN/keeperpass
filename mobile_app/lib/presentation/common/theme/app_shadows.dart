// Design shadows (depth) for light and dark.
//
// Values copied from the design canvas's shared component stylesheet
// (board C1-Buttons-fields, <helmet>: .kp-light / .kp-dark), which the plan
// names as the token source of truth. When the design changes, update this file
// and test/fixtures/design_tokens.json (the stylesheet's raw values) together;
// test/presentation/common/theme/design_tokens_test.dart checks one against the
// other.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@immutable
class AppShadows extends ThemeExtension<AppShadows> {
  const AppShadows._({
    required this._shadowXs,
    required this._shadowFloat,
    required this._lift,
    required this._dockShadow,
    required this._focus,
    required this._error,
  });

  final List<_Shadow> _shadowXs;
  final List<_Shadow> _shadowFloat;
  final List<_Shadow> _lift;
  final List<_Shadow> _dockShadow;
  final List<_Shadow> _focus;
  final List<_Shadow> _error;

  static const AppShadows light = AppShadows._(
    shadowXs: <_Shadow>[
      _Shadow(
        0,
        1,
        2,
        0,
        Color.from(alpha: 0.05, red: 0 / 255, green: 0 / 255, blue: 0 / 255),
      ),
    ],
    shadowFloat: <_Shadow>[
      _Shadow(
        0,
        8,
        24,
        -6,
        Color.from(alpha: 0.18, red: 12 / 255, green: 13 / 255, blue: 16 / 255),
      ),
    ],
    lift: <_Shadow>[
      _Shadow(
        0,
        28,
        56,
        -28,
        Color.from(alpha: 0.35, red: 0 / 255, green: 0 / 255, blue: 0 / 255),
      ),
    ],
    dockShadow: <_Shadow>[
      _Shadow(
        0,
        -1,
        0,
        0,
        Color.from(alpha: 0.08, red: 58 / 255, green: 61 / 255, blue: 70 / 255),
      ),
      _Shadow(
        0,
        -22,
        44,
        -32,
        Color.from(alpha: 0.4, red: 12 / 255, green: 13 / 255, blue: 16 / 255),
      ),
    ],
    focus: <_Shadow>[
      _Shadow(0, 0, 0, 1.5, Color(0xFF85ADE5)),
      _Shadow(
        0,
        0,
        0,
        4.5,
        Color.from(
          alpha: 0.25,
          red: 133 / 255,
          green: 173 / 255,
          blue: 229 / 255,
        ),
      ),
    ],
    error: <_Shadow>[
      _Shadow(0, 0, 0, 1.5, Color(0xFFDC2626)),
      _Shadow(
        0,
        0,
        0,
        4.5,
        Color.from(
          alpha: 0.15,
          red: 220 / 255,
          green: 38 / 255,
          blue: 38 / 255,
        ),
      ),
    ],
  );

  static const AppShadows dark = AppShadows._(
    shadowXs: <_Shadow>[
      _Shadow(
        0,
        1,
        2,
        0,
        Color.from(alpha: 0.25, red: 0 / 255, green: 0 / 255, blue: 0 / 255),
      ),
    ],
    shadowFloat: <_Shadow>[
      _Shadow(
        0,
        8,
        24,
        -6,
        Color.from(alpha: 0.6, red: 0 / 255, green: 0 / 255, blue: 0 / 255),
      ),
    ],
    lift: <_Shadow>[
      _Shadow(
        0,
        28,
        56,
        -28,
        Color.from(alpha: 0.8, red: 0 / 255, green: 0 / 255, blue: 0 / 255),
      ),
    ],
    dockShadow: <_Shadow>[
      _Shadow(
        0,
        -1,
        0,
        0,
        Color.from(
          alpha: 0.08,
          red: 232 / 255,
          green: 233 / 255,
          blue: 237 / 255,
        ),
      ),
      _Shadow(
        0,
        -22,
        44,
        -32,
        Color.from(alpha: 0.85, red: 0 / 255, green: 0 / 255, blue: 0 / 255),
      ),
    ],
    focus: <_Shadow>[
      _Shadow(0, 0, 0, 1.5, Color(0xFF85ADE5)),
      _Shadow(
        0,
        0,
        0,
        4.5,
        Color.from(
          alpha: 0.25,
          red: 133 / 255,
          green: 173 / 255,
          blue: 229 / 255,
        ),
      ),
    ],
    error: <_Shadow>[
      _Shadow(0, 0, 0, 1.5, Color(0xFFDC2626)),
      _Shadow(
        0,
        0,
        0,
        4.5,
        Color.from(
          alpha: 0.15,
          red: 220 / 255,
          green: 38 / 255,
          blue: 38 / 255,
        ),
      ),
    ],
  );

  /// Resting surfaces: rows, grouped lists, cards (with the hairline ring).
  List<BoxShadow> get shadowXs => _scaled(_shadowXs);

  /// Only for things that float: toasts, menus.
  List<BoxShadow> get shadowFloat => _scaled(_shadowFloat);

  /// The lifted vault card and dock surfaces.
  List<BoxShadow> get lift => _scaled(_lift);

  /// The bottom dock: a hairline and a soft upward shadow.
  List<BoxShadow> get dockShadow => _scaled(_dockShadow);

  /// Focus ring for hardware keyboards and Switch/Full Keyboard Access.
  List<BoxShadow> get focus => _scaled(_focus);

  /// Error ring around a field.
  List<BoxShadow> get error => _scaled(_error);

  /// Every shadow by its design name (CSS variable without `--`).
  Map<String, List<BoxShadow>> get tokens => <String, List<BoxShadow>>{
    'shadow-xs': shadowXs,
    'shadow-float': shadowFloat,
    'lift': lift,
    'dock-shadow': dockShadow,
    'focus': focus,
    'error': error,
  };

  static List<BoxShadow> _scaled(List<_Shadow> shadows) => <BoxShadow>[
    for (final _Shadow s in shadows)
      BoxShadow(
        color: s.color,
        offset: Offset(s.x.r, s.y.r),
        blurRadius: cssBlurToBlurRadius(s.blur.r),
        spreadRadius: s.spread.r,
      ),
  ];

  /// The Flutter blur radius that is as soft as a CSS blur of [cssBlur]
  /// (plan, open item O8). CSS blurs with σ = blur / 2; Flutter turns a blur
  /// radius r into σ = 0.57735 r + 0.5 (`Shadow.convertRadiusToSigma`), so the
  /// same number would be about 20 % softer and wider than on the canvas.
  /// Measured on a blur of 24: σ 11.9 in Chrome, 14.4 in Flutter as is, 11.9
  /// converted. A CSS blur of 1 or less becomes 0 (a hard edge).
  static double cssBlurToBlurRadius(double cssBlur) =>
      cssBlur <= 1 ? 0 : (cssBlur / 2 - 0.5) / 0.57735;

  @override
  AppShadows copyWith() => this;

  @override
  AppShadows lerp(covariant AppShadows? other, double t) {
    if (other == null) return this;
    return AppShadows._(
      shadowXs: t < 0.5 ? _shadowXs : other._shadowXs,
      shadowFloat: t < 0.5 ? _shadowFloat : other._shadowFloat,
      lift: t < 0.5 ? _lift : other._lift,
      dockShadow: t < 0.5 ? _dockShadow : other._dockShadow,
      focus: t < 0.5 ? _focus : other._focus,
      error: t < 0.5 ? _error : other._error,
    );
  }
}

/// One CSS box-shadow in design points: x, y, blur, spread, colour.
@immutable
class _Shadow {
  const _Shadow(this.x, this.y, this.blur, this.spread, this.color);

  final double x;
  final double y;
  final double blur;
  final double spread;
  final Color color;
}

extension AppShadowsContext on BuildContext {
  /// The design's shadows for the current theme.
  AppShadows get shadows => Theme.of(this).extension<AppShadows>()!;
}
