import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies_app/view/auth/widgets/custom_text_form_field.dart';

import '../../core/services/snackbar_service.dart';
import 'login_view.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isVisable = true;
  bool confirmPasswordVisable = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: theme.primaryColor,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/movie_cover.png',
                        height: 200,
                        width: 200,
                      ),
                      const SizedBox(height: 36),
                      CustomTextFormField(
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xffACACAC),
                            fontWeight: FontWeight.w500),
                        inputStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: emailController,
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
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xffACACAC),
                            fontWeight: FontWeight.w500),
                        inputStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You must enter your Name";
                          }
                          return null;
                        },
                        hintText: "Name",
                      ),
                      const SizedBox(height: 18),
                      CustomTextFormField(
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xffACACAC),
                            fontWeight: FontWeight.w500),
                        inputStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: isVisable,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You must enter your password";
                          }
                          var regularExpression = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                          if (!regularExpression.hasMatch(value)) {
                            return "Invalid Password";
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
                              style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      CustomTextFormField(
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xffACACAC),
                            fontWeight: FontWeight.w500),
                        inputStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        controller: confirmPasswordController,
                        hintText: "Confirm Password",
                        obscureText: confirmPasswordVisable,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "You must enter your password";
                          }
                          if (value != passwordController.text) {
                            return "Password doesn't Match as above";
                          }
                          return null;
                        },
                        suffixIcon: GestureDetector(
                          onTap: () {
                            confirmPasswordVisable =
                            !confirmPasswordVisable;
                            setState(() {});
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              confirmPasswordVisable == true
                                  ? "View"
                                  : "Hide",
                              style: TextStyle(
                                  color: theme.primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Row(
                        children: [
                          Text(
                            "By selecting agree and continue below,",
                            style: theme.textTheme.labelMedium!.copyWith(
                                color: Colors.white, fontSize: 12),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "I agree to Terms of service and privacy policy",
                            style: theme.textTheme.labelMedium!.copyWith(
                                color: theme.primaryColor,
                                fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 23),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 60, vertical: 14),
                        ),
                        onPressed: () {
                          register();
                        },
                        child: Text("Agree and Continue",
                            style: theme.textTheme.bodySmall!.copyWith(
                                color: Colors.white, fontSize: 18)),
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

  void register() async {
    if (formKey.currentState!.validate()) {
      String name = nameController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        SnackBarService.showErrorMessage("Please Enter a valid email address");
        return;
      }
      if (password.isEmpty) {
        SnackBarService.showErrorMessage("Please Enter a valid password");
        return;
      }
      EasyLoading.show();
      try {
        UserCredential user = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await user.user!.updateDisplayName(name);
        EasyLoading.dismiss();
        SnackBarService.showSuccessMessage(
            "You have successfully created a new account");
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          EasyLoading.dismiss();
          SnackBarService.showErrorMessage(
              'The account already exists for that email.');
        }
      }
    }
  }
}