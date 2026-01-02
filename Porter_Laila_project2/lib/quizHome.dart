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
      body: Stack(
        children: [

          //background Image
          Positioned.fill(
            child: Image.asset(
              'images/quizHome.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.45),
            ),
          ),

          //main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    // Title
                    Text(
                      "Welcome to Dinner Quiz!",
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          const Shadow(
                            blurRadius: 10,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Answer a few questions and we'll suggest what to make for dinner based on your mood, time, allergies, and the weather!",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 50),

                    //start Button
                    ElevatedButton.icon(
                      icon: const Icon(Icons.restaurant),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 14,
                        ),
                        backgroundColor: Colors.deepOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      label: const Text(
                        "Start Quiz",
                        style: TextStyle(fontSize: 18),
                      ),
                      onPressed: () {
                        context.go('/allergies', extra: quizData);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
