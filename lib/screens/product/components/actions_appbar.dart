import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/screens/product/components/search_dialog.dart';
import 'package:virtual_store/services/products_manager.dart';

List<Widget> actionsAppBar({required BuildContext context}) {
  return [
    Consumer<ProductsManager>(builder: (_, productManager, __) {
      return IconButton(
          onPressed: () {
            if (productManager.searchText.isEmpty) {
              showDialog<String>(
                  context: context,
                  builder: (_) => const SearchDialog()).then((searchText) {
                productManager.searchText = searchText ?? '';
              });
            } else {
              productManager.searchText = '';
            }
          },
          icon: Icon(productManager.searchText.isEmpty
              ? Icons.search
              : Icons.filter_alt_off));
    }),
  ];
}
