enum TaskPriority {
  deepWork,
  dailyRhythm,
  eveningWindDown,
}

class TaskItem {
  final String id;
  String title;
  bool isCompleted;
  final TaskPriority priority;
  final String? domainCategory; // 'Career', 'Education', 'Health', or null

  TaskItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.priority = TaskPriority.dailyRhythm,
    this.domainCategory,
  });

  String get priorityLabel {
    switch (priority) {
      case TaskPriority.deepWork:
        return 'Deep Work';
      case TaskPriority.dailyRhythm:
        return 'Daily Rhythm';
      case TaskPriority.eveningWindDown:
        return 'Evening Wind Down';
    }
  }
}
