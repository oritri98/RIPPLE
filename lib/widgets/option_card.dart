import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isSelected;
  final Widget? leading;
  final Widget? trailing;
  final double minHeight;

  const OptionCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isSelected = false,
    this.leading,
    this.trailing,
    this.minHeight = 64.0,
  });

  @override
  Widget build(BuildContext context) {
    final isLight = AppColors.isLight;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: minHeight),
      margin: const EdgeInsets.only(bottom: 16.0),
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected
              ? AppColors.cardBgSelected
              : (isLight ? AppColors.cardBg : Colors.transparent),
          foregroundColor: AppColors.textPrimary,
          side: BorderSide(
            color: isSelected ? AppColors.accent : AppColors.cardBorder,
            width: isSelected ? 2.5 : 1.5,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          shadowColor: isLight
              ? const Color(0xFF003366).withValues(alpha: 0.1)
              : Colors.black,
          elevation: isSelected ? 4 : (isLight ? 1.5 : 0),
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: 14),
            ],
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? (isLight ? AppColors.primary : AppColors.accentLight)
                          : AppColors.textPrimary,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.accent,
                size: 26,
              ),
          ],
        ),
      ),
    );
  }
}
