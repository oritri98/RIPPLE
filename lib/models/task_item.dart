/// TaskItem represents a single intention or task in Ripple.
/// 
/// BEGINNER TIP:
/// A model class is like a blueprint. It defines what pieces of information
/// a "Task" holds so our UI can display it accurately.
class TaskItem {
  final String id;
  final String title;
  final String tag;
  final String time;
  bool isCompleted;
  final bool isHighPriority;
  final bool isInProgress;

  TaskItem({
    required this.id,
    required this.title,
    required this.tag,
    required this.time,
    this.isCompleted = false,
    this.isHighPriority = false,
    this.isInProgress = false,
  });
}
