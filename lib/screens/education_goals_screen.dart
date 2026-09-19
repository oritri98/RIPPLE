import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/user_goal_session.dart';
import 'dashboard_screen.dart';
import 'navigation/main_navigation_screen.dart';

class EducationGoalsScreen extends StatefulWidget {
  final UserGoalSession session;

  const EducationGoalsScreen({
    super.key,
    required this.session,
  });

  @override
  State<EducationGoalsScreen> createState() => _EducationGoalsScreenState();
}

class _EducationGoalsScreenState extends State<EducationGoalsScreen> {
  final List<String> days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  late List<String> selectedDays;
  late List<String> availableGoals;
  final TextEditingController _customGoalController = TextEditingController();

  final List<String> defaultStudyGoals = [
    'Complete 2 practice problem sets weekly',
    'Review subject flashcards for 20 mins daily',
    'Summarize lecture notes after each class',
    'Maintain 90%+ study schedule attendance',
    'Solve past exam papers under timed conditions',
    'Read assigned textbook chapters before lecture',
  ];

  @override
  void initState() {
    super.initState();
    selectedDays = List.from(widget.session.studyDays);
    availableGoals = List.from(defaultStudyGoals);
    // Include any goals already in session
    for (final item in widget.session.goalItems.where((g) => g.category == 'Education')) {
      if (!availableGoals.contains(item.title)) {
        availableGoals.insert(0, item.title);
      }
    }
    // Pre-select first 2 default goals if empty
    if (widget.session.goalItems.where((g) => g.category == 'Education').isEmpty) {
      widget.session.addCustomGoal(availableGoals[0], category: 'Education');
      widget.session.addCustomGoal(availableGoals[1], category: 'Education');
    }
  }

  @override
  void dispose() {
    _customGoalController.dispose();
    super.dispose();
  }

  void _showAddGoalDialog() {
    _customGoalController.clear();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.cardBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFFD4A373), width: 1.5),
          ),
          title: const Text(
            'Add Study Goal',
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
              hintText: 'e.g. Finish Chapter 4 review',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFD4A373)),
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
                final text = _customGoalController.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    if (!availableGoals.contains(text)) {
                      availableGoals.insert(0, text);
                    }
                    widget.session.addCustomGoal(text, category: 'Education');
                  });
                  Navigator.pop(dialogContext);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4A373),
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
    final educationGoalsCount =
        widget.session.goalItems.where((g) => g.category == 'Education').length;

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
            onPressed: _showAddGoalDialog,
            icon: const Icon(Icons.add_rounded, color: Color(0xFFD4A373)),
            label: const Text(
              'Custom Goal',
              style: TextStyle(
                color: Color(0xFFD4A373),
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
              const Text(
                'Study Routine & Goals',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  height: 1.15,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Pick your active study days and select your target academic goals.',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 15,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              // 1. Days Active Selector
              const Text(
                'ACTIVE STUDY DAYS',
                style: TextStyle(
                  color: Color(0xFFD4A373),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: days.map((day) {
                  final isSelected = selectedDays.contains(day);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          selectedDays.remove(day);
                        } else {
                          selectedDays.add(day);
                        }
                        widget.session.studyDays = List.from(selectedDays);
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      width: 44,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFFD4A373)
                            : AppColors.cardBg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFFD4A373)
                              : Colors.white12,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        day.substring(0, 1),
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // 2. Study Goals Checklist
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'ACADEMIC GOALS',
                    style: TextStyle(
                      color: Color(0xFFD4A373),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    '$educationGoalsCount selected',
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: availableGoals.length,
                  itemBuilder: (context, index) {
                    final goal = availableGoals[index];
                    final isSelected = widget.session.goalItems.any(
                      (g) => g.title == goal && g.category == 'Education',
                    );

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              final item = widget.session.goalItems.firstWhere(
                                (g) => g.title == goal && g.category == 'Education',
                              );
                              widget.session.deleteItem(item.id);
                            } else {
                              widget.session.addCustomGoal(goal, category: 'Education');
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.cardBgSelected
                                : AppColors.cardBg,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFD4A373)
                                  : Colors.white12,
                              width: isSelected ? 2.0 : 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFFD4A373)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFD4A373)
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
                              const SizedBox(width: 14),
                              Expanded(
                                child: Text(
                                  goal,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.normal,
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

              // Save & Open Dashboard
              ElevatedButton(
                onPressed: educationGoalsCount > 0
                    ? () {
                        widget.session.studyDays = List.from(selectedDays);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainNavigationScreen(session: widget.session),
                          ),
                          (route) => false,
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD4A373),
                  disabledBackgroundColor: Colors.white12,
                  foregroundColor: Colors.white,
                  disabledForegroundColor: Colors.white38,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  elevation: educationGoalsCount > 0 ? 3 : 0,
                ),
                child: const Text(
                  'Open Goal Dashboard 🚀',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
