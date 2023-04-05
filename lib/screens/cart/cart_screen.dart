import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/screens/address/address_screen.dart';
import 'package:virtual_store/screens/cart/components/cart_total.dart';
import 'package:virtual_store/screens/cart/components/item_cart.dart';
import 'package:virtual_store/services/cart_manager.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        centerTitle: true,
      ),
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          if (cartManager.listOfProductCart.isNotEmpty) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: cartManager.listOfProductCart
                        .map((productCart) => ItemCart(
                              productCart: productCart,
                            ))
                        .toList(),
                  ),
                  CartTotal(
                    textButton: 'Continuar para entrega',
                    onNextStep: () {
                      Get.to(() => const AddressScreen(),
                          fullscreenDialog: true);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Container(
              color: Colors.white,
              child: Center(
                child: Icon(
                  Icons.remove_shopping_cart,
                  size: 72,
                  color: Get.theme.primaryColor,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
