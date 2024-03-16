import 'package:flutter/material.dart';
import 'package:quiz/question_list.dart';
import 'package:quiz/screens/dashboard_screen.dart';
import 'package:quiz/screens/login_screen.dart';
import 'package:quiz/screens/quiz_result_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizHomeScreen extends StatefulWidget {
  const QuizHomeScreen({super.key});

  @override
  State<QuizHomeScreen> createState() => _QuizHomeScreenState();
}

class _QuizHomeScreenState extends State<QuizHomeScreen> {
  //Declarations
  final PageController pageController = PageController(initialPage: 0);
  bool answerValue = false;
  int score = 0;
  List<int?> selectedIndexes = List<int?>.filled(questions.length, null);

  void scoreSaver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString(LoginScreenState.currentUserId);
    prefs.setInt('$userId.score', score);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Alert!'),
                      content: Text('Are you sure to cancel the quiz'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(),
                                ),
                                (route) => false);
                          },
                          child: const Text('yes'),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('no'))
                      ],
                    );
                  });
            },
            child: const Text(
              'cancel',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
        title: const Text(
          'Quiz',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: PageView.builder(
          itemCount: questions.length,
          controller: pageController,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            //Question Start.....
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                //Question Number.....
                Text(
                  "Question ${index + 1}/${questions.length}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                  ),
                ),
                //Divider............
                const Divider(
                  color: Colors.black,
                  height: 8.0,
                  thickness: 1.0,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                //Question....
                Text(
                  questions[index].question!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 26.0,
                  ),
                ),
                const SizedBox(
                  height: 35.0,
                ),
                for (int i = 0; i < questions[index].options!.length; i++) ...[
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor: selectedIndexes[index] == i
                              ? Colors.green
                              : Colors.blue,
                        ),
                        onPressed: () {
                          setState(() {
                            answerValue = questions[index]
                                .options!
                                .entries
                                .toList()[i]
                                .value;
                            selectedIndexes[index] = i;
                          });
                        },
                        child: Text(
                          questions[index].options!.keys.toList()[i],
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
                const SizedBox(
                  height: 50.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //Previous button.....
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () {
                        pageController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.linear);
                      },
                      child: const Text(
                        "Previous",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: index + 1 == questions.length ? 130 : 100,
                    ),
                    //Next Question/See Result button
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: index + 1 == questions.length
                          ? () {
                              if (selectedIndexes[index] != null) {
                                if (answerValue) {
                                  setState(
                                    () {
                                      score += 1;
                                    },
                                  );
                                }
                                scoreSaver();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          QuizResultScreen(score: score),
                                    ),
                                    (route) => false);
                              }
                            }
                          : () {
                              if (selectedIndexes[index] != null) {
                                if (answerValue) {
                                  setState(
                                    () {
                                      score += 1;
                                    },
                                  );
                                }

                                setState(() {
                                  answerValue = false;
                                });
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.ease);
                              }
                            },
                      child: Text(
                        index + 1 == questions.length
                            ? "See Result"
                            : "Next Question",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
