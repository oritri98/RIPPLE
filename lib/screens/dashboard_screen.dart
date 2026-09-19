import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../models/goal_item.dart';
import '../models/user_goal_session.dart';
import 'category_selection_screen.dart';

class DashboardScreen extends StatefulWidget {
  final UserGoalSession session;

  const DashboardScreen({
    super.key,
    required this.session,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _selectedCategoryFilter = 'All'; // 'All', 'Education', 'Career', 'Health'
  int _selectedStatusFilter = 0; // 0: All, 1: Active, 2: Completed
  final TextEditingController _newGoalController = TextEditingController();
  String _newGoalCategory = 'Career';

  @override
  void initState() {
    super.initState();
    widget.session.syncGoalItems();
  }

  @override
  void dispose() {
    _newGoalController.dispose();
    super.dispose();
  }

  List<GoalItem> get _filteredGoals {
    var list = widget.session.goalItems;

    // Filter by Domain Category
    if (_selectedCategoryFilter != 'All') {
      list = list.where((g) => g.category == _selectedCategoryFilter).toList();
    }

    // Filter by Status
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
        return const Color(0xFFD4A373);
      case 'Health':
        return const Color(0xFF81B29A);
      case 'Career':
      default:
        return AppColors.accent;
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Education':
        return Icons.school_rounded;
      case 'Health':
        return Icons.spa_rounded;
      case 'Career':
      default:
        return Icons.work_rounded;
    }
  }

  List<Map<String, String>> _getMilestones(String? timeline) {
    switch (timeline) {
      case '1 Week':
        return [
          {'phase': 'Day 1 - 2', 'task': 'Kickoff & Setup foundations'},
          {'phase': 'Day 3 - 5', 'task': 'Intense execution & practice'},
          {'phase': 'Day 6 - 7', 'task': 'Review, wrap-up & celebrate'},
        ];
      case '3 Months':
        return [
          {'phase': 'Month 1', 'task': 'Foundational skill acquisition & planning'},
          {'phase': 'Month 2', 'task': 'Core milestone execution & portfolio building'},
          {'phase': 'Month 3', 'task': 'Outreach, applications & final outcomes'},
        ];
      case '6 Months':
        return [
          {'phase': 'Month 1 - 2', 'task': 'Deep immersion & prerequisite mastering'},
          {'phase': 'Month 3 - 4', 'task': 'Midpoint sprint & project completion'},
          {'phase': 'Month 5 - 6', 'task': 'Career acceleration & target achievement'},
        ];
      case '1 Month':
      default:
        return [
          {'phase': 'Week 1', 'task': 'Set up workspace & initial milestones'},
          {'phase': 'Week 2 - 3', 'task': 'Deep execution & daily progress'},
          {'phase': 'Week 4', 'task': 'Final refinement, review & launch'},
        ];
    }
  }

  void _showAddGoalDialog() {
    _newGoalController.clear();
    _newGoalCategory = _selectedCategoryFilter == 'All' ? 'Career' : _selectedCategoryFilter;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppColors.cardBg,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: _getCategoryColor(_newGoalCategory),
                  width: 1.5,
                ),
              ),
              title: const Text(
                'Add New Goal',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Category:',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: ['Career', 'Education', 'Health'].map((cat) {
                      final isSelected = _newGoalCategory == cat;
                      final catColor = _getCategoryColor(cat);
                      return ChoiceChip(
                        label: Text(cat),
                        selected: isSelected,
                        onSelected: (val) {
                          if (val) {
                            setDialogState(() {
                              _newGoalCategory = cat;
                            });
                          }
                        },
                        selectedColor: catColor.withValues(alpha: 0.25),
                        backgroundColor: Colors.white.withValues(alpha: 0.05),
                        labelStyle: TextStyle(
                          color: isSelected ? catColor : AppColors.textSecondary,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                        side: BorderSide(
                          color: isSelected ? catColor : Colors.white12,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _newGoalController,
                    autofocus: true,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'e.g. Apply to 5 internships or review Chapter 4',
                      hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.white24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: _getCategoryColor(_newGoalCategory)),
                      ),
                    ),
                  ),
                ],
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
                    final text = _newGoalController.text.trim();
                    if (text.isNotEmpty) {
                      setState(() {
                        widget.session.addCustomGoal(text, category: _newGoalCategory);
                      });
                      Navigator.pop(dialogContext);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _getCategoryColor(_newGoalCategory),
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.session.totalGoals;
    final completed = widget.session.completedGoals;
    final progress = widget.session.progress;
    final percentage = (progress * 100).toInt();
    final milestones = _getMilestones(widget.session.timeline);

    // Active domain summaries
    final educationCount = widget.session.goalItems.where((g) => g.category == 'Education').length;
    final careerCount = widget.session.goalItems.where((g) => g.category == 'Career').length;
    final healthCount = widget.session.goalItems.where((g) => g.category == 'Health').length;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Goal Dashboard',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Category Hub',
            icon: const Icon(Icons.apps_rounded, color: AppColors.accent),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategorySelectionScreen(session: widget.session),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddGoalDialog,
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Goal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          children: [
            // Stage & Focus Info Banner
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      if (careerCount > 0)
                        _buildCategoryBadge('Career: ${widget.session.stage ?? "Roadmap"}', 'Career'),
                      if (educationCount > 0)
                        _buildCategoryBadge(
                          'Education: ${widget.session.studyFrequency ?? "Active"}',
                          'Education',
                        ),
                      if (healthCount > 0)
                        _buildCategoryBadge('Health & Wellness', 'Health'),
                      if (careerCount == 0 && educationCount == 0 && healthCount == 0)
                        _buildCategoryBadge('Ripple Goals', 'Career'),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Overall Progress',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '$completed of $total Goals Done',
                            style: const TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.cardBgSelected,
                          border: Border.all(
                            color: AppColors.accent,
                            width: 2,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$percentage%',
                          style: const TextStyle(
                            color: AppColors.accentLight,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 8,
                      backgroundColor: Colors.white.withValues(alpha: 0.1),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.accent,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // Timeline Roadmap Milestone Expansion Card (if career timeline is set)
            if (widget.session.timeline != null)
              Container(
                margin: const EdgeInsets.only(bottom: 18),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.white12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.rocket_launch_rounded,
                          color: AppColors.accent,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.session.timeline} Roadmap Phases',
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ...milestones.map((m) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.accent.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                m['phase']!,
                                style: const TextStyle(
                                  color: AppColors.accentLight,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                m['task']!,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),

            // Add Domain Goals Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.add_circle_outline_rounded, color: AppColors.accent, size: 22),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'Explore other sections to add goals',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategorySelectionScreen(session: widget.session),
                        ),
                      );
                    },
                    child: const Text(
                      'Explore Hub →',
                      style: TextStyle(
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Domain Category Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  _buildDomainFilterChip('All', 'All', total),
                  const SizedBox(width: 8),
                  _buildDomainFilterChip('Education', 'Education', educationCount),
                  const SizedBox(width: 8),
                  _buildDomainFilterChip('Career', 'Career', careerCount),
                  const SizedBox(width: 8),
                  _buildDomainFilterChip('Health', 'Health', healthCount),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // Status Filter Tabs
            Row(
              children: [
                Text(
                  '$_selectedCategoryFilter Goals',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                _buildStatusChip('All', 0),
                const SizedBox(width: 6),
                _buildStatusChip('Active', 1),
                const SizedBox(width: 6),
                _buildStatusChip('Done', 2),
              ],
            ),

            const SizedBox(height: 14),

            // Goals List
            if (_filteredGoals.isEmpty)
              Container(
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Icon(
                      _selectedStatusFilter == 2
                          ? Icons.task_alt_rounded
                          : Icons.checklist_rounded,
                      size: 48,
                      color: AppColors.textMuted,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _selectedStatusFilter == 2
                          ? 'No completed goals yet.\nTap a goal checkbox when done!'
                          : 'No goals found in this view.\nTap "+ Add Goal" or explore the Hub!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              )
            else
              ..._filteredGoals.map((goal) {
                final catColor = _getCategoryColor(goal.category);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.session.toggleItemCompletion(goal.id);
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: goal.isCompleted
                            ? AppColors.cardBg.withValues(alpha: 0.5)
                            : AppColors.cardBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: goal.isCompleted
                              ? catColor.withValues(alpha: 0.5)
                              : Colors.white12,
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: goal.isCompleted
                                  ? catColor
                                  : Colors.transparent,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: goal.isCompleted
                                    ? catColor
                                    : Colors.white54,
                                width: 2,
                              ),
                            ),
                            child: goal.isCompleted
                                ? const Icon(
                                    Icons.check_rounded,
                                    size: 18,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: catColor.withValues(alpha: 0.18),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            _getCategoryIcon(goal.category),
                                            size: 12,
                                            color: catColor,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            goal.category,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: catColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  goal.title,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: goal.isCompleted
                                        ? AppColors.textMuted
                                        : AppColors.textPrimary,
                                    decoration: goal.isCompleted
                                        ? TextDecoration.lineThrough
                                        : null,
                                    decorationColor: catColor,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              size: 20,
                              color: AppColors.textMuted,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.session.deleteItem(goal.id);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

            const SizedBox(height: 80), // Padding for FAB
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBadge(String label, String category) {
    final catColor = _getCategoryColor(category);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: catColor.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getCategoryIcon(category),
            size: 14,
            color: catColor,
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: catColor,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDomainFilterChip(String label, String category, int count) {
    final isSelected = _selectedCategoryFilter == category;
    final catColor = _getCategoryColor(category);

    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategoryFilter = category;
        });
      },
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? catColor.withValues(alpha: 0.25)
              : AppColors.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? catColor : Colors.white12,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category != 'All') ...[
              Icon(_getCategoryIcon(category), size: 14, color: isSelected ? catColor : AppColors.textMuted),
              const SizedBox(width: 6),
            ],
            Text(
              '$label ($count)',
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String label, int index) {
    final isSelected = _selectedStatusFilter == index;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedStatusFilter = index;
        });
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accent
              : Colors.white.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
