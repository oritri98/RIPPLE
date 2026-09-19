import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../models/user_goal_session.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../home/home_screen.dart';
import '../insights/insights_screen.dart';
import '../journal/journal_screen.dart';
import '../journal/widgets/journal_entry_modal.dart';
import '../tasks/tasks_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final UserGoalSession? session;
  final int initialIndex;

  const MainNavigationScreen({
    super.key,
    this.session,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;
  late UserGoalSession _session;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _session = widget.session ?? UserGoalSession();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(session: _session),
      const JournalScreen(),
      TasksScreen(session: _session),
      InsightsScreen(session: _session),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: FloatingActionButton(
          onPressed: () => showJournalEntryModal(context),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: const CircleBorder(),
          elevation: 6,
          tooltip: 'Quick Journal Entry',
          child: const Icon(Icons.edit_outlined, size: 24),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
    );
  }
}
