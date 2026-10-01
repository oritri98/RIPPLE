import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/user_goal_session.dart';
import '../../widgets/liquid_glass.dart';
import '../category_selection_screen.dart';
import '../login_screen.dart';
import '../../services/session_service.dart';
import 'widgets/ambient_audio_pill.dart';
import 'widgets/daily_prompt_card.dart';
import 'widgets/task_list_section.dart';
import 'widgets/yesterday_note_card.dart';

class HomeScreen extends StatelessWidget {
  final UserGoalSession? session;

  const HomeScreen({
    super.key,
    this.session,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(context),
      body: LiquidBackground(
        child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Date indicator row + Ambient Audio Pill
            _buildDateAndAudioRow(),
            const SizedBox(height: 14),

            // 2. Greeting
            _buildGreeting(),
            const SizedBox(height: 22),

            // 3. Daily Prompt Card
            const DailyPromptCard(),
            const SizedBox(height: 22),

            // 4. Today's Intentions & Active Goals
            TaskListSection(session: session),
            const SizedBox(height: 22),

            // 5. Explore Domain Goals Banner
            _buildExploreHubCard(context),
            const SizedBox(height: 22),

            // 6. Echoes from Yesterday
            const YesterdayNoteCard(),

            // Bottom space for floating nav bar
            const SizedBox(height: 100),
          ],
        ),
      ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      titleSpacing: 20,
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
            child: Icon(
              Icons.water_drop_rounded,
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'Today',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        const ThemeToggleButton(),
        const SizedBox(width: 6),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategorySelectionScreen(session: session),
              ),
            );
          },
          icon: Icon(Icons.explore_outlined, color: AppColors.onSurfaceVariant),
          tooltip: 'Explore Goal Domains',
        ),
        PopupMenuButton<String>(
          icon: CircleAvatar(
            radius: 14,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            child: Icon(Icons.person_outline_rounded, size: 16, color: AppColors.primary),
          ),
          color: AppColors.surfaceContainerLowest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white12),
          ),
          onSelected: (value) async {
            if (value == 'logout') {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: AppColors.surfaceContainerLowest,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: const BorderSide(color: Colors.white12),
                  ),
                  title: const Text('Log Out?'),
                  content: const Text(
                    'Are you sure you want to log out? Your journal reflections will remain safely saved on this device.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE05A47),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Log Out'),
                    ),
                  ],
                ),
              );

              if (confirm == true) {
                await SessionService.instance.logout();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                }
              }
            }
          },
          itemBuilder: (context) => [
            if (SessionService.instance.userEmail != null)
              PopupMenuItem(
                enabled: false,
                child: Text(
                  SessionService.instance.userEmail!,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: const [
                  Icon(Icons.logout_rounded, size: 18, color: Color(0xFFE05A47)),
                  SizedBox(width: 8),
                  Text('Log Out', style: TextStyle(color: Color(0xFFE05A47))),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildDateAndAudioRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'TODAY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const AmbientAudioPill(),
      ],
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning.',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Take a deep breath and start your journey.',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildExploreHubCard(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategorySelectionScreen(session: session),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(Icons.tune_rounded, color: AppColors.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Goal Domains',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Set milestones for Career, Education & Health',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: AppColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
