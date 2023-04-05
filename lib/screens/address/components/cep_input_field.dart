import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'package:virtual_store/components/spacers.dart';
import 'package:virtual_store/services/cart_manager.dart';

class CepInputFiled extends StatelessWidget {
  CepInputFiled({
    Key? key,
  }) : super(key: key);

  final _cepTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: _cepTextController,
          decoration: InputDecoration(
            suffixIcon: InkWell(
                onTap: () {
                  _cepTextController.clear();
                  context.read<CartManager>().removeAddress();
                },
                child: const Icon(Icons.clear_sharp)),
            isDense: true,
            labelText: 'Cep',
            hintText: '99999999',
            counter: null,
            counterText: "",
          ),
          maxLength: 8,
          keyboardType: TextInputType.number,
          inputFormatters: [
            // para permitir apenas numeros sem caracteres especiais
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (cep) {
            if (cep == null || cep.isEmpty || cep.length != 8) {
              return 'Cep informado inválido.';
            } else {
              return null;
            }
          },
        ),
        SpacerHeight.h5(),
        ElevatedButton(
          onPressed: () async {
            if (Form.of(context).validate()) {
              try {
                if (context.mounted) {
                  await context
                      .read<CartManager>()
                      .getAddressFromCep(_cepTextController.text);
                }
              } catch (e) {
                if (context.mounted) {
                  context.read<CartManager>().removeAddress();
                }
                Get.snackbar(
                  '',
                  '',
                  titleText: const Text(
                    'Busca por Cep',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  messageText: Text(
                    '$e',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  icon: const Icon(Icons.warning, color: Colors.red),
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.yellow,
                );
              }
            } else {}
          },
          child: Consumer<CartManager>(
            builder: (_, cartManager, __) {
              return cartManager.isLoading
                  ? const LinearProgressIndicator()
                  : const Text(
                      'Buscar Cep',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    );
            },
          ),
        ),
      ],
    );
  }
}
