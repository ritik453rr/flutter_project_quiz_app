import 'package:flutter/material.dart';
import 'package:quiz/screens/dashboard_screen.dart';
import 'package:quiz/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isloggedIn = false;
  void getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isloggedIn = prefs.getBool(LoginScreenState.isLoggedInKey);
    });
  }

  @override
  void initState() {
    getLoginStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: isloggedIn == true ? const DashboardScreen() : const LoginScreen(),
    );
  }
}
