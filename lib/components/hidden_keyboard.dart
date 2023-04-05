import 'package:flutter/material.dart';

void hiddenKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
