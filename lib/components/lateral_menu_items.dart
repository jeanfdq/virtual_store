import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/utils/constants.dart';

import 'page_manager.dart';

class BuildLateralMenuItems extends StatelessWidget {
  const BuildLateralMenuItems(
      {Key? key,
      required this.page,
      required this.icon,
      required this.title,
      this.action})
      : super(key: key);

  final LateralPageName page;
  final IconData icon;
  final String title;
  final VoidCallback? action;

  @override
  Widget build(BuildContext context) {
    final pageManager = context.watch<PageManager>();
    final primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        onTap: () {
          action == null
              ? pageManager.goToPage(page.getPageNumber())
              : action!();
        },
        leading: Icon(
          color: pageManager.currentPage == page.getPageNumber()
              ? primaryColor
              : Colors.black,
          icon,
          size: 38,
        ),
        title: Text(
          title.trim(),
          style: TextStyle(
            fontSize: 22,
            color: pageManager.currentPage == page.getPageNumber()
                ? primaryColor
                : Colors.black,
          ),
        ),
      ),
    );
  }
}
