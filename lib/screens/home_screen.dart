import 'package:flutter/material.dart';
import 'package:quiz/screens/login_screen.dart';
import 'package:quiz/screens/signup_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.09, horizontal: screenWidth * 0.025),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                        fontSize: screenHeight * 0.055,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  //Welcome Image
                  Container(
                    height: screenHeight * 0.33,
                    width: screenHeight * 0.33,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/welcome.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.1,
                  ),
                  //Login Button
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    height: screenHeight * 0.07,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: screenHeight * 0.03,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                  //Sign up button
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    height: screenHeight * 0.07,
                    minWidth: double.infinity,
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: screenHeight * 0.03,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
