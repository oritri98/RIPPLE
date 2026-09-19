import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import '../../../models/user_goal_session.dart';

class TaskListSection extends StatefulWidget {
  final UserGoalSession? session;

  const TaskListSection({
    super.key,
    this.session,
  });

  @override
  State<TaskListSection> createState() => _TaskListSectionState();
}

class _TaskListSectionState extends State<TaskListSection> {
  final TextEditingController _intentionController = TextEditingController();

  final List<Map<String, dynamic>> _defaultTasks = [
    {'title': 'Deep focus study & practice', 'done': false, 'tag': 'Career'},
    {'title': 'Review study routine / lecture notes', 'done': true, 'tag': 'Education'},
    {'title': '15 mins mindfulness & evening stretch', 'done': false, 'tag': 'Health'},
  ];

  @override
  void dispose() {
    _intentionController.dispose();
    super.dispose();
  }

  void _showAddIntentionDialog() {
    _intentionController.clear();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surfaceContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: AppColors.primary, width: 1.2),
          ),
          title: const Text(
            'Add Today\'s Intention',
            style: TextStyle(
              color: AppColors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: _intentionController,
            autofocus: true,
            style: const TextStyle(color: AppColors.onSurface),
            decoration: InputDecoration(
              hintText: 'e.g. Finish reading Chapter 3',
              hintStyle: const TextStyle(color: AppColors.textMuted),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.white24),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel', style: TextStyle(color: AppColors.onSurfaceVariant)),
            ),
            ElevatedButton(
              onPressed: () {
                final text = _intentionController.text.trim();
                if (text.isNotEmpty) {
                  setState(() {
                    if (widget.session != null) {
                      widget.session!.addCustomGoal(text, category: 'Career');
                    } else {
                      _defaultTasks.add({'title': text, 'done': false, 'tag': 'Focus'});
                    }
                  });
                  Navigator.pop(dialogContext);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text('Add Intention'),
            ),
          ],
        );
      },
    );
  }

  Color _getTagColor(String tag) {
    switch (tag) {
      case 'Education':
        return AppColors.educationAccent;
      case 'Health':
        return AppColors.healthAccent;
      case 'Career':
      default:
        return AppColors.careerAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = widget.session;
    final hasSessionGoals = session != null && session.goalItems.isNotEmpty;

    final totalCount = hasSessionGoals
        ? session.goalItems.length
        : _defaultTasks.length;
    final completedCount = hasSessionGoals
        ? session.goalItems.where((g) => g.isCompleted).length
        : _defaultTasks.where((t) => t['done'] as bool).length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white10,
          width: 1.2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Today\'s Intentions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$completedCount/$totalCount',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: _showAddIntentionDialog,
                icon: const Icon(Icons.add_circle_outline_rounded, color: AppColors.primary),
                tooltip: 'Add Intention',
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: totalCount > 0 ? (completedCount / totalCount) : 0,
              minHeight: 6,
              backgroundColor: AppColors.surfaceContainerHigh,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          ),
          const SizedBox(height: 16),

          if (hasSessionGoals)
            ...session.goalItems.map((goal) {
              return _buildGoalRow(
                title: goal.title,
                isDone: goal.isCompleted,
                tag: goal.category,
                onToggle: () {
                  setState(() {
                    session.toggleItemCompletion(goal.id);
                  });
                },
              );
            })
          else
            ..._defaultTasks.asMap().entries.map((entry) {
              final idx = entry.key;
              final task = entry.value;
              return _buildGoalRow(
                title: task['title'] as String,
                isDone: task['done'] as bool,
                tag: task['tag'] as String,
                onToggle: () {
                  setState(() {
                    _defaultTasks[idx]['done'] = !(_defaultTasks[idx]['done'] as bool);
                  });
                },
              );
            }),
        ],
      ),
    );
  }

  Widget _buildGoalRow({
    required String title,
    required bool isDone,
    required String tag,
    required VoidCallback onToggle,
  }) {
    final tagColor = _getTagColor(tag);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: onToggle,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isDone ? AppColors.surfaceContainerLow : AppColors.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDone ? Colors.transparent : Colors.white10,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: isDone ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDone ? AppColors.primary : Colors.white38,
                    width: 2,
                  ),
                ),
                child: isDone
                    ? const Icon(
                        Icons.check,
                        size: 14,
                        color: AppColors.onPrimary,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDone ? AppColors.outline : AppColors.onSurface,
                    decoration: isDone ? TextDecoration.lineThrough : null,
                    decorationColor: AppColors.outline,
                    fontWeight: isDone ? FontWeight.normal : FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tagColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tag,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: tagColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
