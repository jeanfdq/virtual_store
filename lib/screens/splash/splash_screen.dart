import 'package:flutter/material.dart';
import 'package:virtual_store/screens/splash/body_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodySplashScreen(),
    );
  }
}
