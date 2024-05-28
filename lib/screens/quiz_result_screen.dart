import 'package:flutter/material.dart';
import 'package:quiz/question_list.dart';
import 'package:quiz/screens/dashboard_screen.dart';

class QuizResultScreen extends StatefulWidget {
  final int score;
  const QuizResultScreen({required this.score, super.key});

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.score >= (questions.length) * 0.6) ...[
                const Column(
                  children: [
                    Text(
                      "CONGRATULATIONS\uD83C\uDF89",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "you are passed!!",
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                )
              ] else ...[
                const FittedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      children: [
                        Text(
                          "SORRY\uD83D\uDE25 YOU ARE FAILED",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 35.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "try again!!",
                          style: TextStyle(fontSize: 24),
                        )
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(
                height: 130.0,
              ),
              const Text(
                "Your score is:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                "${widget.score}/${questions.length}",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 80.0,
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const DashboardScreen()),
                        (route) => false);
                  },
                  child: const Text(
                    'Back to Dashboard',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
