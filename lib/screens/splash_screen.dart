import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:social_app/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const screenRoute = '/SplashScreen';

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, LoginScreen.screenRoute);
    });
    return Scaffold(
      body: Center(
          child: Lottie.asset(
        'assets/images/social2.json',
      )),
    );
  }
}
