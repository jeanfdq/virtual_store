import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:virtual_store/models/store.dart';
import 'package:virtual_store/utils/extensions/mask_cellphone_ext.dart';

class StoreDataForm extends StatelessWidget {
  const StoreDataForm({
    Key? key,
    required this.store,
  }) : super(key: key);

  final Store store;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 18),
      child: Column(
        children: [
          TextFormField(
            initialValue: store.storeName,
            keyboardType: TextInputType.name,
            validator: (value) {
              if (value != null) {
                if (value.isEmpty || value.length <= 3) {
                  return 'Nome da Loja inválido!';
                }
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: 'Informe o nome da loja',
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onSaved: (newValue) => store.storeName = newValue ?? '',
          ),
          TextFormField(
            initialValue: store.storePhoneNumber,
            keyboardType: TextInputType.number,
            inputFormatters: [MaskTextInputFormatter().cellphoneMask()],
            validator: (value) {
              if (value != null) {
                if (value.isEmpty || value.length <= 10) {
                  return 'Telefone da Loja inválido!';
                }
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: '(99)99999-9999',
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            onSaved: (newValue) => store.storePhoneNumber = newValue ?? '',
          ),
        ],
      ),
    );
  }
}
