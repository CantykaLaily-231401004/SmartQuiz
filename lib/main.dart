import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'config/routes.dart';
import 'config/theme.dart';
import 'providers/quiz_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';
import 'screens/review_screen.dart';
import 'screens/leaderboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuizProvider(),
      child: Consumer<QuizProvider>(
        builder: (context, provider, _) {
          return MaterialApp(
            title: 'SmartQuiz',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            initialRoute: AppRoutes.splash,
            routes: {
              AppRoutes.splash: (context) => const SplashScreen(),
              AppRoutes.home: (context) => const HomeScreen(),
              AppRoutes.quiz: (context) => const QuizMainScreen(),
              AppRoutes.result: (context) => const ResultScreen(),
              AppRoutes.review: (context) => const ReviewScreen(),
              AppRoutes.leaderboard: (context) => const LeaderboardScreen(),
            },
          );
        },
      ),
    );
  }
}