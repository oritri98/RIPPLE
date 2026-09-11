import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import 'widgets/ambient_audio_pill.dart';
import 'widgets/daily_prompt_card.dart';
import 'widgets/task_list_section.dart';
import 'widgets/yesterday_note_card.dart';

/// HomeScreen is the primary daily dashboard for Ripple.
/// 
/// BEGINNER TIP:
/// Updated to v2: Much more realistic, serene, and decluttered layout.
/// Features a discreet ambient audio chip, unified tasks card, and quiet notes.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Date indicator row + Discreet Ambient Audio Pill
            _buildDateAndAudioRow(),
            const SizedBox(height: 12),

            // 2. Greeting & Morning Reminder
            _buildGreeting(),
            const SizedBox(height: 22),

            // 3. Elevated, Quiet Daily Prompt Card
            const DailyPromptCard(),
            const SizedBox(height: 24),

            // 4. Decluttered Today's Intentions (Grouped Tasks List)
            const TaskListSection(),
            const SizedBox(height: 24),

            // 5. Echoes from Yesterday (Discreet Note Card)
            const YesterdayNoteCard(),
            
            // Extra bottom spacing so content scrolls cleanly past floating nav & FAB
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  /// App Bar with Logo, Title, Filter, and Profile
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 18,
      title: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: const Icon(
              Icons.all_inclusive,
              size: 20,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ripple',
                style: GoogleFonts.literata(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                'Today',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Filter options'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          icon: const Icon(
            Icons.filter_list,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceContainerHigh,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: const Icon(
              Icons.person_outline,
              size: 20,
              color: AppColors.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  /// Date indicator on left + Ambient Audio Pill on right
  Widget _buildDateAndAudioRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'WEDNESDAY, OCT 24',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),

        // Discreet ambient audio pill
        const AmbientAudioPill(),
      ],
    );
  }

  /// Morning Greeting Text
  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning, Milena.',
          style: GoogleFonts.literata(
            fontSize: 26,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Take a deep breath.',
          style: GoogleFonts.literata(
            fontSize: 22,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w400,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
