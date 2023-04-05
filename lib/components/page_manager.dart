import 'package:flutter/material.dart';

class PageManager {
  final PageController _pageController;

  PageManager(this._pageController);

  int currentPage = 0;

  void goToPage(int page) {
    currentPage = page;
    if (page != _pageController.page) {
      _pageController.jumpToPage(page);
    }
  }
}
