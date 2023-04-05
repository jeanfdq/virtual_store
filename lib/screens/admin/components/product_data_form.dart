import 'package:flutter/material.dart';
import 'package:virtual_store/components/spacers.dart';

import 'package:virtual_store/models/product.dart';

class ProductDataForm extends StatelessWidget {
  const ProductDataForm({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          initialValue: product.name,
          validator: (name) {
            if (name != null) {
              if (name.isEmpty || name.length <= 2) {
                return 'Nome do produto inválido!';
              } else {
                return null;
              }
            } else {
              return 'Nome do produto inválido!';
            }
          },
          decoration: const InputDecoration(
              hintText: 'Informe o nome do produto', border: InputBorder.none),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          onSaved: (newValue) => product.name = newValue ?? '',
        ),
        const Text('a partir de'),
        Text(
          'R\$...',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        SpacerHeight.h10(),
        const Text(
          'Descrição:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        TextFormField(
          initialValue: product.description,
          validator: (description) {
            if (description != null) {
              if (description.isEmpty || description.length <= 5) {
                return 'Descrição do produto inválido!';
              } else {
                return null;
              }
            } else {
              return 'Descrição do produto inválido!';
            }
          },
          decoration: const InputDecoration(
              hintText: 'Informe a descrição do produto',
              border: InputBorder.none),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          maxLines: null,
          onSaved: (newValue) => product.description = newValue ?? '',
        ),
      ],
    );
  }
}
