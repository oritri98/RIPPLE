import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';

class AmbientAudioPill extends StatefulWidget {
  const AmbientAudioPill({super.key});

  @override
  State<AmbientAudioPill> createState() => _AmbientAudioPillState();
}

class _AmbientAudioPillState extends State<AmbientAudioPill> {
  bool _isPlaying = false;
  String _currentSound = 'Soft Rain';

  final List<String> sounds = [
    'Soft Rain',
    'Ocean Waves',
    'Brown Noise',
    'Pine Forest',
  ];

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isPlaying
            ? 'Playing $_currentSound soundscape 🌧️'
            : 'Soundscape paused'),
        duration: const Duration(seconds: 1),
        backgroundColor: AppColors.surfaceContainerHigh,
      ),
    );
  }

  void _showSoundSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (modalContext) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Ambient Soundscapes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: AppColors.onSurfaceVariant),
                    onPressed: () => Navigator.pop(modalContext),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...sounds.map((sound) {
                final isSelected = _currentSound == sound;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : Colors.white12,
                        width: 1,
                      ),
                    ),
                    tileColor: isSelected
                        ? AppColors.surfaceContainerHigh
                        : Colors.transparent,
                    leading: Icon(
                      isSelected ? Icons.graphic_eq_rounded : Icons.waves_rounded,
                      color: isSelected ? AppColors.primary : AppColors.onSurfaceVariant,
                    ),
                    title: Text(
                      sound,
                      style: TextStyle(
                        color: isSelected ? AppColors.primary : AppColors.onSurface,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_rounded, color: AppColors.primary)
                        : null,
                    onTap: () {
                      setState(() {
                        _currentSound = sound;
                        _isPlaying = true;
                      });
                      Navigator.pop(modalContext);
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _togglePlay,
      onLongPress: _showSoundSelector,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _isPlaying
              ? AppColors.primary.withValues(alpha: 0.2)
              : AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isPlaying
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.25),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isPlaying ? Icons.graphic_eq_rounded : Icons.headphones_outlined,
              size: 14,
              color: _isPlaying ? AppColors.primary : AppColors.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              _isPlaying ? _currentSound : 'Soundscapes',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _isPlaying ? AppColors.primary : AppColors.onSurfaceVariant,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
