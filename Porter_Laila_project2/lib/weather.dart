import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quiz_data.dart';

//user selects weather conditions
//tapable cards allow multi selection
//moves to mood page 

class Weather extends StatefulWidget {
  final DinnerQuizData quizData;

  const Weather({super.key, required this.quizData});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  final List<String> conditions = [
    'Sunny',
    'Rainy',
    'Snowy',
    'Cloudy',
    'Windy',
    'Stormy',
    'Foggy',
    'Hot',
    'Cold'
  ];

  final Set<String> selectedConditions = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("What's the weather like?"),
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
              "Select all that apply",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.deepOrange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: conditions.map((c) {
                  final isSelected = selectedConditions.contains(c);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected
                            ? selectedConditions.remove(c)
                            : selectedConditions.add(c);
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blueAccent.withOpacity(0.8)
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
                          color:
                              isSelected ? Colors.blue : Colors.blue.shade200,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        c,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.blue.shade700,
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
              onPressed: selectedConditions.isEmpty
                  ? null
                  : () {
                      widget.quizData.weather =
                          selectedConditions.join(', ');
                      context.go('/mood', extra: widget.quizData);
                    },
            ),
          ],
        ),
      ),
    );
  }
}


