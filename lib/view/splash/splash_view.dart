import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movies_app/view/auth/login_view.dart';

class SplashView extends StatefulWidget {
  static const String routeName = 'splash-view';

  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 2),
          () {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/splash.png', fit: BoxFit.fill);
  }
}