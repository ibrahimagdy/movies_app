import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app/view/auth/register_screen.dart';
import 'package:movies_app/view/auth/widgets/custom_text_form_field.dart';

import '../../core/services/snackbar_service.dart';
import '../../layout/home_layout.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisable = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 80),
                      Image.asset(
                        'assets/images/movie_cover.png',
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(height: 80),
                      CustomTextFormField(
                        controller: emailController,
                        inputStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xffACACAC),
                          fontWeight: FontWeight.w500,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You must enter your email";
                          }
                          var regularExpression = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (!regularExpression.hasMatch(value)) {
                            return "Invalid email";
                          }
                          return null;
                        },
                        hintText: "Email",
                      ),
                      const SizedBox(height: 18),
                      CustomTextFormField(
                        controller: passwordController,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xffACACAC),
                          fontWeight: FontWeight.w500,
                        ),
                        inputStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        hintText: "Password",
                        obscureText: isVisable,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You must enter your password";
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            isVisable = !isVisable;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              isVisable == true ? "View" : "Hide",
                              style: const TextStyle(
                                color: Color(0xffFFB224),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      GestureDetector(
                        onTap: (){
                          login();
                        },
                        child: Container(
                          height: 55,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: theme.primaryColor,
                          ),
                          child: const Center(
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account ?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                RegisterScreen.routeName,
                              );
                            },
                            child: const Text(
                              "Sign up",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        SnackBarService.showErrorMessage('Please enter a valid email address');
        return;
      }
      if (password.isEmpty) {
        SnackBarService.showErrorMessage('Please enter a valid password');
        return;
      }

      EasyLoading.show();
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage("successfully signed in");
        Navigator.pushReplacementNamed(
          context,
          HomeLayout.routeName,
        );
      } on FirebaseAuthException catch (e) {
        EasyLoading.dismiss();
        if (e.code == 'user-not-found') {
          SnackBarService.showErrorMessage('No user found for that email');
        } else if (e.code == 'wrong-password') {
          SnackBarService.showErrorMessage(
              'Wrong password provided for that user');
        } else {
          SnackBarService.showErrorMessage('Wrong email or password');
        }
      }
    }
  }
}
