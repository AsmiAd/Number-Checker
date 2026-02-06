import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/settings_controller.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsController>(context);

    final topics = [
      {
        "title": "💡 Prime Number",
        "definition": "A prime number is only divisible by 1 and itself.",
        "example": "Examples: 2, 3, 5, 7, 11, 13..."
      },
      {
        "title": "🔢 Composite Number",
        "definition": "A composite number has more than two factors.",
        "example": "Examples: 4, 6, 8, 9, 10..."
      },
      {
        "title": "➕ Even & Odd Numbers",
        "definition": "Even numbers are divisible by 2; odd numbers are not.",
        "example": "Even: 2, 4, 6 | Odd: 1, 3, 5"
      },
      {
        "title": "🧮 Perfect Square",
        "definition": "A perfect square is the square of an integer.",
        "example": "Examples: 1, 4, 9, 16, 25..."
      },
      {
        "title": "🔲 Perfect Cube",
        "definition": "A perfect cube is the cube of an integer.",
        "example": "Examples: 1, 8, 27, 64, 125..."
      },
      {
        "title": "🔁 Palindrome Number",
        "definition": "A palindrome reads the same forwards and backwards.",
        "example": "Examples: 121, 1331, 12321..."
      },
      {
        "title": "💪 Armstrong Number",
        "definition": "Sum of digits raised to the number of digits equals the number.",
        "example": "Example: 153 = 1³ + 5³ + 3³"
      },
      {
        "title": "🌱 Fibonacci Number",
        "definition": "A number that appears in the Fibonacci sequence.",
        "example": "Examples: 0, 1, 1, 2, 3, 5, 8, 13..."
      },
      {
        "title": "📏 Absolute Value",
        "definition": "Distance from zero on the number line.",
        "example": "|−5| = 5"
      },
      {
        "title": "📐 Square-Free Number",
        "definition": "Not divisible by any perfect square other than 1.",
        "example": "Examples: 10, 13, 17..."
      },
      {
        "title": "📊 Harshad Number",
        "definition": "Divisible by the sum of its digits.",
        "example": "Example: 18 → 1+8=9, 18 ÷ 9 = 2"
      },
      {
        "title": "🔣 Roman Numeral",
        "definition": "Ancient Roman number system using letters.",
        "example": "Examples: I, V, X, L, C, D, M"
      },
      {
        "title": "🧮 Number Systems",
        "definition": "Binary, Octal, Hexadecimal representations of numbers.",
        "example": "Binary: 1010 | Octal: 12 | Hex: A"
      },
      {
        "title": "📚 Number in Words",
        "definition": "Spelling out the number in English words.",
        "example": "Example: 123 → One Hundred Twenty Three"
      },
      {
        "title": "🔠 ASCII Character",
        "definition": "ASCII assigns a character to each number (0–127).",
        "example": "Example: 65 = A, 97 = a"
      },
      {
        "title": "🧩 Factors",
        "definition": "Integers that divide the number with no remainder.",
        "example": "Factors of 12: 1, 2, 3, 4, 6, 12"
      },
      {
        "title": "📈 Exponential Form",
        "definition": "Scientific notation of the number.",
        "example": "Example: 123456 → 1.2346e+5"
      },
      {
        "title": "🔄 Reverse",
        "definition": "Digits of the number in reverse order.",
        "example": "Example: 321 → 123"
      },
      {
        "title": "🧮 Digit Operations",
        "definition": "Sum and product of the digits.",
        "example": "123 → Sum: 6 | Product: 6"
      },
    
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Learn About Numbers",
          style: TextStyle(
            fontSize: settings.fontSize,
            color: settings.fontColor,
          ),
        ),
        backgroundColor: const Color(0xFFADD8E6),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final topic = topics[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ExpansionTile(
              title: Text(
                topic["title"]!,
                style: TextStyle(
                  fontSize: settings.fontSize,
                  color: settings.fontColor,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic["definition"]!,
                        style: TextStyle(
                          fontSize: settings.fontSize,
                          color: settings.fontColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        topic["example"]!,
                        style: TextStyle(
                          fontSize: settings.fontSize,
                          color: settings.fontColor,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
