import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/bottom_nav_bar.dart';
import '../home/home_screen.dart';
import '../journal/journal_screen.dart';
import '../journal/widgets/journal_entry_modal.dart';
import '../tasks/tasks_screen.dart';
import '../insights/insights_screen.dart';

/// MainNavigationScreen is the shell that manages tab switching.
/// 
/// BEGINNER TIP:
/// Using an `IndexedStack` keeps each screen's state alive when you
/// switch between tabs, so you don't lose scroll positions or typed notes!
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // The 4 main destinations in Ripple
  final List<Widget> _screens = const [
    HomeScreen(),
    JournalScreen(),
    TasksScreen(),
    InsightsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      
      // Floating Action Button for Quick Capture / Stylus
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 24),
        child: FloatingActionButton(
          onPressed: () => showJournalEntryModal(context),
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          shape: const CircleBorder(),
          elevation: 6,
          child: const Icon(Icons.edit, size: 24),
        ),
      ),

      // Floating Capsule Navigation Bar
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
      ),

      // Displays the selected screen
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
    );
  }
}
