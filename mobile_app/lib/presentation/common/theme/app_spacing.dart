/// The design's 4 pt spacing grid (board: Spacing, shape and depth).
///
/// Raw design points: apply `.w` to horizontal spacing and `.h` to vertical
/// spacing at use sites. Insets supplied by the system stay unscaled.
abstract final class AppSpacing {
  /// 4 — icon to label inside pills and chips.
  static const double xxs = 4;

  /// 8 — between chips; label to its field.
  static const double xs = 8;

  /// 12 — icon tile to text; stacked fields.
  static const double sm = 12;

  /// 16 — screen margin; row and card padding.
  static const double md = 16;

  /// 20 — sheet and dialog padding.
  static const double lg = 20;

  /// 24 — between sections and list groups.
  static const double xl = 24;

  /// 32 — around empty states and screen headers.
  static const double xxl = 32;

  /// 40 — icon tile.
  static const double xxxl = 40;

  // Named sizes from the same board.

  static const double screenMargin = md;
  static const double sheetPadding = lg;
  static const double sectionGap = xl;
  static const double iconTile = xxxl;

  /// 48 — text field height (and the Android touch target).
  static const double fieldHeight = 48;

  /// 64 — item row height.
  static const double itemRowHeight = 64;

  /// Minimum touch target: 44 × 44 pt on iOS.
  static const double touchTargetIos = 44;

  /// Minimum touch target: 48 × 48 dp on Android.
  static const double touchTargetAndroid = 48;

  /// Neighbouring touch targets keep at least this much apart.
  static const double touchTargetGap = xs;
}
