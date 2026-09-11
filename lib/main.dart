import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/navigation/main_navigation_screen.dart';
import 'theme/app_theme.dart';

void main() {
  // Ensure Flutter engine is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Set system status bar style to match our deep dark theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const RippleApp());
}

/// RippleApp is the root widget of the application.
/// 
/// BEGINNER TIP:
/// This sets up MaterialApp with our custom dark theme from `AppTheme`
/// and launches `MainNavigationScreen` as the shell.
class RippleApp extends StatelessWidget {
  const RippleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ripple',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainNavigationScreen(),
    );
  }
}
