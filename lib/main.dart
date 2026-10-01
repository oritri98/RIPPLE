import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/navigation/main_navigation_screen.dart';
import 'services/gemini_insight_service.dart';
import 'services/journal_service.dart';
import 'services/session_service.dart';
import 'theme/app_theme.dart';
import 'theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SessionService.instance.init();
  await JournalService.instance.init();
  await GeminiInsightService.instance.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        ThemeManager.instance,
        SessionService.instance,
      ]),
      builder: (context, _) {
        final isLight = ThemeManager.instance.isLight;
        final isLoggedIn = SessionService.instance.isLoggedIn;

        return MaterialApp(
          title: 'Ripple',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: isLight ? ThemeMode.light : ThemeMode.dark,
          home: isLoggedIn
              ? MainNavigationScreen(session: SessionService.instance.savedSession)
              : const LoginScreen(),
        );
      },
    );
  }
}