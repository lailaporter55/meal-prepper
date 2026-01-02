import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quiz_data.dart';
//this screen allows user to select how much time they have avalible to cook 
//choices are in a list and are displayed on tapable cards
//time is saved to quiz data and the next screen is the meal page
class Time extends StatefulWidget {
  //receives quiz data from previous screens
  final DinnerQuizData quizData;

  const Time({super.key, required this.quizData});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  //list of time options
  final List<String> times = [
    'less than an hour',
    '1 hour',
    '1.5 hours',
    '2 hours',
    '3 hours',
    'More than 3 hours',
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
      //gradient bacckground
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
            //intro text
            Text(
              "Choose your available cooking time",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.deepOrange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            //time options
            Expanded(
              child: ListView(
                children: times.map((time) {
                  final isSelected = selectedTime == time;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTime = time;
                        //save selected time to quizData
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
            //next button is disabled until a time is selected
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
