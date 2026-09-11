import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';

/// AmbientAudioPill is the compact, discreet audio pill shown beside the date.
/// 
/// BEGINNER TIP:
/// This replaces the large banner with a minimalist audio chip that
/// can be tapped to toggle playback on and off!
class AmbientAudioPill extends StatefulWidget {
  const AmbientAudioPill({super.key});

  @override
  State<AmbientAudioPill> createState() => _AmbientAudioPillState();
}

class _AmbientAudioPillState extends State<AmbientAudioPill> {
  bool _isPlaying = true;

  void _toggleAudio() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _toggleAudio,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isPlaying
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.outlineVariant.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isPlaying ? Icons.graphic_eq : Icons.volume_off,
              size: 14,
              color: _isPlaying ? AppColors.primary : AppColors.outline,
            ),
            const SizedBox(width: 6),
            Text(
              'Hearth & Rain',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _isPlaying ? AppColors.onSurface : AppColors.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
