import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:virtual_store/utils/constants.dart';

Hero logoAnimated() {
  return Hero(
    tag: kLogoAnimated,
    child: Lottie.asset(kLogoAnimated),
  );
}
