import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/ai_insight_report.dart';
import '../../models/user_goal_session.dart';
import '../../services/gemini_insight_service.dart';
import '../../services/journal_service.dart';
import '../../widgets/liquid_glass.dart';
import 'widgets/gemini_key_modal.dart';

class InsightsScreen extends StatefulWidget {
  final UserGoalSession? session;

  const InsightsScreen({
    super.key,
    this.session,
  });

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  void _runAiAnalysis() async {
    final entries = JournalService.instance.entries;
    try {
      await GeminiInsightService.instance.generateInsights(entries);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Emotional growth analysis updated with Gemini AI! ✨'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      final errorStr = e.toString().replaceAll('Exception: ', '');

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
          title: Row(
            children: [
              Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                'AI Connection Note',
                style: TextStyle(
                  color: AppColors.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                errorStr,
                style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 12),
              Text(
                'Tip: Open setup, tap "Paste from Clipboard", and test the key directly.',
                style: TextStyle(color: AppColors.primary, fontSize: 12),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                GeminiInsightService.instance.generateInsights(entries, customKey: '');
              },
              child: Text(
                'Use Offline Mode',
                style: TextStyle(color: AppColors.onSurfaceVariant, fontSize: 13),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                showGeminiKeyModal(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Update Key'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentSession = widget.session ?? UserGoalSession();
    final totalGoals = currentSession.goalItems.length;
    final completedGoals = currentSession.goalItems.where((g) => g.isCompleted).length;
    final careerGoals = currentSession.goalItems.where((g) => g.category == 'Career').length;
    final educationGoals = currentSession.goalItems.where((g) => g.category == 'Education').length;
    final healthGoals = currentSession.goalItems.where((g) => g.category == 'Health').length;

    return ListenableBuilder(
      listenable: GeminiInsightService.instance,
      builder: (context, _) {
        final geminiService = GeminiInsightService.instance;
        final report = geminiService.currentReport ?? AiInsightReport.sampleReport();
        final isLoading = geminiService.isLoading;
        final hasKey = geminiService.hasApiKey;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 20,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.insights_rounded, size: 20, color: AppColors.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Insights',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        'AI Growth & Mood Trajectory',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              // Gemini Key Setup Button
              IconButton(
                onPressed: () => showGeminiKeyModal(context),
                icon: Stack(
                  children: [
                    Icon(
                      Icons.auto_awesome_rounded,
                      color: hasKey ? AppColors.primary : AppColors.onSurfaceVariant,
                    ),
                    if (hasKey)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF81B29A),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                tooltip: hasKey ? 'Gemini AI Connected' : 'Configure Free Gemini API Key',
              ),
              const ThemeToggleButton(),
              const SizedBox(width: 8),
            ],
          ),
          body: LiquidBackground(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. AI Emotional Trajectory Hero Card
                  _buildAiHeroCard(report, isLoading, hasKey),
                  const SizedBox(height: 18),

                  // 2. Growth Milestones & Resilience Shifts
                  _buildGrowthCard(report),
                  const SizedBox(height: 16),

                  // 3. Emotional Dips & Vulnerability Triggers
                  _buildDownfallCard(report),
                  const SizedBox(height: 16),

                  // 4. Personalized Mindful Recommendation Card
                  _buildRecommendationCard(report),
                  const SizedBox(height: 22),

                  // 5. Active Streak Card
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
                            children: [
                              Text(
                                '5 Day Active Streak',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
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

                  // 6. Weekly Rhythm Grid
                  Text(
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
                      children: [
                        Expanded(child: _buildDayStatus('Mon', true)),
                        Expanded(child: _buildDayStatus('Tue', true)),
                        Expanded(child: _buildDayStatus('Wed', true)),
                        Expanded(child: _buildDayStatus('Thu', true)),
                        Expanded(child: _buildDayStatus('Fri', true)),
                        Expanded(child: _buildDayStatus('Sat', false)),
                        Expanded(child: _buildDayStatus('Sun', false)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // 7. Goals Roadmap Breakdown
                  Text(
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
                            Expanded(
                              child: Text(
                                'Total Goals Active / Completed',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 13, color: AppColors.onSurfaceVariant),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$completedGoals / $totalGoals',
                              style: TextStyle(
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

                  // Bottom padding for navigation bar
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAiHeroCard(AiInsightReport report, bool isLoading, bool hasKey) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.surfaceContainer,
            report.trajectoryColor.withValues(alpha: 0.15),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: report.trajectoryColor.withValues(alpha: 0.4),
          width: 1.4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Tag & Trajectory Pill
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 6,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome_rounded, size: 16, color: report.trajectoryColor),
                    const SizedBox(width: 6),
                    Text(
                      'GEMINI 1.5 FLASH AI',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                        color: report.trajectoryColor,
                      ),
                    ),
                  ],
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: report.trajectoryColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: report.trajectoryColor.withValues(alpha: 0.5),
                    ),
                  ),
                  child: Text(
                    report.emotionalTrajectory,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: report.trajectoryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Overview Title & Narrative
          Text(
            'Emotional Trajectory Synthesis',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            report.overallSummary,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),

          // Refresh / Generate Action Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: isLoading ? null : _runAiAnalysis,
              icon: isLoading
                  ? SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.onPrimary,
                      ),
                    )
                  : const Icon(Icons.refresh_rounded, size: 18),
              label: Text(
                isLoading
                    ? 'Consulting Gemini Neural Network...'
                    : (hasKey ? 'Re-analyze with Gemini API' : 'Analyze Entries (Free Gemini AI)'),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthCard(AiInsightReport report) {
    final milestones = report.growthMilestones;
    if (milestones.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFF81B29A).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFF81B29A).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.trending_up_rounded, color: Color(0xFF81B29A), size: 16),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'GROWTH & RESILIENCE BREAKTHROUGHS',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: Color(0xFF81B29A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...milestones.map((m) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('🌱 ', style: TextStyle(fontSize: 13)),
                  Expanded(
                    child: Text(
                      m,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.onSurface,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildDownfallCard(AiInsightReport report) {
    final vulnerabilities = report.downfallVulnerabilities;
    if (vulnerabilities.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE07A5F).withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE07A5F).withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.waves_rounded, color: Color(0xFFE07A5F), size: 16),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'DETECTED DIPS & VULNERABILITY TRIGGERS',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: Color(0xFFE07A5F),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...vulnerabilities.map((v) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('⚠️ ', style: TextStyle(fontSize: 13)),
                  Expanded(
                    child: Text(
                      v,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.onSurface,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard(AiInsightReport report) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.lightbulb_outline_rounded, size: 16, color: AppColors.primary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'AI MINDFUL PRESCRIPTION FOR TOMORROW',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            report.mindfulRecommendation,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.italic,
              color: AppColors.onSurface,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayStatus(String day, bool isDone) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          day,
          style: TextStyle(fontSize: 11, color: AppColors.onSurfaceVariant),
        ),
        const SizedBox(height: 6),
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: isDone ? AppColors.primary : AppColors.surfaceContainerHigh,
            shape: BoxShape.circle,
            border: Border.all(
              color: isDone ? AppColors.primary : Colors.white24,
            ),
          ),
          child: isDone
              ? Icon(Icons.check, size: 14, color: AppColors.onPrimary)
              : null,
        ),
      ],
    );
  }

  Widget _buildDomainRow(String title, int count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
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
