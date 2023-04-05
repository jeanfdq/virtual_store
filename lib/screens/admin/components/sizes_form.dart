import 'package:flutter/material.dart';
import 'package:virtual_store/components/custom_icon_button.dart';

import 'package:virtual_store/models/product.dart';
import 'package:virtual_store/models/product_size.dart';
import 'package:virtual_store/screens/admin/components/edit_item_size.dart';

class FormSizes extends StatelessWidget {
  const FormSizes({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FormField<List<ProductSize>>(
          initialValue: List.from(product.sizes),
          validator: (sizes) {
            if (sizes != null && sizes.isEmpty) {
              return 'Informe ao menos um tamanho';
            }
            return null;
          },
          builder: (state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tamanhos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    CustomIconButton(
                      iconData: Icons.add,
                      color: Colors.black,
                      onTap: () {
                        state.value
                            ?.add(ProductSize(name: '', price: 0, stock: 0));
                        state.didChange(state.value);
                      },
                    ),
                  ],
                ),
                Column(
                  children: state.value?.map((size) {
                        return EditItemSize(
                          size: size,
                          onRemove: () {
                            state.value?.remove(size);
                            state.didChange(state.value);
                          },
                        );
                      }).toList() ??
                      [],
                ),
                if (state.hasError)
                  Container(
                    alignment: Alignment.centerLeft,
                    margin:
                        const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                    child: Text(
                      state.errorText ?? '',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
              ],
            );
          },
          onSaved: (newValue) => product.sizes = newValue ?? [],
        ),
      ],
    );
  }
}
