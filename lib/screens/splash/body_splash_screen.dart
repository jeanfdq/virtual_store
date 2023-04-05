import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/services/user_account_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class BodySplashScreen extends StatefulWidget {
  const BodySplashScreen({super.key});

  @override
  State<BodySplashScreen> createState() => _BodySplashScreenState();
}

class _BodySplashScreenState extends State<BodySplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        // Function addPostFrameCallback é chamada após o término do build
        .then((_) => WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              // Para utilizar o Consumer do Provider no InitState
              final result =
                  Provider.of<UserAccountmanager>(context, listen: false);

              Navigator.pushReplacementNamed(
                  context,
                  result.currentUser != null
                      ? RoutesNamed.home.getRoutePath()
                      : RoutesNamed.login.getRoutePath());
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Hero(
            tag: kLogoAnimated,
            child: Lottie.asset(kLogoAnimated),
          ),
        ),
      ),
    );
  }
}
