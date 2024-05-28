import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz/model/user_model.dart';
import 'package:quiz/screens/home_screen.dart';
import 'package:quiz/screens/login_screen.dart';
import 'package:quiz/screens/quiz_home_screen.dart';
import 'package:quiz/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<UserModel> localUserList = [];

  String userName = '';
  String userEmail = '';
  String userMobile = '';

  String? userId = '';

  int userScore = 0;

//function to get and store all the user in local user list and then find logged in user data
  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //getting user Id
    userId = prefs.getString(LoginScreenState.currentUserId);
    List<String>? globalUsers =
        prefs.getStringList(SignUpScreenState.globalUserListKey);
    if (globalUsers != null) {
      localUserList = [];
      for (String userString in globalUsers) {
        Map<String, dynamic> userData = json.decode(userString);
        UserModel user = UserModel.fromJson(userData);
        localUserList.add(user);
      }
    }

    //searching user by userrId......
    for (UserModel user in localUserList) {
      if (user.email == userId) {
        setState(() {
          userName = user.name;
          userEmail = user.email;
          userMobile = user.mobile;
        });
        break;
      }
    }
  }

  Future<void> getScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userScore = prefs.getInt("$userId.score") ?? 0;
    });
  }

  @override
  void initState() {
    getUserData();
    getScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          "Dashboard",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        actions: [
          //Logout button
          IconButton(
            color: Colors.white,
            onPressed: () {
              //Alert Dialogue
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Alert!'),
                      content: const Text('Are sure to logout?'),
                      actions: [
                        //Yes button......
                        TextButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool(
                                LoginScreenState.isLoggedInKey, false);
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                                (route) => false);
                          },
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'No',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 180,
                width: 500,
                //Card.............
                child: Card(
                  color: Colors.grey.shade100,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //User Name
                        Text(
                          userName,
                          style: const TextStyle(
                              fontSize: 35, fontWeight: FontWeight.w500),
                        ),
                        //user Email....
                        Row(
                          children: [
                            const Icon(
                              Icons.email,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(userEmail,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black54)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        //User Mobile
                        Row(
                          children: [
                            const Icon(
                              Icons.phone,
                              color: Colors.black54,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(userMobile,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.black54)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              //Current Score
              SizedBox(
                width: 500,
                height: 100,
                child: Card(
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      "Your Current Score is:$userScore",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 150,
              ),
              //Start Quiz Button
              SizedBox(
                width: 350,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const QuizHomeScreen(),
                        ),
                        (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text(
                    'Start Quiz',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
