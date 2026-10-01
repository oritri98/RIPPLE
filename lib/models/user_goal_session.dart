import 'goal_item.dart';

class UserGoalSession {
  // Category / Domain
  String? activeCategory; // 'Education', 'Career', 'Health'

  // Career domain fields
  String? stage;
  String? focusArea;
  List<String> selectedGoals;
  String? timeline;

  // Education domain fields
  String? studyFrequency; // 'Daily', 'Weekly', 'Monthly'
  List<String> studyDays; // ['M', 'T', 'W', 'Th', 'F']
  String? studyMaterialName;
  String? educationFocus;

  // Unified goals list
  List<GoalItem> goalItems;

  UserGoalSession({
    this.activeCategory,
    this.stage,
    this.focusArea,
    List<String>? selectedGoals,
    this.timeline,
    this.studyFrequency,
    List<String>? studyDays,
    this.studyMaterialName,
    this.educationFocus,
    List<GoalItem>? goalItems,
  })  : selectedGoals = selectedGoals ?? [],
        studyDays = studyDays ?? ['M', 'T', 'W', 'Th', 'F'],
        goalItems = goalItems ?? [] {
    if (this.goalItems.isEmpty && this.selectedGoals.isNotEmpty) {
      this.goalItems = this.selectedGoals
          .map((title) => GoalItem(
                id: DateTime.now().millisecondsSinceEpoch.toString() + title,
                title: title,
                category: activeCategory ?? 'Career',
              ))
          .toList();
    }
  }

  void toggleGoal(String goal, {String category = 'Career'}) {
    if (selectedGoals.contains(goal)) {
      selectedGoals.remove(goal);
      goalItems.removeWhere((item) => item.title == goal);
    } else {
      selectedGoals.add(goal);
      if (!goalItems.any((item) => item.title == goal)) {
        goalItems.add(GoalItem(
          id: DateTime.now().millisecondsSinceEpoch.toString() + goal,
          title: goal,
          category: category,
        ));
      }
    }
  }

  void syncGoalItems() {
    if (goalItems.isEmpty && selectedGoals.isNotEmpty) {
      goalItems = selectedGoals
          .map((title) => GoalItem(
                id: DateTime.now().millisecondsSinceEpoch.toString() + title,
                title: title,
                category: activeCategory ?? 'Career',
              ))
          .toList();
    }
  }

  void addCustomGoal(String goal, {String category = 'Career'}) {
    final trimmed = goal.trim();
    if (trimmed.isNotEmpty) {
      if (!selectedGoals.contains(trimmed)) {
        selectedGoals.add(trimmed);
      }
      if (!goalItems.any((item) => item.title == trimmed)) {
        goalItems.add(GoalItem(
          id: DateTime.now().millisecondsSinceEpoch.toString() + trimmed,
          title: trimmed,
          category: category,
        ));
      }
    }
  }

  void toggleItemCompletion(String id) {
    final index = goalItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      goalItems[index].isCompleted = !goalItems[index].isCompleted;
    }
  }

  void deleteItem(String id) {
    final item = goalItems.firstWhere((i) => i.id == id, orElse: () => GoalItem(id: '', title: ''));
    if (item.id.isNotEmpty) {
      selectedGoals.remove(item.title);
      goalItems.removeWhere((i) => i.id == id);
    }
  }

  int get totalGoals => goalItems.length;
  int get completedGoals => goalItems.where((g) => g.isCompleted).length;
  double get progress =>
      totalGoals == 0 ? 0.0 : (completedGoals / totalGoals).clamp(0.0, 1.0);

  bool get isReadyForSummary =>
      stage != null &&
      focusArea != null &&
      selectedGoals.isNotEmpty &&
      timeline != null;

  UserGoalSession copyWith({
    String? activeCategory,
    String? stage,
    String? focusArea,
    List<String>? selectedGoals,
    String? timeline,
    String? studyFrequency,
    List<String>? studyDays,
    String? studyMaterialName,
    String? educationFocus,
    List<GoalItem>? goalItems,
  }) {
    return UserGoalSession(
      activeCategory: activeCategory ?? this.activeCategory,
      stage: stage ?? this.stage,
      focusArea: focusArea ?? this.focusArea,
      selectedGoals: selectedGoals ?? List.from(this.selectedGoals),
      timeline: timeline ?? this.timeline,
      studyFrequency: studyFrequency ?? this.studyFrequency,
      studyDays: studyDays ?? List.from(this.studyDays),
      studyMaterialName: studyMaterialName ?? this.studyMaterialName,
      educationFocus: educationFocus ?? this.educationFocus,
      goalItems: goalItems ?? List.from(this.goalItems),
    );
  }
}
