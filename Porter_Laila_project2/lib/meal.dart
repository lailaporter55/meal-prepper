import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'quiz_data.dart';

class MealData {
  final String name;
  final String category;
  final String instructions;
  final String image;

  MealData({
    required this.name,
    required this.category,
    required this.instructions,
    required this.image,
  });

  factory MealData.fromJson(Map<String,dynamic> json) {
    return MealData(
      name: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      instructions: json['strInstructions'] ?? '',
      image: json['strMealThumb'] ?? '',
    );
  }
}

class Meal extends StatefulWidget {
  final DinnerQuizData quizData;
  const Meal({super.key, required this.quizData});

  @override
  State<Meal> createState() => _MealState();
}

class _MealState extends State<Meal> {
  Future<MealData?> getMeal() async {
    final url = Uri.parse("https://www.themealdb.com/api/json/v1/1/random.php");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data["meals"] != null && data["meals"].isNotEmpty) {
        return MealData.fromJson(data["meals"][0]);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.quizData;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade50, Colors.orange.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: FutureBuilder<MealData?>(
            future: getMeal(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData) {
                return const Center(child: Text("No meal found :("));
              }

              final meal = snapshot.data!;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Your Dinner Suggestion", style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.deepOrange)),
                  const SizedBox(height: 10),
                  Card(
                    color: Colors.white70,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Allergies: ${q.allergies ?? 'None'}"),
                          Text("Mood: ${q.mood ?? 'N/A'}"),
                          Text("Weather: ${q.weather ?? 'N/A'}"),
                          Text("Time: ${q.time ?? 'N/A'} hours"),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(meal.name, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Image.network(meal.image, height: 200, fit: BoxFit.cover),
                  const SizedBox(height: 10),
                  Expanded(child: SingleChildScrollView(child: Text(meal.instructions))),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
