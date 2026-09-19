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
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.25),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
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

          // Spacer for center FAB
          const SizedBox(width: 48),

          // 3. Tasks & Goals Tab
          Expanded(
            child: _buildNavItem(
              icon: Icons.check_circle_outline_rounded,
              label: 'Tasks',
              index: 2,
              isSelected: currentIndex == 2,
            ),
          ),

          // 4. Insights Tab
          Expanded(
            child: _buildNavItem(
              icon: Icons.insights_rounded,
              label: 'Insights',
              index: 3,
              isSelected: currentIndex == 3,
            ),
          ),
        ],
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
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: color,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
