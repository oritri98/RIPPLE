import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/stage_data.dart';
import '../models/user_goal_session.dart';
import '../widgets/option_card.dart';
import '../widgets/step_indicator.dart';
import 'goal_selection_screen.dart';

class FocusSelectionScreen extends StatelessWidget {
  final StageOption stageOption;
  final UserGoalSession session;

  const FocusSelectionScreen({
    super.key,
    required this.stageOption,
    required this.session,
  });

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
                currentStep: 2,
                totalSteps: 4,
                stepTitle: 'Focus Area',
              ),
              const SizedBox(height: 24),
              Text(
                stageOption.question,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Selected Stage: ${stageOption.title}',
                style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 28),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: stageOption.focusOptions.length,
                  itemBuilder: (context, index) {
                    final focus = stageOption.focusOptions[index];
                    return OptionCard(
                      title: focus.title,
                      subtitle: focus.subtitle,
                      onTap: () {
                        session.focusArea = focus.title;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GoalSelectionScreen(
                              focusOption: focus,
                              session: session,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
