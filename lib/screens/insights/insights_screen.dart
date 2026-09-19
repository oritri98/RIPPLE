import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/user_goal_session.dart';

class InsightsScreen extends StatelessWidget {
  final UserGoalSession? session;

  const InsightsScreen({
    super.key,
    this.session,
  });

  @override
  Widget build(BuildContext context) {
    final currentSession = session ?? UserGoalSession();
    final totalGoals = currentSession.goalItems.length;
    final completedGoals = currentSession.goalItems.where((g) => g.isCompleted).length;
    final careerGoals = currentSession.goalItems.where((g) => g.category == 'Career').length;
    final educationGoals = currentSession.goalItems.where((g) => g.category == 'Education').length;
    final healthGoals = currentSession.goalItems.where((g) => g.category == 'Health').length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: const Text(
          'Insights',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Streak Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.surfaceContainer,
                    AppColors.primary.withValues(alpha: 0.12),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  width: 1.2,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('🔥', style: TextStyle(fontSize: 28)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          '5 Day Active Streak',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Consistent mindfulness & daily intention tracking.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // 2. Weekly Habits Rhythm Grid
            const Text(
              'THIS WEEK\'S RHYTHM',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDayStatus('Mon', true),
                  _buildDayStatus('Tue', true),
                  _buildDayStatus('Wed', true),
                  _buildDayStatus('Thu', true),
                  _buildDayStatus('Fri', true),
                  _buildDayStatus('Sat', false),
                  _buildDayStatus('Sun', false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 3. Goals Breakdown Card
            const Text(
              'DOMAIN ROADMAP BREAKDOWN',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  _buildDomainRow('Career & Trajectory', careerGoals, AppColors.careerAccent),
                  const Divider(color: Colors.white12, height: 20),
                  _buildDomainRow('Education & Study', educationGoals, AppColors.educationAccent),
                  const Divider(color: Colors.white12, height: 20),
                  _buildDomainRow('Health & Wellbeing', healthGoals, AppColors.healthAccent),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Goals Active / Completed',
                        style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                      ),
                      Text(
                        '$completedGoals / $totalGoals',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 4. Mindful Quote
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'MINDFUL REMINDER',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '"Consistency is not about perfection, but about gently returning to your path every day."',
                    style: TextStyle(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: AppColors.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildDayStatus(String day, bool isDone) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: isDone
                ? AppColors.primary
                : AppColors.surfaceContainerHigh,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDone ? AppColors.primary : Colors.white24,
            ),
          ),
          child: isDone
              ? const Icon(Icons.check, size: 16, color: AppColors.onPrimary)
              : null,
        ),
      ],
    );
  }

  Widget _buildDomainRow(String title, int count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.onSurface,
              ),
            ),
          ],
        ),
        Text(
          '$count goals',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
