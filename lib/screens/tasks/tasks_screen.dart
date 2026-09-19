import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/goal_item.dart';
import '../../models/user_goal_session.dart';

class TasksScreen extends StatefulWidget {
  final UserGoalSession? session;

  const TasksScreen({
    super.key,
    this.session,
  });

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  String _selectedCategoryFilter = 'All'; // 'All', 'Career', 'Education', 'Health'
  int _selectedStatusFilter = 0; // 0: All, 1: Active, 2: Done
  final TextEditingController _newGoalController = TextEditingController();
  String _newGoalCategory = 'Career';

  late UserGoalSession _session;

  @override
  void initState() {
    super.initState();
    _session = widget.session ?? UserGoalSession();
    _session.syncGoalItems();
  }

  @override
  void dispose() {
    _newGoalController.dispose();
    super.dispose();
  }

  List<GoalItem> get _filteredGoals {
    var list = _session.goalItems;

    if (_selectedCategoryFilter != 'All') {
      list = list.where((g) => g.category == _selectedCategoryFilter).toList();
    }

    if (_selectedStatusFilter == 1) {
      list = list.where((g) => !g.isCompleted).toList();
    } else if (_selectedStatusFilter == 2) {
      list = list.where((g) => g.isCompleted).toList();
    }

    return list;
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Education':
        return AppColors.educationAccent;
      case 'Health':
        return AppColors.healthAccent;
      case 'Career':
      default:
        return AppColors.careerAccent;
    }
  }

  void _showAddGoalDialog() {
    _newGoalController.clear();
    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return AlertDialog(
              backgroundColor: AppColors.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: AppColors.primary, width: 1.2),
              ),
              title: const Text(
                'Add Goal or Intention',
                style: TextStyle(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _newGoalController,
                    autofocus: true,
                    style: const TextStyle(color: AppColors.onSurface),
                    decoration: InputDecoration(
                      hintText: 'What do you want to accomplish?',
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
                  const SizedBox(height: 16),
                  const Text(
                    'Domain Category',
                    style: TextStyle(
                      color: AppColors.onSurfaceVariant,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: ['Career', 'Education', 'Health'].map((cat) {
                      final isSelected = _newGoalCategory == cat;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: ChoiceChip(
                          label: Text(cat, style: const TextStyle(fontSize: 12)),
                          selected: isSelected,
                          selectedColor: _getCategoryColor(cat).withValues(alpha: 0.3),
                          backgroundColor: AppColors.surfaceContainerHigh,
                          labelStyle: TextStyle(
                            color: isSelected ? _getCategoryColor(cat) : AppColors.onSurfaceVariant,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                          onSelected: (_) {
                            setModalState(() {
                              _newGoalCategory = cat;
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel', style: TextStyle(color: AppColors.onSurfaceVariant)),
                ),
                ElevatedButton(
                  onPressed: () {
                    final text = _newGoalController.text.trim();
                    if (text.isNotEmpty) {
                      setState(() {
                        _session.addCustomGoal(text, category: _newGoalCategory);
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
                  child: const Text('Add Task'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalGoals = _session.goalItems.length;
    final completedGoals = _session.goalItems.where((g) => g.isCompleted).length;
    final progress = totalGoals > 0 ? (completedGoals / totalGoals) : 0.0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: const Text(
          'Tasks & Goals',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_task_rounded, color: AppColors.primary),
            onPressed: _showAddGoalDialog,
            tooltip: 'Add Goal',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Progress Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$completedGoals of $totalGoals Goals Done',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.onSurface,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: AppColors.surfaceContainerHigh,
                      valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Domain Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Row(
              children: [
                _buildFilterChip('All'),
                const SizedBox(width: 8),
                _buildFilterChip('Career'),
                const SizedBox(width: 8),
                _buildFilterChip('Education'),
                const SizedBox(width: 8),
                _buildFilterChip('Health'),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // List of Tasks / Goals
          Expanded(
            child: _filteredGoals.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 48,
                          color: AppColors.outline,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No goals in this filter',
                          style: TextStyle(
                            color: AppColors.onSurfaceVariant,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: _showAddGoalDialog,
                          icon: const Icon(Icons.add_rounded),
                          label: const Text('Add Goal'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: AppColors.onPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    itemCount: _filteredGoals.length,
                    itemBuilder: (context, index) {
                      final goal = _filteredGoals[index];
                      final catColor = _getCategoryColor(goal.category);

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: goal.isCompleted
                              ? AppColors.surfaceContainerLow
                              : AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: goal.isCompleted
                                ? Colors.transparent
                                : Colors.white10,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _session.toggleItemCompletion(goal.id);
                                });
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: goal.isCompleted
                                      ? AppColors.primary
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: goal.isCompleted
                                        ? AppColors.primary
                                        : Colors.white38,
                                    width: 2,
                                  ),
                                ),
                                child: goal.isCompleted
                                    ? const Icon(
                                        Icons.check,
                                        size: 15,
                                        color: AppColors.onPrimary,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    goal.title,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: goal.isCompleted
                                          ? FontWeight.normal
                                          : FontWeight.w600,
                                      color: goal.isCompleted
                                          ? AppColors.outline
                                          : AppColors.onSurface,
                                      decoration: goal.isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                      decorationColor: AppColors.outline,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    goal.category,
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: catColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete_outline_rounded,
                                size: 20,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                setState(() {
                                  _session.deleteItem(goal.id);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedCategoryFilter == label;
    final catColor = _getCategoryColor(label);

    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: catColor.withValues(alpha: 0.25),
      backgroundColor: AppColors.surfaceContainerHigh,
      labelStyle: TextStyle(
        color: isSelected ? catColor : AppColors.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        fontSize: 13,
      ),
      side: BorderSide(
        color: isSelected ? catColor : Colors.white12,
      ),
      onSelected: (_) {
        setState(() {
          _selectedCategoryFilter = label;
        });
      },
    );
  }
}
