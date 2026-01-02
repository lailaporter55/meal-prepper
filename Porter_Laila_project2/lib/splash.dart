import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quiz_data.dart';

//shows a gradient background with the app title/logo for 2 seconds,
//then navigates to QuizHome.

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    //navigate to QuizHome after 2.5 seconds
    Timer(const Duration(seconds: 2), () {
      final quizData = DinnerQuizData(); // start empty quiz data
      context.go('/', extra: quizData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade50, Colors.deepOrange.shade200],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fastfood,
                size: 80,
                color: Colors.deepOrange.shade700,
              ),
              const SizedBox(height: 20),
              Text(
                "Dinner Quiz",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                "Find the perfect meal for tonight",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.deepOrange.shade700,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
