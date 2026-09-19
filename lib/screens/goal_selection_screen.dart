import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/stage_data.dart';
import '../models/user_goal_session.dart';
import '../widgets/step_indicator.dart';
import 'timeline_selection_screen.dart';

class GoalSelectionScreen extends StatefulWidget {
  final FocusOption focusOption;
  final UserGoalSession session;

  const GoalSelectionScreen({
    super.key,
    required this.focusOption,
    required this.session,
  });

  @override
  State<GoalSelectionScreen> createState() => _GoalSelectionScreenState();
}

class _GoalSelectionScreenState extends State<GoalSelectionScreen> {
  late List<String> availableGoals;
  final TextEditingController _customGoalController = TextEditingController();

  @override
  void initState() {
    super.initState();
    availableGoals = List.from(widget.focusOption.suggestedGoals);
    // Include any goals already in session
    for (final goal in widget.session.selectedGoals) {
      if (!availableGoals.contains(goal)) {
        availableGoals.add(goal);
      }
    }
  }

  @override
  void dispose() {
    _customGoalController.dispose();
    super.dispose();
  }

  void _showAddCustomGoalDialog() {
    _customGoalController.clear();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.accent, width: 1.5),
          ),
          title: const Text(
            'Add Custom Goal',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _customGoalController,
            autofocus: true,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'e.g. Finish portfolio website',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.accent),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final customText = _customGoalController.text.trim();
                if (customText.isNotEmpty) {
                  setState(() {
                    if (!availableGoals.contains(customText)) {
                      availableGoals.insert(0, customText);
                    }
                    if (!widget.session.selectedGoals.contains(customText)) {
                      widget.session.selectedGoals.add(customText);
                    }
                  });
                  Navigator.pop(dialogContext);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Add Goal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCount = widget.session.selectedGoals.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton.icon(
            onPressed: _showAddCustomGoalDialog,
            icon: const Icon(Icons.add_rounded, color: AppColors.accent),
            label: const Text(
              'Custom Goal',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StepIndicator(
                currentStep: 3,
                totalSteps: 4,
                stepTitle: 'Choose Goals',
              ),
              const SizedBox(height: 20),
              const Text(
                'What are your goals?',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Select the goals you want to achieve for "${widget.focusOption.title}".',
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: availableGoals.length,
                  itemBuilder: (context, index) {
                    final goal = availableGoals[index];
                    final isSelected = widget.session.selectedGoals.contains(goal);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 14.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            widget.session.toggleGoal(goal);
                          });
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.cardBgSelected
                                : AppColors.cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.accent
                                  : Colors.white24,
                              width: isSelected ? 2.0 : 1.2,
                            ),
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 26,
                                height: 26,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.accent
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.accent
                                        : Colors.white54,
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        size: 16,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  goal,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: isSelected
                                        ? FontWeight.w700
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                                    height: 1.3,
                                  ),
                                ),
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
              // Bottom Action Bar
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    if (selectedCount > 0)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '$selectedCount goal${selectedCount > 1 ? 's' : ''} selected',
                          style: const TextStyle(
                            color: AppColors.accentLight,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ElevatedButton(
                      onPressed: selectedCount > 0
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TimelineSelectionScreen(
                                    session: widget.session,
                                  ),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        disabledBackgroundColor: Colors.white12,
                        foregroundColor: Colors.white,
                        disabledForegroundColor: Colors.white38,
                        minimumSize: const Size(double.infinity, 58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        elevation: selectedCount > 0 ? 4 : 0,
                      ),
                      child: Text(
                        selectedCount > 0
                            ? 'Set Target Timeline  →'
                            : 'Select at least 1 goal',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
}
