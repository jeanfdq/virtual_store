import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/app_bar.dart';
import 'package:virtual_store/components/lateral_menu.dart';
import 'package:virtual_store/screens/product/components/actions_appbar.dart';
import 'package:virtual_store/screens/product/components/product_card.dart';
import 'package:virtual_store/services/products_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          context: context,
          title: 'Products',
          actions: actionsAppBar(context: context)),
      drawer: const LateralMenu(),
      body: Consumer<ProductsManager>(
        builder: (_, productsManager, __) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: productsManager.lengthListOfproducts,
              itemBuilder: (_, idx) {
                final product = productsManager.filteredlistOfProducts[idx];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, RoutesNamed.productDetail.getRoutePath(),
                        arguments: product),
                    child: ProductCard(
                      imageUrl: product.images[0],
                      productName: product.name,
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
