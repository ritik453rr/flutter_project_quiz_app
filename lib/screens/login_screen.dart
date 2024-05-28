import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz/model/user_model.dart';
import 'package:quiz/screens/dashboard_screen.dart';
import 'package:quiz/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController enteredEmailController = TextEditingController();
  TextEditingController enteredPasswordController = TextEditingController();
   //variable to control password visibility
  bool passwordVisible = false;

  List<UserModel> localUserList = [];

  static const isLoggedInKey = 'isLoggedInKey';
  static const currentUserId = 'userId';

  //save current user info function
  void loginInfoSaver(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(isLoggedInKey, true);
    prefs.setString(currentUserId, email);
  }

  //get all the global users and store in the local user list
  Future<void> getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? globalUsers =
        prefs.getStringList(SignUpScreenState.globalUserListKey);
    if (globalUsers != null) {
      localUserList = [];
      for (var userString in globalUsers) {
        Map<String, dynamic> userData = json.decode(userString);
        UserModel user = UserModel.fromJson(userData);
        localUserList.add(user);
      }
    }
  }

  bool userExist(
      {required String enteredEmail, required String enteredPassword}) {
    for (UserModel i in localUserList) {
      if (i.email == enteredEmail && i.password == enteredPassword) {
        loginInfoSaver(i.email);
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.05,
                  horizontal: screenWidth * 0.025),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                          fontSize: screenHeight * 0.05,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    Text(
                      'Login to your account',
                      style: TextStyle(
                          fontSize: screenHeight * 0.025,
                          color: Colors.black54),
                    ),
                    SizedBox(
                      height: screenHeight * 0.05,
                    ),
                    //Email....
                    TextFormField(
                      controller: enteredEmailController,
                      cursorColor: Colors.black,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'enter email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Colors.black),
                        //Email enabledBorder
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        //Email focusBorder
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        //Email Error Border
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.5),
                        ),
                        //Email Focus Error Border
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    //Password
                    TextFormField(
                      controller: enteredPasswordController,
                      cursorColor: Colors.black,
                      obscureText: !passwordVisible,
                      validator: (value) {
                        if (value == null || value == '') {
                          return 'enter password';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Colors.black,
                        ),
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                        //Enabled Border Password
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                        //Focused Border Password
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                        ),
                        //Error Border Password
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.5),
                        ),
                        //Focus Error border Password
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.red, width: 1.5),
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    //Login Button
                    MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          //getting all the users from sharedPreferences and store local list of users
                          await getUsers();
                          if (userExist(
                              enteredEmail: enteredEmailController.text,
                              enteredPassword:
                                  enteredPasswordController.text)) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardScreen()),
                                (route) => false);
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Warnig!'),
                                    content: Text('invalid email or password'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'ok',
                                          style: TextStyle(
                                              color: Colors.blueAccent),
                                        ),
                                      )
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      height: screenHeight * 0.065,
                      minWidth: screenWidth,
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontSize: screenHeight * 0.030,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.005,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Dont't have an account?",
                          style: TextStyle(
                              fontSize: screenHeight * 0.023,
                              fontWeight: FontWeight.w400),
                        ),
                        //Sign Up......
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: screenHeight * 0.024,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.01,
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.26,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/background.png"),
                            fit: BoxFit.fill),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
