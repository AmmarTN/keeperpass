/// Centralized paths for assets bundled with the application.
///
/// Add a named constant for every asset used by Dart code. Widgets should
/// reference this file instead of repeating path strings.
abstract final class AppAssets {
  static const String animations = 'assets/animations';
  static const String fonts = 'assets/fonts';
  static const String pngIcons = 'assets/icons/png';
  static const String svgIcons = 'assets/icons/svg';
  static const String pngImages = 'assets/images/png';
  static const String svgImages = 'assets/images/svg';

  /// Neutral placeholder mark. Replace it when creating a real app instance.
  static const String appMark = '$svgIcons/app_mark.svg';
}
