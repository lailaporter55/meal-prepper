import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quiz_data.dart';

class Time extends StatefulWidget {
  final DinnerQuizData quizData;

  const Time({super.key, required this.quizData});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  final List<String> times = [
    '15 min',
    '30 min',
    '45 min',
    '1 hour',
    '1.5 hours',
    '2 hours',
    '3 hours',
  ];

  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("How long do you have to cook?"),
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
              "Choose your available cooking time",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.deepOrange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: times.map((time) {
                  final isSelected = selectedTime == time;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTime = time;
                        widget.quizData.time = time;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.deepOrangeAccent.withOpacity(0.8)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                        border: Border.all(
                          color: isSelected
                              ? Colors.deepOrange
                              : Colors.deepOrange.shade200,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        time,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.deepOrange.shade700,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
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
              onPressed: selectedTime == null
                  ? null
                  : () {
                      context.go('/meal', extra: widget.quizData);
                    },
            ),
          ],
        ),
      ),
    );
  }
}
