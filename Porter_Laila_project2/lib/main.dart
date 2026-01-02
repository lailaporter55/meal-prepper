import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'splash.dart';
import 'quizHome.dart';
import 'allergies.dart';
import 'mood.dart';
import 'weather.dart';
import 'time.dart';
import 'meal.dart';
import 'quiz_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => const QuizHome()),
        GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
        GoRoute(
          path: '/allergies',
          builder: (context, state) {
            final quizData = state.extra as DinnerQuizData?;
            return Allergies(quizData: quizData ?? DinnerQuizData());
          },
        ),
        GoRoute(
          path: '/mood',
          builder: (context, state) {
            final quizData = state.extra as DinnerQuizData?;
            return Mood(quizData: quizData ?? DinnerQuizData());
          },
        ),
        GoRoute(
          path: '/weather',
          builder: (context, state) {
            final quizData = state.extra as DinnerQuizData?;
            return Weather(quizData: quizData ?? DinnerQuizData());
          },
        ),
        GoRoute(
          path: '/time',
          builder: (context, state) {
            final quizData = state.extra as DinnerQuizData?;
            return Time(quizData: quizData ?? DinnerQuizData());
          },
        ),
        GoRoute(
          path: '/meal',
          builder: (context, state) {
            final quizData = state.extra as DinnerQuizData?;
            return Meal(quizData: quizData ?? DinnerQuizData());
          },
        ),
      ],
    );

    return MaterialApp.router(
      title: 'Dinner Quiz',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
