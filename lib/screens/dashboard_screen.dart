import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quiz/model/user_model.dart';
import 'package:quiz/screens/home_screen.dart';
import 'package:quiz/screens/login_screen.dart';
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

//get and store all the user in local user list and then find logged in user data
  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(LoginScreenState.userId);
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

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoard Screen'),
        actions: [
          //Logout button
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool(LoginScreenState.isLoggedInKey, false);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [
          Text(userName),
          Text(userEmail),
          Text(userMobile),
        ],
      ),
    );
  }
}
