import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/models/product_cart.dart';
import 'package:virtual_store/services/cart_manager.dart';

class ItemCart extends StatelessWidget {
  const ItemCart({super.key, required this.productCart});

  final ProductCart productCart;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.read<CartManager>();
    cartManager.selectedProductCart = productCart;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: Image.network(productCart.product.images.first),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  children: [
                    const Text(
                      'product.name',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Tamanho: ${productCart.size}',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                    Text(
                      'R\$ ${productCart.itemPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: SizedBox(
                width: 44,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: cartManager.hasStock(productCart.quantity)
                            ? () {
                                cartManager.addProductCart(productCart);
                              }
                            : null,
                        icon: const Icon(Icons.add)),
                    Text(
                      productCart.quantity.toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        onPressed: () {
                          context
                              .read<CartManager>()
                              .removeProductCart(productCart);
                        },
                        icon: const Icon(Icons.minimize)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
