import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/services/cart_manager.dart';

class CartTotal extends StatelessWidget {
  const CartTotal({
    Key? key,
    required this.textButton,
    required this.onNextStep,
  }) : super(key: key);

  final String textButton;
  final VoidCallback onNextStep;

  @override
  Widget build(BuildContext context) {
    const textStyleSubtotal =
        TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    return Consumer<CartManager>(builder: (_, cartManager, __) {
      return Card(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: SizedBox(
            height: 190,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Resumo do Pedido',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Subtotal:',
                      style: textStyleSubtotal,
                    ),
                    Text(
                      'R\$ ${cartManager.sumTotalProducts.toStringAsFixed(2)}',
                      style: textStyleSubtotal,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Entrega:',
                      style: textStyleSubtotal,
                    ),
                    Text(
                      'R\$ ${cartManager.deliveryPrice.toStringAsFixed(2)}',
                      style: textStyleSubtotal,
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: textStyleSubtotal,
                    ),
                    Text(
                      'R\$ ${cartManager.sumTotal.toStringAsFixed(2)}',
                      style: textStyleSubtotal.copyWith(
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: cartManager.sumTotalQuantityProducts > 0
                      ? onNextStep
                      : null,
                  child: Text(textButton, style: textStyleSubtotal),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
