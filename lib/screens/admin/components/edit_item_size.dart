import 'package:flutter/material.dart';

import 'package:virtual_store/components/custom_icon_button.dart';
import 'package:virtual_store/models/product_size.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize({
    Key? key,
    required this.size,
    required this.onRemove,
  }) : super(key: key);

  final ProductSize size;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 25, // é bacana utilizar o flex como se fosse em percentual
          child: TextFormField(
            initialValue: size.name,
            validator: (sizeName) {
              if (sizeName != null && sizeName.isEmpty) {
                return 'inválido';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'tamanho',
            ),
            onChanged: (value) => size.name = value,
            onSaved: (newValue) => size.name = newValue ?? '',
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            width: 5,
          ),
        ),
        Expanded(
          flex: 25,
          child: TextFormField(
            initialValue: size.stock.toString(),
            validator: (stock) {
              if (stock != null && stock.isEmpty) {
                return 'inválido';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'estoque',
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) => size.stock = int.tryParse(value) ?? 0,
            onSaved: (newValue) =>
                size.stock = int.tryParse(newValue ?? '0') ?? 0,
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            width: 5,
          ),
        ),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price.toStringAsFixed(2),
            validator: (price) {
              if (price != null && price.isEmpty) {
                return 'inválido';
              } else {
                return null;
              }
            },
            decoration: const InputDecoration(
              labelText: 'preço',
              prefix: Text(
                'R\$ ',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) => size.price = num.tryParse(value) ?? 0,
          ),
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: () {},
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: () {},
        ),
      ],
    );
  }
}
