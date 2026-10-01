import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ripple_flutter/main.dart';
import 'package:ripple_flutter/models/user_goal_session.dart';
import 'package:ripple_flutter/screens/education_screen.dart';
import 'package:ripple_flutter/screens/health_screen.dart';
import 'package:ripple_flutter/models/journal_entry.dart';
import 'package:ripple_flutter/models/mood_item.dart';
import 'package:ripple_flutter/services/journal_service.dart';

void main() {
  testWidgets('Login Validation, Onboarding, and Main Navigation Smoke Test', (WidgetTester tester) async {
    // Set realistic mobile phone viewport
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // 1. Launch App (starts at LoginScreen)
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Verify Login Screen
    expect(find.text('Welcome to Ripple'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Forgot Password?'), findsNothing);

    // Test Validation: Tap Log In with empty fields -> should show error messages
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);

    // Enter valid credentials
    final emailField = find.byType(TextField).at(0);
    final passwordField = find.byType(TextField).at(1);

    await tester.enterText(emailField, 'user@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.pumpAndSettle();

    // Tap Log In to enter Category Hub
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    // Verify Category Hub Screen
    expect(find.text('Where shall we start?'), findsOneWidget);
    expect(find.text('Education'), findsOneWidget);
    expect(find.text('Career and Goals'), findsOneWidget);
    expect(find.text('Health & Wellbeing'), findsOneWidget);

    // 2. Select Career and Goals
    await tester.tap(find.text('Career and Goals'));
    await tester.pumpAndSettle();

    // Step 1: Stage Selection
    expect(find.text('What stage are you at?'), findsOneWidget);
    await tester.tap(find.text('University Student'));
    await tester.pumpAndSettle();

    // Step 2: Focus Area Selection
    expect(find.text('What are you working toward?'), findsOneWidget);
    await tester.tap(find.text('Get a Job'));
    await tester.pumpAndSettle();

    // Step 3: Goal Selection
    expect(find.text('What are your goals?'), findsOneWidget);
    await tester.tap(find.text('Polish LinkedIn and build a standout resume'));
    await tester.pumpAndSettle();

    // Step 4: Timeline Selection
    await tester.tap(find.text('Set Target Timeline  →'));
    await tester.pumpAndSettle();
    expect(find.text('Pick your timeline'), findsOneWidget);
    await tester.tap(find.text('1 Week'));
    await tester.pumpAndSettle();

    // Step 5: Summary Screen
    await tester.tap(find.text('Review Goal Plan  →'));
    await tester.pumpAndSettle();
    expect(find.text('Your Goal Blueprint'), findsOneWidget);

    // Tap "Start My Plan 🚀" to launch MainNavigationScreen
    await tester.tap(find.text('Start My Plan 🚀'));
    await tester.pumpAndSettle();

    // Verify Main Navigation Screen (Today tab active)
    expect(find.text('Good morning.'), findsOneWidget);
    expect(find.text('Today\'s Intentions'), findsOneWidget);
    expect(find.text('Polish LinkedIn and build a standout resume'), findsOneWidget);

    // 3. Test Tab Switching: Journal Tab
    await tester.tap(find.text('Journal'));
    await tester.pumpAndSettle();
    expect(find.text('HOW ARE YOU FEELING?').hitTestable(), findsNothing);

    // 4. Test Tab Switching: Tasks Tab
    await tester.tap(find.text('Tasks'));
    await tester.pumpAndSettle();
    expect(find.text('Tasks & Goals'), findsOneWidget);
    expect(find.text('Polish LinkedIn and build a standout resume'), findsOneWidget);

    // 5. Test Tab Switching: Insights Tab
    await tester.tap(find.text('Insights'));
    await tester.pumpAndSettle();
    expect(find.text('5 Day Active Streak'), findsOneWidget);

    // 6. Test Center FAB (Quick Journal Entry Modal)
    final fab = find.byType(FloatingActionButton);
    expect(fab, findsOneWidget);
    await tester.tap(fab);
    await tester.pumpAndSettle();

    expect(find.text('New Journal Entry'), findsOneWidget);
    expect(find.text('HOW ARE YOU FEELING?'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
  });

  testWidgets('Education screen routine upload optional flow', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final session = UserGoalSession(activeCategory: 'Education');

    await tester.pumpWidget(
      MaterialApp(
        home: EducationScreen(session: session),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Education Preferences'), findsOneWidget);
    expect(find.text('SUBMIT ROUTINE (PDF OR IMAGE)'), findsOneWidget);
    expect(find.text('(Optional)'), findsOneWidget);

    // Upload PDF optionally
    await tester.tap(find.text('Upload PDF'));
    await tester.pumpAndSettle();
    expect(find.text('Academic_Class_Routine_2026.pdf'), findsOneWidget);

    // Tap to proceed to study goals
    await tester.tap(find.text('Set Study Goals  →'));
    await tester.pumpAndSettle();
    expect(find.text('Study Routine & Goals'), findsOneWidget);
  });

  testWidgets('Health Screen starts empty and allows custom target addition', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final session = UserGoalSession(activeCategory: 'Health');

    await tester.pumpWidget(
      MaterialApp(
        home: HealthScreen(session: session),
      ),
    );
    await tester.pumpAndSettle();

    // Verify Health Screen is empty initially
    expect(find.text('No Health Goals Added Yet'), findsOneWidget);
    expect(find.text('0 selected'), findsOneWidget);

    // Tap "Add Custom Target" button in the empty state
    await tester.tap(find.text('Add Custom Target'));
    await tester.pumpAndSettle();

    // Dialog appears
    expect(find.text('Add Health Target'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'Drink 2.5L water daily');
    await tester.tap(find.text('Add Target'));
    await tester.pumpAndSettle();

    // Verify custom target appears and is selected
    expect(find.text('Drink 2.5L water daily'), findsOneWidget);
    expect(find.text('1 selected'), findsOneWidget);
  });

  testWidgets('Events calendar displays images, moods, voice memos, and supports adding new entry', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Fast-login
    final emailField = find.byType(TextField).at(0);
    final passwordField = find.byType(TextField).at(1);
    await tester.enterText(emailField, 'user@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    // Select Career -> Student -> Job -> Goal -> Timeline -> Start
    await tester.tap(find.text('Career and Goals'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('University Student'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Get a Job'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Polish LinkedIn and build a standout resume'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Set Target Timeline  →'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('1 Week'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Review Goal Plan  →'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start My Plan 🚀'));
    await tester.pumpAndSettle();

    // 1. Tap on the new Events tab
    expect(find.text('Events'), findsOneWidget);
    await tester.tap(find.text('Events'));
    await tester.pumpAndSettle();

    // Verify Events screen loaded
    expect(find.text('Calendar & Memory Timeline'), findsOneWidget);
    expect(find.text('MEMORIES & HIGHLIGHTS'), findsOneWidget);

    // Verify filter pills exist
    expect(find.text('All'), findsWidgets);
    expect(find.text('📷 Photos'), findsOneWidget);
    expect(find.text('🎙️ Voice'), findsOneWidget);

    // 2. Open Add Entry modal from Events screen
    await tester.tap(find.text('Add Entry'));
    await tester.pumpAndSettle();

    expect(find.text('New Journal Entry'), findsOneWidget);
    expect(find.text('Add Photo'), findsOneWidget);
    expect(find.text('Voice Memo'), findsOneWidget);

    // Enter reflection text
    final contentField = find.byType(TextField).at(1);
    await tester.enterText(contentField, 'Testing calendar memory with photos and voice.');

    // Save entry
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    // Verify snackbar feedback and return to Events screen
    expect(find.text('Journal entry & memories saved to your timeline! ✨'), findsOneWidget);
  });

  testWidgets('Journal Screen supports pinning up to 5 entries and deleting with confirmation and undo', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Initial check on service
    final initialCount = JournalService.instance.entries.length;
    expect(initialCount, greaterThan(0));

    // Unpin all entries first
    for (final e in List<JournalEntry>.from(JournalEntry.sampleEntries)) {
      if (e.isPinned) {
        JournalService.instance.togglePin(e.id);
      }
    }
    expect(JournalService.instance.pinnedCount, 0);

    // Pin exactly 4 existing entries
    for (int i = 0; i < 4 && i < JournalEntry.sampleEntries.length; i++) {
      final success = JournalService.instance.togglePin(JournalEntry.sampleEntries[i].id);
      expect(success, isTrue);
    }
    expect(JournalService.instance.pinnedCount, 4);

    // Add extra entries to test 5-pin limit
    final extraEntry1 = JournalEntry(
      id: 'test-pin-5',
      title: 'Pin 5 Reflection',
      content: 'Testing 5th pin',
      date: DateTime.now(),
      mood: MoodItem.defaultMoods[0],
    );
    final extraEntry2 = JournalEntry(
      id: 'test-pin-6',
      title: 'Pin 6 Reflection',
      content: 'Testing 6th pin',
      date: DateTime.now(),
    mood: MoodItem.defaultMoods[0],
    );
    JournalService.instance.addEntry(extraEntry1);
    JournalService.instance.addEntry(extraEntry2);

    // Pin 5th entry (should succeed)
    final pin5Success = JournalService.instance.togglePin('test-pin-5');
    expect(pin5Success, isTrue);
    expect(JournalService.instance.pinnedCount, 5);

    // Try pinning 6th entry (must fail due to max 5 limit!)
    final pin6Success = JournalService.instance.togglePin('test-pin-6');
    expect(pin6Success, isFalse);
    expect(JournalService.instance.pinnedCount, 5);

    // Verify pinned entries appear first in the entries getter
    final sorted = JournalService.instance.entries;
    for (int i = 0; i < 5; i++) {
      expect(sorted[i].isPinned, isTrue);
    }
    expect(sorted[5].isPinned, isFalse);

    // Test delete and undo
    final deleted = JournalService.instance.removeEntry('test-pin-6');
    expect(deleted, isNotNull);
    expect(deleted!.id, 'test-pin-6');
    expect(JournalService.instance.entries.any((e) => e.id == 'test-pin-6'), isFalse);

    // Test undo / restore
    JournalService.instance.restoreEntry(deleted);
    expect(JournalService.instance.entries.any((e) => e.id == 'test-pin-6'), isTrue);
  });
}

