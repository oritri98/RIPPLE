class GoalItem {
  final String id;
  String title;
  bool isCompleted;
  String category; // 'Education', 'Career', 'Health', etc.
  final DateTime createdAt;

  GoalItem({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.category = 'Career',
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  GoalItem copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? category,
    DateTime? createdAt,
  }) {
    return GoalItem(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
