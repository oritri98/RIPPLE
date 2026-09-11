import 'package:flutter/material.dart';

/// AppColors holds every color used throughout the Ripple app.
/// 
/// BEGINNER TIP:
/// Keeping your colors together in one class makes it super easy
/// to change your color theme later without hunting through 20 different files!
class AppColors {
  // Deep espresso background surfaces
  static const Color background = Color(0xFF181210);
  static const Color surface = Color(0xFF181210);
  static const Color surfaceContainerLowest = Color(0xFF120D0B);
  static const Color surfaceContainerLow = Color(0xFF201A18);
  static const Color surfaceContainer = Color(0xFF251E1C);
  static const Color surfaceContainerHigh = Color(0xFF2F2826);
  static const Color surfaceContainerHighest = Color(0xFF3B3331);

  // Warm glowing accents (Caramel / Honey / Amber)
  static const Color primary = Color(0xFFFEC486);
  static const Color primaryContainer = Color(0xFFE0A96D);
  static const Color onPrimary = Color(0xFF482900);
  static const Color secondary = Color(0xFFFFB689);
  static const Color secondaryContainer = Color(0xFF71370A);
  static const Color onSecondaryContainer = Color(0xFFF4A26D);

  // Text and outline colors
  static const Color onSurface = Color(0xFFEDE0DC); // Parchment cream for titles & main text
  static const Color onSurfaceVariant = Color(0xFFD4C4B5); // Oatmeal linen for subtitles & secondary text
  static const Color outline = Color(0xFF9D8E81); // Muted gray for completed tasks & borders
  static const Color outlineVariant = Color(0xFF50453A);
}

/// AppTheme provides the dark theme configuration for the entire application.
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      
      // Color scheme mapping
      colorScheme: const ColorScheme.dark(
        surface: AppColors.surface,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSurface: AppColors.onSurface,
        onSurfaceVariant: AppColors.onSurfaceVariant,
        outline: AppColors.outline,
      ),

      // App bar theme
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: false,
      ),
    );
  }
}
