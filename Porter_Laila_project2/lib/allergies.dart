import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'quiz_data.dart';

//user selects what they are allergic to and what cannot be in the recipe 
//tapable cards allow multiple selections
//stored in quiz data and navigates to time page

class Allergies extends StatefulWidget {
  final DinnerQuizData quizData;

  const Allergies({super.key, required this.quizData});

  @override
  State<Allergies> createState() => _AllergiesState();
}

class _AllergiesState extends State<Allergies> {
  final List<String> allergies = [
    'Gluten',
    'Peanuts',
    'Dairy',
    'Shellfish',
    'Soy',
    'Eggs',
    'Tree Nuts',
    'Fish',
    'Meat',
    'None',
  ];

  final Set<String> selectedAllergies = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Your Allergies"),
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
              "Pick any allergies you need to avoid",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.deepOrange),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              //cards for allergies
              child: ListView(
                children: allergies.map((a) {
                  final isSelected = selectedAllergies.contains(a);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isSelected
                            ? selectedAllergies.remove(a)
                            : selectedAllergies.add(a);
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
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(0, 2),
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
                        a,
                        style: TextStyle(
                          color: isSelected
                              ? Colors.white
                              : Colors.deepOrange.shade700,
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
              onPressed: selectedAllergies.isEmpty
                  ? null
                  : () {
                      widget.quizData.allergies =
                          selectedAllergies.join(', ');
                      context.go('/weather', extra: widget.quizData);
                    },
            ),
          ],
        ),
      ),
    );
  }
}

