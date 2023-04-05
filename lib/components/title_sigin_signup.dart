import 'package:flutter/material.dart';

class TitleSignInSignUp extends StatelessWidget {
  const TitleSignInSignUp({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),
    );
  }
}
