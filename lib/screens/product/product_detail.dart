import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/components/app_bar.dart';
import 'package:virtual_store/components/spacers.dart';
import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/product_cart.dart';
import 'package:virtual_store/screens/product/components/product_size_widget.dart';
import 'package:virtual_store/services/cart_manager.dart';
import 'package:virtual_store/services/products_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class ProductDetail extends StatelessWidget {
  const ProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: buildAppBar(context: context, title: product.name),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: product.images.map((e) => Image.network(e)).toList(),
              options: CarouselOptions(enlargeCenterPage: false, height: 300),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SpacerHeight.h10(),
                  const Text(
                    'a partir de',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    'R\$ ${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: context.theme.primaryColor),
                  ),
                  SpacerHeight.h20(),
                  const Text(
                    'Descrição',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SpacerHeight.h5(),
                  Text(
                    product.description.trim(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SpacerHeight.h10(),
                  const Text(
                    'Tamanhos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SpacerHeight.h5(),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: product.sizes
                        .map((size) => ProductSizeWidget(size: size))
                        .toList(),
                  ),
                  SpacerHeight.h15(),
                  Consumer<ProductsManager>(
                    builder: (_, productManager, __) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ElevatedButton(
                          onPressed: !productManager.sizeSelected
                              ? null
                              : () {
                                  final ProductCart productCart = ProductCart(
                                      productId: product.id,
                                      quantity: 1,
                                      size: productManager
                                          .productSizeSelected!.name,
                                      price: productManager
                                              .productSizeSelected?.price ??
                                          0,
                                      product: product,
                                      stock: productManager.getProductStock);

                                  context
                                      .read<CartManager>()
                                      .addProductCart(productCart);

                                  Navigator.pushNamed(
                                      context, RoutesNamed.cart.getRoutePath());
                                },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            backgroundColor:
                                MaterialStateProperty.resolveWith((state) {
                              if (state.contains(MaterialState.disabled)) {
                                return Colors.grey;
                              } else {}
                              return null;
                            }),
                          ),
                          child: const SizedBox(
                            height: 44,
                            child: Center(
                              child: Text(
                                'Adicionar no carrinho',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
