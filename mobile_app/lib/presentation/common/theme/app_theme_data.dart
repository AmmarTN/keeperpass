import 'package:flutter/material.dart';
import 'package:keeperpass/presentation/common/theme/app_colors.dart';
import 'package:keeperpass/presentation/common/theme/app_shadows.dart';
import 'package:keeperpass/presentation/common/theme/app_story_theme.dart';
import 'package:keeperpass/presentation/common/theme/app_text_styles.dart';

/// Light and dark [ThemeData] built from the design tokens.
///
/// Components read the tokens directly (`context.colors`, `context.shadows`,
/// `AppTextStyles(context)`); the Material colour scheme and text theme are
/// mapped from the same tokens so stock Material widgets match too.
class AppThemeData {
  const AppThemeData._();

  static ThemeData getAppThemeData({
    required Brightness brightness,
    required BuildContext context,
  }) {
    final bool isDark = brightness == Brightness.dark;
    final AppColors c = isDark ? AppColors.dark : AppColors.light;
    final AppShadows shadows = isDark ? AppShadows.dark : AppShadows.light;
    final AppTextStyles styles = AppTextStyles(context);

    // Every slot uses a design style, so Material never asks for a Nunito
    // weight the app does not bundle (only 400, 600, 700 and 800 ship).
    final TextTheme textTheme = TextTheme(
      displayLarge: styles.display(),
      displayMedium: styles.stat(),
      displaySmall: styles.largeTitle(),
      headlineLarge: styles.largeTitle(),
      headlineMedium: styles.itemTitle(),
      headlineSmall: styles.appBarTitle(),
      titleLarge: styles.title(),
      titleMedium: styles.rowTitle(),
      titleSmall: styles.bodyStrong(),
      bodyLarge: styles.body(),
      bodyMedium: styles.body(),
      bodySmall: styles.secondary(),
      labelLarge: styles.button(),
      labelMedium: styles.fieldLabel(),
      labelSmall: styles.badge(),
    ).apply(bodyColor: c.foreground, displayColor: c.foreground);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: c.background,
      canvasColor: c.background,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      dividerColor: c.border,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: c.primary,
        onPrimary: c.primaryForeground,
        secondary: c.accentStrong,
        onSecondary: isDark ? c.primaryForeground : c.card,
        error: c.destructive,
        // "White text 4.8 : 1" on destructive (board: Color tokens).
        onError: Colors.white,
        surface: c.card,
        onSurface: c.foreground,
        onSurfaceVariant: c.mutedForeground,
        outline: c.border,
        outlineVariant: c.hairline,
        scrim: c.scrim,
        inverseSurface: c.inverse,
        onInverseSurface: c.onInverse,
      ),
      textTheme: textTheme,
      iconTheme: IconThemeData(color: c.foreground),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: c.primary,
        selectionColor: c.primary30,
        selectionHandleColor: c.primary,
      ),
      extensions: <ThemeExtension<dynamic>>[
        c,
        shadows,
        if (isDark) AppStoryTheme.dark else AppStoryTheme.light,
      ],
    );
  }
}
