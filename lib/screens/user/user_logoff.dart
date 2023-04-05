import 'package:flutter/material.dart';
import 'package:virtual_store/components/app_bar.dart';
import 'package:virtual_store/components/lateral_menu.dart';

class UserLogoff extends StatelessWidget {
  const UserLogoff({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context: context, title: 'Log Out'),
      drawer: const LateralMenu(),
      body: Container(
        color: Colors.deepOrange,
      ),
    );
  }
}
