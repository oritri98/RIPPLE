import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/user_goal_session.dart';
import '../widgets/step_indicator.dart';
import 'summary_screen.dart';

class TimelineOption {
  final String title;
  final String duration;
  final String description;
  final IconData icon;

  const TimelineOption({
    required this.title,
    required this.duration,
    required this.description,
    required this.icon,
  });
}

class TimelineSelectionScreen extends StatefulWidget {
  final UserGoalSession session;

  const TimelineSelectionScreen({
    super.key,
    required this.session,
  });

  @override
  State<TimelineSelectionScreen> createState() => _TimelineSelectionScreenState();
}

class _TimelineSelectionScreenState extends State<TimelineSelectionScreen> {
  String? selectedTimeline;

  final List<TimelineOption> timelines = const [
    TimelineOption(
      title: '1 Week',
      duration: 'Sprint',
      description: 'Intense 7-day focus to build immediate momentum and quick wins.',
      icon: Icons.bolt_rounded,
    ),
    TimelineOption(
      title: '1 Month',
      duration: 'Short-term Goal',
      description: '30-day structured habit building with measurable weekly milestones.',
      icon: Icons.track_changes_rounded,
    ),
    TimelineOption(
      title: '3 Months',
      duration: 'Quarterly Target',
      description: 'A 90-day transformation horizon to achieve significant breakthroughs.',
      icon: Icons.rocket_launch_rounded,
    ),
    TimelineOption(
      title: '6 Months',
      duration: 'Long-term Plan',
      description: 'Comprehensive mastery and sustainable long-term career growth.',
      icon: Icons.military_tech_rounded,
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedTimeline = widget.session.timeline ?? '1 Month';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepIndicator(
                currentStep: 4,
                totalSteps: 4,
                stepTitle: 'Target Timeline',
              ),
              const SizedBox(height: 20),
              const Text(
                'Pick your timeline',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'How soon would you like to achieve your selected goals?',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: timelines.length,
                  itemBuilder: (context, index) {
                    final item = timelines[index];
                    final isSelected = selectedTimeline == item.title;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            selectedTimeline = item.title;
                            widget.session.timeline = item.title;
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.cardBgSelected
                                : AppColors.cardBg,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.accent
                                  : Colors.white24,
                              width: isSelected ? 2.2 : 1.2,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.accent.withValues(alpha: 0.25)
                                      : Colors.white.withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  item.icon,
                                  color: isSelected
                                      ? AppColors.accent
                                      : Colors.white70,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Wrap(
                                      crossAxisAlignment: WrapCrossAlignment.center,
                                      spacing: 8,
                                      runSpacing: 4,
                                      children: [
                                        Text(
                                          item.title,
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: isSelected
                                                ? AppColors.accentLight
                                                : AppColors.textPrimary,
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.accent.withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            item.duration,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.accent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      item.description,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.textSecondary,
                                        height: 1.35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.accent
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.accent
                                        : Colors.white38,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: selectedTimeline != null
                    ? () {
                        widget.session.timeline = selectedTimeline;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SummaryScreen(
                              session: widget.session,
                            ),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accent,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 58),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Review Goal Plan  →',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
