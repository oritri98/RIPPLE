import 'package:flutter/material.dart';
import '../theme/theme_manager.dart';

/// AppDarkColors holds the unified luxury espresso and warm honey amber palette.
class AppDarkColors {
  // Deep espresso background surfaces
  static const Color background = Color(0xFF181210);
  static const Color surface = Color(0xFF181210);
  static const Color surfaceContainerLowest = Color(0xFF120D0B);
  static const Color surfaceContainerLow = Color(0xFF201A18);
  static const Color surfaceContainer = Color(0xFF251E1C);
  static const Color surfaceContainerHigh = Color(0xFF2F2826);
  static const Color surfaceContainerHighest = Color(0xFF3B3331);

  // Cards
  static const Color cardBg = Color(0xFF251E1C);
  static const Color cardBgSelected = Color(0xFF2F2826);
  static const Color cardBorder = Color(0xFF50453A);
  static const Color cardBorderSelected = Color(0xFFFEC486);

  // Warm glowing honey accents
  static const Color primary = Color(0xFFFEC486);
  static const Color primaryContainer = Color(0xFFE0A96D);
  static const Color accent = Color(0xFFFEC486);
  static const Color accentLight = Color(0xFFFFD5A5);
  static const Color onPrimary = Color(0xFF482900);
  static const Color secondary = Color(0xFFFFB689);
  static const Color secondaryContainer = Color(0xFF71370A);
  static const Color onSecondaryContainer = Color(0xFFF4A26D);
  static const Color chipBackground = Color(0xFF2F2826);

  // Text & Parchment colors
  static const Color onSurface = Color(0xFFEDE0DC);
  static const Color onSurfaceVariant = Color(0xFFD4C4B5);
  static const Color textPrimary = Color(0xFFEDE0DC);
  static const Color textSecondary = Color(0xFFD4C4B5);
  static const Color textMuted = Color(0xFF9D8E81);
  static const Color textDark = Color(0xFF181210);
  static const Color outline = Color(0xFF9D8E81);
  static const Color outlineVariant = Color(0xFF50453A);

  // Domain specific accents
  static const Color careerAccent = Color(0xFFFEC486);
  static const Color educationAccent = Color(0xFFE0A96D);
  static const Color healthAccent = Color(0xFF81B29A);
}

/// AppLightColors holds the futuristic Apple Silicon Liquid Glass aesthetic.
/// Features frosted ice whites, subtle translucent refraction layers, specular borders,
/// Apple Electric Azure & Iris Violet luminous accents, and ultra-crisp Obsidian typography.
class AppLightColors {
  // Frosted liquid glass canvas & surfaces
  static const Color background = Color(0xFFF0F4FA);
  static const Color surface = Color(0xFFF8FAFD);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFEDF2F9);
  static const Color surfaceContainer = Color(0xFFE4ECF6);
  static const Color surfaceContainerHigh = Color(0xFFD9E4F2);
  static const Color surfaceContainerHighest = Color(0xFFCEDCED);

  // Liquid Glass Cards: Translucent pure glass with white specular glow
  static const Color cardBg = Color(0xE8FFFFFF); // 91% translucent frosted glass
  static const Color cardBgSelected = Color(0xF2E6F2FF); // Electric azure tinted liquid glass
  static const Color cardBorder = Color(0x99FFFFFF); // Frosted specular edge
  static const Color cardBorderSelected = Color(0xFF0071E3); // Apple Silicon Electric Azure

  // Apple Silicon Electric Blue & Liquid Cyan Accents
  static const Color primary = Color(0xFF0071E3); // Apple signature system blue
  static const Color primaryContainer = Color(0xFFE1EFFF); // Frosted ice azure
  static const Color accent = Color(0xFF0071E3);
  static const Color accentLight = Color(0xFF3894FF);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color secondary = Color(0xFF5E5CE6); // Apple Silicon Iris Violet
  static const Color secondaryContainer = Color(0xFFECEBFF);
  static const Color onSecondaryContainer = Color(0xFF3230A8);
  static const Color chipBackground = Color(0xCCE8EFF8);

  // Obsidian & Slate Text (ultra crisp on liquid glass)
  static const Color onSurface = Color(0xFF1D1D1F); // Apple Obsidian
  static const Color onSurfaceVariant = Color(0xFF515462); // Slate
  static const Color textPrimary = Color(0xFF1D1D1F);
  static const Color textSecondary = Color(0xFF6E6E73);
  static const Color textMuted = Color(0xFF8E8E93);
  static const Color textDark = Color(0xFF1D1D1F);
  static const Color outline = Color(0xFFD2D8E4);
  static const Color outlineVariant = Color(0xFFE5EAF2);

  // Domain specific Apple Silicon accents
  static const Color careerAccent = Color(0xFF0071E3); // Electric Azure
  static const Color educationAccent = Color(0xFF6E4AFF); // Liquid Indigo
  static const Color healthAccent = Color(0xFF10B981); // Emerald Mint
}

/// AppColors dynamically switches between Dark (Espresso) and Light (Apple Silicon Liquid Glass)
/// based on the active theme mode in [ThemeManager].
class AppColors {
  static bool get isLight => ThemeManager.instance.isLight;

  // Background surfaces
  static Color get background => isLight ? AppLightColors.background : AppDarkColors.background;
  static Color get surface => isLight ? AppLightColors.surface : AppDarkColors.surface;
  static Color get surfaceContainerLowest => isLight ? AppLightColors.surfaceContainerLowest : AppDarkColors.surfaceContainerLowest;
  static Color get surfaceContainerLow => isLight ? AppLightColors.surfaceContainerLow : AppDarkColors.surfaceContainerLow;
  static Color get surfaceContainer => isLight ? AppLightColors.surfaceContainer : AppDarkColors.surfaceContainer;
  static Color get surfaceContainerHigh => isLight ? AppLightColors.surfaceContainerHigh : AppDarkColors.surfaceContainerHigh;
  static Color get surfaceContainerHighest => isLight ? AppLightColors.surfaceContainerHighest : AppDarkColors.surfaceContainerHighest;

  // Cards & Containers
  static Color get cardBg => isLight ? AppLightColors.cardBg : AppDarkColors.cardBg;
  static Color get cardBgSelected => isLight ? AppLightColors.cardBgSelected : AppDarkColors.cardBgSelected;
  static Color get cardBorder => isLight ? AppLightColors.cardBorder : AppDarkColors.cardBorder;
  static Color get cardBorderSelected => isLight ? AppLightColors.cardBorderSelected : AppDarkColors.cardBorderSelected;

  // Accents & Actions
  static Color get primary => isLight ? AppLightColors.primary : AppDarkColors.primary;
  static Color get primaryContainer => isLight ? AppLightColors.primaryContainer : AppDarkColors.primaryContainer;
  static Color get accent => isLight ? AppLightColors.accent : AppDarkColors.accent;
  static Color get accentLight => isLight ? AppLightColors.accentLight : AppDarkColors.accentLight;
  static Color get onPrimary => isLight ? AppLightColors.onPrimary : AppDarkColors.onPrimary;
  static Color get secondary => isLight ? AppLightColors.secondary : AppDarkColors.secondary;
  static Color get secondaryContainer => isLight ? AppLightColors.secondaryContainer : AppDarkColors.secondaryContainer;
  static Color get onSecondaryContainer => isLight ? AppLightColors.onSecondaryContainer : AppDarkColors.onSecondaryContainer;
  static Color get chipBackground => isLight ? AppLightColors.chipBackground : AppDarkColors.chipBackground;

  // Text & Typography
  static Color get onSurface => isLight ? AppLightColors.onSurface : AppDarkColors.onSurface;
  static Color get onSurfaceVariant => isLight ? AppLightColors.onSurfaceVariant : AppDarkColors.onSurfaceVariant;
  static Color get textPrimary => isLight ? AppLightColors.textPrimary : AppDarkColors.textPrimary;
  static Color get textSecondary => isLight ? AppLightColors.textSecondary : AppDarkColors.textSecondary;
  static Color get textMuted => isLight ? AppLightColors.textMuted : AppDarkColors.textMuted;
  static Color get textDark => isLight ? AppLightColors.textDark : AppDarkColors.textDark;
  static Color get outline => isLight ? AppLightColors.outline : AppDarkColors.outline;
  static Color get outlineVariant => isLight ? AppLightColors.outlineVariant : AppDarkColors.outlineVariant;

  // Domain Accents
  static Color get careerAccent => isLight ? AppLightColors.careerAccent : AppDarkColors.careerAccent;
  static Color get educationAccent => isLight ? AppLightColors.educationAccent : AppDarkColors.educationAccent;
  static Color get healthAccent => isLight ? AppLightColors.healthAccent : AppDarkColors.healthAccent;
}
