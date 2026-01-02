import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quiz_data.dart';

class Mood extends StatefulWidget {
  final DinnerQuizData quizData;

  const Mood({super.key, required this.quizData});

  @override
  State<Mood> createState() => _MoodState();
}

class _MoodState extends State<Mood> {
  final List<String> moods = [
    'Happy',
    'Excited',
    'Energized',
    'Moderate',
    'Sad',
    'Stressed',
    'Blue',
    'Relaxed',
    'Anxious',
    'Calm'
  ];

  final Set<String> selectedMood = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How did you feel today?"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.deepOrange,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade50, Colors.orange.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
              "Select all moods you felt today",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.deepOrange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: moods.map((m) {
                  final isSelected = selectedMood.contains(m);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected
                            ? selectedMood.remove(m)
                            : selectedMood.add(m);
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.pinkAccent.withOpacity(0.8)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: isSelected
                              ? Colors.pinkAccent
                              : Colors.pink.shade200,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        m,
                        style: TextStyle(
                          color:
                              isSelected ? Colors.white : Colors.pink.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Next"),
              onPressed: selectedMood.isEmpty
                  ? null
                  : () {
                      widget.quizData.mood = selectedMood.join(', ');
                      context.go('/time', extra: widget.quizData);
                    },
            ),
          ],
        ),
      ),
    );
  }
}

