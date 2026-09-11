import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/task_item.dart';
import '../../../theme/app_theme.dart';

/// TaskListSection displays the decluttered, airy tasks list.
/// 
/// BEGINNER TIP:
/// In v2, tasks are organized inside a single unified card with clean
/// hairline dividers and circular checkmarks, giving a clean notebook feel.
class TaskListSection extends StatefulWidget {
  const TaskListSection({super.key});

  @override
  State<TaskListSection> createState() => _TaskListSectionState();
}

class _TaskListSectionState extends State<TaskListSection> {
  // Tasks list matching the Stitch v2 mockup
  final List<TaskItem> _tasks = [
    TaskItem(
      id: '1',
      title: 'Morning breathwork & intention setting',
      tag: 'Wellness',
      time: '07:15',
      isCompleted: true,
    ),
    TaskItem(
      id: '2',
      title: 'Draft chapter 3 notes & outline review',
      tag: 'Writing',
      time: '10:30',
      isCompleted: false,
    ),
    TaskItem(
      id: '3',
      title: 'Review studio acoustic treatments proposal',
      tag: 'Project',
      time: '14:00',
      isCompleted: true,
    ),
    TaskItem(
      id: '4',
      title: 'Forest walk without digital devices',
      tag: 'Mindfulness',
      time: '17:00',
      isCompleted: false,
    ),
    TaskItem(
      id: '5',
      title: 'Evening tea reflection & gratitude log',
      tag: 'Reflection',
      time: '20:00',
      isCompleted: false,
    ),
  ];

  void _toggleTask(TaskItem task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
  }

  void _showAddTaskDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceContainer,
        title: Text(
          'Add New Task',
          style: GoogleFonts.literata(color: AppColors.onSurface),
        ),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: GoogleFonts.plusJakartaSans(color: AppColors.onSurface),
          decoration: InputDecoration(
            hintText: 'e.g. Read 15 minutes of poetry',
            hintStyle: GoogleFonts.plusJakartaSans(color: AppColors.outline),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.outlineVariant),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.primary),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Cancel',
              style: GoogleFonts.plusJakartaSans(color: AppColors.onSurfaceVariant),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                setState(() {
                  _tasks.add(
                    TaskItem(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: controller.text.trim(),
                      tag: 'Personal',
                      time: 'Today',
                      isCompleted: false,
                    ),
                  );
                });
                Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.onPrimary,
            ),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final completedCount = _tasks.where((t) => t.isCompleted).length;
    final totalCount = _tasks.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header row: "Tasks" + "2 of 5" pill + "+ Add Task" button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Tasks',
                  style: GoogleFonts.literata(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$completedCount of $totalCount',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.outline,
                    ),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: _showAddTaskDialog,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Add Task',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Grouped Card Container
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.outlineVariant.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _tasks.length,
            separatorBuilder: (_, _) => Divider(
              height: 1,
              thickness: 1,
              color: AppColors.outlineVariant.withValues(alpha: 0.25),
            ),
            itemBuilder: (context, index) {
              final task = _tasks[index];
              return _buildTaskRow(task);
            },
          ),
        ),
      ],
    );
  }

  /// Individual Task Row inside the grouped card
  Widget _buildTaskRow(TaskItem task) {
    final isAccent = task.tag == 'Writing';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Checkbox
          GestureDetector(
            onTap: () => _toggleTask(task),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: task.isCompleted ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: task.isCompleted ? AppColors.primary : AppColors.outline,
                  width: 1.5,
                ),
              ),
              child: task.isCompleted
                  ? const Icon(
                      Icons.check,
                      size: 13,
                      color: AppColors.onPrimary,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 12),

          // Task title & category tag
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: task.isCompleted
                        ? AppColors.outline
                        : AppColors.onSurface,
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  task.tag,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: isAccent && !task.isCompleted
                        ? AppColors.primary
                        : AppColors.outline,
                  ),
                ),
              ],
            ),
          ),

          // Time timestamp on right
          const SizedBox(width: 8),
          Text(
            task.time,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isAccent && !task.isCompleted
                  ? AppColors.primary
                  : AppColors.outline,
            ),
          ),
        ],
      ),
    );
  }
}
