import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../journal/widgets/journal_entry_modal.dart';

/// DailyPromptCard displays the elevated, quiet Daily Reflection prompt.
/// 
/// BEGINNER TIP:
/// Updated to match v2: cleaner border styling, a "Begin Entry" action,
/// and a discreet reading estimate pill.
class DailyPromptCard extends StatefulWidget {
  const DailyPromptCard({super.key});

  @override
  State<DailyPromptCard> createState() => _DailyPromptCardState();
}

class _DailyPromptCardState extends State<DailyPromptCard> {
  final List<String> _prompts = [
    'What is one small moment of stillness you can protect today?',
    'What is something quiet that brought you unexpected peace this week?',
    'If today were unhurried, what would you pay closer attention to?',
    'What thought can you gently release before starting your work?',
  ];

  int _currentPromptIndex = 0;

  void _shufflePrompt() {
    setState(() {
      _currentPromptIndex = (_currentPromptIndex + 1) % _prompts.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: "DAILY REFLECTION" badge + "3 min read" estimate
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'DAILY REFLECTION',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.2,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.schedule,
                      size: 13,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '3 min read',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 11,
                        color: AppColors.outline,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // The Prompt text in Literata font
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              _prompts[_currentPromptIndex],
              key: ValueKey<int>(_currentPromptIndex),
              style: GoogleFonts.literata(
                fontSize: 22,
                fontWeight: FontWeight.w400,
                height: 1.35,
                color: AppColors.onSurface,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Hairline divider
          Container(
            height: 1,
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 14),

          // Bottom Action Row: "Begin Entry" Button + Shuffle Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  showJournalEntryModal(
                    context,
                    prompt: _prompts[_currentPromptIndex],
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 1,
                ),
                icon: Text(
                  'Begin Entry',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                label: const Icon(Icons.arrow_forward, size: 16),
              ),

              // Shuffle prompt button
              InkWell(
                onTap: _shufflePrompt,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shuffle,
                    size: 20,
                    color: AppColors.outline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
