import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/screens/cart/components/cart_total.dart';
import 'package:virtual_store/screens/checkout/components/credit_card_widget.dart';
import 'package:virtual_store/screens/sales/my_orders.dart';
import 'package:virtual_store/services/cart_manager.dart';
import 'package:virtual_store/services/sales_order_manager.dart';
import 'package:virtual_store/utils/constants.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pagamento'),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CreditCardWidget(),
              ),
              CartTotal(
                textButton: 'Finalizar pedido',
                onNextStep: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    if (context.mounted) {
                      await context
                          .read<SalesOrderManager>()
                          .sendOrder(context.read<CartManager>());
                    }
                    Get.defaultDialog(
                      backgroundColor: Colors.transparent,
                      barrierDismissible: false,
                      title: '',
                      content: SizedBox(
                        height: 420,
                        width: 420,
                        child: Lottie.asset(kCheckedAnimated),
                      ),
                    );
                    await Future.delayed(const Duration(seconds: 2));
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      Get.offAll(() => const MyOrders());
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
