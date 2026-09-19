import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/user_goal_session.dart';
import 'education_screen.dart';
import 'health_screen.dart';
import 'navigation/main_navigation_screen.dart';
import 'stage_selection_screen.dart';

class CategorySelectionScreen extends StatelessWidget {
  final UserGoalSession? session;

  const CategorySelectionScreen({
    super.key,
    this.session,
  });

  @override
  Widget build(BuildContext context) {
    final currentSession = session ?? UserGoalSession();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: Navigator.canPop(context),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainNavigationScreen(session: currentSession),
                ),
                (route) => false,
              );
            },
            icon: const Icon(Icons.dashboard_outlined, color: AppColors.primary, size: 18),
            label: const Text(
              'Skip to Today',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'CHOOSE YOUR DOMAIN',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Where shall we start?',
                style: TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Select a core area to set up your personalized goals and actionable roadmap.',
                style: TextStyle(
                  color: AppColors.onSurfaceVariant,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // 1. Education
                    _buildCategoryCard(
                      context: context,
                      title: 'Education',
                      subtitle: 'Class routine, study frequency & academic targets',
                      icon: Icons.school_rounded,
                      accentColor: AppColors.educationAccent,
                      onTap: () {
                        currentSession.activeCategory = 'Education';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EducationScreen(session: currentSession),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    // 2. Career and Goals
                    _buildCategoryCard(
                      context: context,
                      title: 'Career and Goals',
                      subtitle: 'Life stage, career trajectory, milestones & timeline',
                      icon: Icons.work_rounded,
                      accentColor: AppColors.careerAccent,
                      onTap: () {
                        currentSession.activeCategory = 'Career';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StageSelectionScreen(session: currentSession),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 18),

                    // 3. Health & Wellbeing
                    _buildCategoryCard(
                      context: context,
                      title: 'Health & Wellbeing',
                      subtitle: 'Fitness routines, mindfulness & healthy daily habits',
                      icon: Icons.spa_rounded,
                      accentColor: AppColors.healthAccent,
                      onTap: () {
                        currentSession.activeCategory = 'Health';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HealthScreen(session: currentSession),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainer,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: accentColor.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: accentColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.onSurfaceVariant,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
