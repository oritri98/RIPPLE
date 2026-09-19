import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ripple_flutter/main.dart';
import 'package:ripple_flutter/models/user_goal_session.dart';
import 'package:ripple_flutter/screens/education_screen.dart';
import 'package:ripple_flutter/screens/health_screen.dart';
import 'package:ripple_flutter/screens/navigation/main_navigation_screen.dart';

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
}
