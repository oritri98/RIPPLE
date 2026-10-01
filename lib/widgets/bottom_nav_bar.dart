import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight;

    return Container(
      height: 66,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        boxShadow: isLight
            ? [
                BoxShadow(
                  color: const Color(0xFF003366).withValues(alpha: 0.12),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                  spreadRadius: -2,
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.6),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: isLight
                  ? Colors.white.withValues(alpha: 0.85)
                  : AppDarkColors.surfaceContainerLowest.withValues(alpha: 0.95),
              borderRadius: BorderRadius.circular(34),
              border: Border.all(
                color: isLight
                    ? Colors.white.withValues(alpha: 0.95)
                    : AppDarkColors.primary.withValues(alpha: 0.25),
                width: 1.2,
              ),
              gradient: isLight
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.92),
                        Colors.white.withValues(alpha: 0.72),
                      ],
                    )
                  : null,
            ),
            child: Row(
              children: [
                // 1. Today / Home Tab
                Expanded(
                  child: _buildNavItem(
                    icon: Icons.wb_twilight_rounded,
                    label: 'Today',
                    index: 0,
                    isSelected: currentIndex == 0,
                  ),
                ),

                // 2. Journal Tab
                Expanded(
                  child: _buildNavItem(
                    icon: Icons.auto_stories_outlined,
                    label: 'Journal',
                    index: 1,
                    isSelected: currentIndex == 1,
                  ),
                ),

                // 3. Events Tab (Calendar & Memories)
                Expanded(
                  child: _buildNavItem(
                    icon: Icons.calendar_month_rounded,
                    label: 'Events',
                    index: 2,
                    isSelected: currentIndex == 2,
                  ),
                ),

                // 4. Tasks & Goals Tab
                Expanded(
                  child: _buildNavItem(
                    icon: Icons.check_circle_outline_rounded,
                    label: 'Tasks',
                    index: 3,
                    isSelected: currentIndex == 3,
                  ),
                ),

                // 5. Insights Tab
                Expanded(
                  child: _buildNavItem(
                    icon: Icons.insights_rounded,
                    label: 'Insights',
                    index: 4,
                    isSelected: currentIndex == 4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    final color = isSelected ? AppColors.primary : AppColors.onSurfaceVariant;

    return InkWell(
      onTap: () => onTap(index),
      borderRadius: BorderRadius.circular(20),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 21,
                color: color,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                  letterSpacing: 0.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
