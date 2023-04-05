import 'package:flutter/material.dart';

AppBar buildAppBar(
    {required BuildContext context,
    required String title,
    List<Widget>? actions}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    elevation: 0,
    actions: actions,
  );
}
