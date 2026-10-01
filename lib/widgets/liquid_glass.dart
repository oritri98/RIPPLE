import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../theme/theme_manager.dart';

/// LiquidGlassContainer wraps content in a macOS / iOS / visionOS style
/// frosted liquid glass material with backdrop blur, specular gradient sheen,
/// and soft ambient depth.
class LiquidGlassContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double blur;
  final Color? customGlassColor;
  final Border? customBorder;
  final VoidCallback? onTap;

  const LiquidGlassContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius = 22.0,
    this.blur = 16.0,
    this.customGlassColor,
    this.customBorder,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight;

    final defaultGlassColor = isLight
        ? Colors.white.withValues(alpha: 0.78)
        : AppDarkColors.surfaceContainer.withValues(alpha: 0.82);

    final borderColor = isLight
        ? Colors.white.withValues(alpha: 0.9)
        : Colors.white.withValues(alpha: 0.12);

    final widgetBody = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: isLight
            ? [
                BoxShadow(
                  color: const Color(0xFF003366).withValues(alpha: 0.08),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                  spreadRadius: -2,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.45),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: customGlassColor ?? defaultGlassColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: customBorder ??
                  Border.all(
                    color: borderColor,
                    width: 1.2,
                  ),
              gradient: isLight
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.88),
                        Colors.white.withValues(alpha: 0.62),
                      ],
                    )
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: widgetBody,
      );
    }

    return widgetBody;
  }
}

/// LiquidBackground wraps any screen in an Apple Silicon frosted canvas.
/// In Light Mode, it adds subtle ethereal ambient mesh glow orbs in the background
/// which seamlessly shine through frosted liquid glass cards.
class LiquidBackground extends StatelessWidget {
  final Widget child;

  const LiquidBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight;

    return Stack(
      children: [
        // Solid background base
        Positioned.fill(
          child: Container(
            color: isLight ? AppLightColors.background : AppDarkColors.background,
          ),
        ),

        // Apple Silicon Ambient Mesh Light (Only in Light Mode for liquid glass refraction)
        if (isLight) ...[
          // Soft Azure Aura (Top-Right)
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF0071E3).withValues(alpha: 0.16),
                    const Color(0xFF0071E3).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          // Soft Iris / Violet Aura (Mid-Left)
          Positioned(
            top: 280,
            left: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF5E5CE6).withValues(alpha: 0.12),
                    const Color(0xFF5E5CE6).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
          // Soft Mint / Emerald Aura (Bottom-Right)
          Positioned(
            bottom: 40,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF34C759).withValues(alpha: 0.09),
                    const Color(0xFF34C759).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ],

        // Screen Content
        child,
      ],
    );
  }
}

/// ThemeToggleButton is an Apple Silicon frosted glass pill switch.
/// Displays Sun / Moon icons and toggles between Liquid Glass (Light)
/// and Espresso Amber (Dark) themes with smooth animations.
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ThemeManager.instance,
      builder: (context, _) {
        final isLight = ThemeManager.instance.isLight;

        return Tooltip(
          message: isLight ? 'Switch to Espresso Dark Theme' : 'Switch to Apple Liquid Glass Light Theme',
          child: InkWell(
            onTap: () => ThemeManager.instance.toggleTheme(),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: isLight
                    ? Colors.white.withValues(alpha: 0.85)
                    : AppDarkColors.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isLight
                      ? Colors.white.withValues(alpha: 0.95)
                      : AppDarkColors.primary.withValues(alpha: 0.3),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isLight
                        ? const Color(0xFF003366).withValues(alpha: 0.1)
                        : Colors.black.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, anim) => RotationTransition(
                      turns: anim,
                      child: FadeTransition(opacity: anim, child: child),
                    ),
                    child: Icon(
                      isLight ? Icons.wb_sunny_rounded : Icons.nightlight_round,
                      key: ValueKey<bool>(isLight),
                      size: 16,
                      color: isLight ? const Color(0xFF0071E3) : AppDarkColors.primary,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isLight ? 'Glass' : 'Espresso',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: isLight ? const Color(0xFF0071E3) : AppDarkColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
