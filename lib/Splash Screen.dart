import 'dart:async';

import 'package:flutter/material.dart';

import 'Theme/color.dart';
import 'app/screen/intro/intro.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}


class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 6),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => Intro())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.Gradient1st_Color,
              AppColors.Gradient2nd_Color,
            ],
          ),
        ),
        child: Center(
          child: Container(
              child: Center(child: Image.asset("assets/Splash_LOGO.png"))),
        ),
      ),
    );
  }
}