import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension ShowDialogExtension on BuildContext {
  void showDialog({
    required String title,
    TextStyle? titleStyle,
    required String text,
    Widget? content,
    VoidCallback? onConfirm,
    String? onConfirmText,
    VoidCallback? onCancel,
    String? onCancelText,
    Future<bool> Function()? onPop,
  }) {
    Get.defaultDialog(
        barrierDismissible: onCancel == null,
        title: title,
        content: content,
        middleText: text,
        onConfirm: onConfirm,
        textConfirm: onConfirmText,
        onCancel: onCancel,
        textCancel: onCancelText,
        onWillPop: onPop);
  }
}
