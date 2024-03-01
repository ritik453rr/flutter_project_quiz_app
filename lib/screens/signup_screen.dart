import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool passwordVisible = false;
  bool confirmPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.05, horizontal: screenWidth * 0.025),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Sign Up',
                    style: TextStyle(
                        fontSize: screenHeight * 0.04,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    'Create an account',
                    style: TextStyle(
                        fontSize: screenHeight * 0.029, color: Colors.grey),
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        //Full Name
                        TextFormField(
                          controller: nameController,
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter name';
                            } else if (RegExp(
                                    r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                                .hasMatch(value)) {
                              return 'enter a valid name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            labelStyle: const TextStyle(color: Colors.black),
                            //enabledBorder Full Name
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //focusedBorder full name
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //errorBorder fullname
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                            //focusedErrorBorder fullname
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        //Email
                        TextFormField(
                          controller: emailController,
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter email';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return 'enter a valid email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.black),
                            //enabledBorder Email
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //focusedBorder Email
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //errorBorder Email
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                            //focusedErrorBorder Email
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        //Mobile
                        TextFormField(
                          controller: mobileController,
                          cursorColor: Colors.black,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter mobile';
                            } else if (!RegExp(r'^[0-9]{10}$')
                                .hasMatch(value)) {
                              return 'enter a valid number';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Mobile',
                            labelStyle: const TextStyle(color: Colors.black),
                            //enabledBorder Mobile
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //focusedBorder Mobile
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //errorBorder Mobile
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                            //focusedErrorBorder Mobile
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        //Password
                        TextFormField(
                          controller: passwordController,
                          cursorColor: Colors.black,
                          obscureText: !passwordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter password';
                            } else if (!RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(value)) {
                              return 'enter a strong password ';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                              icon: Icon(passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            //enabledBorder Password
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //focusedBorder Password
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //errorBorder Password
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                            //focusedErrorBorder Password
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.01,
                        ),
                        //Confirm Password
                        TextFormField(
                          controller: confirmPasswordController,
                          cursorColor: Colors.black,
                          obscureText: !confirmPasswordVisible,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'confirm password';
                            } else if (confirmPasswordController.text !=
                                passwordController.text) {
                              return "password doesn't match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            labelStyle: const TextStyle(color: Colors.black),
                            suffixIcon: IconButton(
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  confirmPasswordVisible =
                                      !confirmPasswordVisible;
                                });
                              },
                              icon: Icon(confirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            //enabledBorder Confirm Password
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //focusedBorder Confirm Password
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            //errorBorder Confirm Password
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                            //focusedErrorBorder Confirm Password
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.red, width: 1.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: screenHeight * 0.015,
                        ),
                        MaterialButton(
                          height: screenHeight * 0.07,
                          minWidth: screenWidth,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {}
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.blue,
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: screenHeight * 0.03,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
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
