import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

enum SnackbarType { info, error, succes }

extension ShowSnackbar on BuildContext {
  void showSnackBar({required SnackbarType type, required String message}) {
    if (type == SnackbarType.error) {
      showTopSnackBar(
        Overlay.of(this),
        CustomSnackBar.error(message: message),
      );
    } else if (type == SnackbarType.info) {
      showTopSnackBar(
        Overlay.of(this),
        CustomSnackBar.info(message: message),
      );
    } else {
      showTopSnackBar(
        Overlay.of(this),
        CustomSnackBar.success(message: message),
      );
    }
  }
}
