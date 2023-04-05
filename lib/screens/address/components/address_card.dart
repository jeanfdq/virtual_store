import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:virtual_store/screens/address/components/address_input_filed.dart';
import 'package:virtual_store/screens/address/components/cep_input_field.dart';
import 'package:virtual_store/screens/cart/components/cart_total.dart';
import 'package:virtual_store/screens/checkout/checkout_screen.dart';
import 'package:virtual_store/services/cart_manager.dart';
import 'package:virtual_store/services/user_account_manager.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CartManager>(
      builder: (context, cartmManager, cepInputField) {
        final address = cartmManager.getAddress;
        return Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Endereço de entrega',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      cepInputField!,
                      AddressInputField(address: address),
                    ],
                  ),
                ),
              ),
            ),
            if (cartmManager.deliveryPrice > 0)
              CartTotal(
                textButton: 'Seguir para o pagamento',
                onNextStep: () async {
                  final userAccount =
                      context.read<UserAccountmanager>().userData;
                  if (userAccount?.address == null) {
                    await Get.defaultDialog(
                      title: 'Endereço',
                      content: Text(
                          '${userAccount?.name}, deseja salvar esse endereço no seu cadastro?'),
                      onCancel: () {},
                      onConfirm: () async {
                        if (context.mounted && userAccount != null) {
                          userAccount.address =
                              context.read<CartManager>().getAddress;
                          await context
                              .read<UserAccountmanager>()
                              .updateUserAccount(userAccount);
                          Get.back();
                        }
                      },
                    );
                  }
                  Get.back();
                  Get.offAll(() => CheckoutScreen(), fullscreenDialog: true);
                },
              ),
          ],
        );
      },
      child: CepInputFiled(),
    );
  }
}
