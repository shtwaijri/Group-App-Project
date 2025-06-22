import 'dart:async';
import 'package:essert_coffee/features/auth/screens/login/login_screen.dart';
import 'package:essert_coffee/style/style_color.dart';
import 'package:flutter/material.dart';

/// Displays an animated logo.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to onboarding after 4 seconds
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: StyleColor.white,
      body: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(seconds: 2),
          tween: Tween(begin: 300, end: 375),
          builder: (BuildContext context, dynamic value, Widget? child) {
            return Image.asset('assets/images/1.png', width: value, height: value);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
