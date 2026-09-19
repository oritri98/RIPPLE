import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/stage_data.dart';
import '../models/user_goal_session.dart';
import '../widgets/option_card.dart';
import '../widgets/step_indicator.dart';
import 'focus_selection_screen.dart';

class StageSelectionScreen extends StatelessWidget {
  final UserGoalSession? session;

  const StageSelectionScreen({super.key, this.session});

  @override
  Widget build(BuildContext context) {
    final stages = StageDataRepository.stages;
    final currentSession = session ?? UserGoalSession();

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
                currentStep: 1,
                totalSteps: 4,
                stepTitle: 'Current Stage',
              ),
              const SizedBox(height: 24),
              const Text(
                'What stage are you at?',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Choose where you currently stand to get tailored goal pathways.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: stages.length,
                  itemBuilder: (context, index) {
                    final stage = stages[index];
                    return OptionCard(
                      title: stage.title,
                      onTap: () {
                        currentSession.stage = stage.title;
                        currentSession.activeCategory = 'Career';
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FocusSelectionScreen(
                              stageOption: stage,
                              session: currentSession,
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
