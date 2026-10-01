import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppDarkColors.background,
      fontFamily: 'serif',
      colorScheme: const ColorScheme.dark(
        surface: AppDarkColors.surface,
        primary: AppDarkColors.primary,
        onPrimary: AppDarkColors.onPrimary,
        secondary: AppDarkColors.secondary,
        onSurface: AppDarkColors.onSurface,
        onSurfaceVariant: AppDarkColors.onSurfaceVariant,
        outline: AppDarkColors.outline,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppDarkColors.background,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppDarkColors.onSurface),
      ),
      cardTheme: CardThemeData(
        color: AppDarkColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppDarkColors.cardBorder, width: 1.2),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppLightColors.background,
      fontFamily: 'sans-serif',
      colorScheme: const ColorScheme.light(
        surface: AppLightColors.surface,
        primary: AppLightColors.primary,
        onPrimary: AppLightColors.onPrimary,
        primaryContainer: AppLightColors.primaryContainer,
        secondary: AppLightColors.secondary,
        secondaryContainer: AppLightColors.secondaryContainer,
        onSecondaryContainer: AppLightColors.onSecondaryContainer,
        onSurface: AppLightColors.onSurface,
        onSurfaceVariant: AppLightColors.onSurfaceVariant,
        outline: AppLightColors.outline,
        outlineVariant: AppLightColors.outlineVariant,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppLightColors.textPrimary),
      ),
      cardTheme: CardThemeData(
        color: AppLightColors.cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: AppLightColors.cardBorder, width: 1.2),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppLightColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(color: AppLightColors.cardBorder, width: 1.2),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppLightColors.chipBackground,
        selectedColor: AppLightColors.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppLightColors.cardBorder, width: 1),
        ),
        labelStyle: const TextStyle(
          color: AppLightColors.textPrimary,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
