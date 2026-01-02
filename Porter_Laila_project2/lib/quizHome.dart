import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quiz_data.dart';

//starting page of the quiz
//navigates to allergies page

class QuizHome extends StatelessWidget {
  const QuizHome({super.key});

  @override
  Widget build(BuildContext context) {
    final quizData = DinnerQuizData(); //start empty quiz

    return Scaffold(
      body: SafeArea(
        child: Container(
          //clean gradient background
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade50, Colors.orange.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //title
              Text(
                "Welcome to Dinner Quiz!",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.deepOrange),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                "Answer a few questions and we'll suggest what to make for dinner based on your mood, time, allergies, and the weather!",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              //start quiz button
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: const Text("Start Quiz"),
                onPressed: () {
                  context.go('/allergies', extra: quizData);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

