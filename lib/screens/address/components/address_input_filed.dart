import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:virtual_store/models/address.dart';
import 'package:virtual_store/services/cart_manager.dart';

class AddressInputField extends StatelessWidget {
  const AddressInputField({
    Key? key,
    this.address,
  }) : super(key: key);

  final Address? address;

  String? emptyValidator(String text) =>
      text.isEmpty ? 'Campo obrigatório' : null;

  @override
  Widget build(BuildContext context) {
    if (address == null) {
      return Container();
    } else {
      final deliveryPrice = context.watch<CartManager>().deliveryPrice;
      if (deliveryPrice <= 0) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              autocorrect: false,
              initialValue: address?.logradouro,
              decoration: const InputDecoration(
                labelText: 'Rua/Avenida',
                hintText: 'Rua/Avenida',
                isDense: true,
              ),
              validator: (value) => emptyValidator(value ?? ''),
              onSaved: (newValue) =>
                  address?.logradouro = newValue?.trim() ?? '',
            ),
            Row(
              children: [
                Expanded(
                  flex: 25,
                  child: TextFormField(
                    autocorrect: false,
                    initialValue: '',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: const InputDecoration(
                      labelText: 'Número',
                      hintText: 'Número',
                      isDense: true,
                    ),
                    validator: (value) => emptyValidator(value ?? ''),
                    onSaved: (newValue) =>
                        address?.numero = newValue?.trim() ?? '',
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                Expanded(
                  flex: 70,
                  child: TextFormField(
                    autocorrect: false,
                    initialValue: address?.complemento,
                    decoration: const InputDecoration(
                      labelText: 'Complemento',
                      hintText: 'Complemento',
                      isDense: true,
                    ),
                    onSaved: (newValue) => address?.complemento = newValue,
                  ),
                ),
              ],
            ),
            TextFormField(
              autocorrect: false,
              initialValue: address?.bairro,
              decoration: const InputDecoration(
                labelText: 'Bairro',
                hintText: 'Bairro',
                isDense: true,
              ),
              validator: (value) => emptyValidator(value ?? ''),
              onSaved: (newValue) => address?.bairro = newValue ?? '',
            ),
            Row(
              children: [
                Expanded(
                  flex: 85,
                  child: TextFormField(
                    enabled: false,
                    autocorrect: false,
                    initialValue: address?.cidade.nome,
                    decoration: const InputDecoration(
                      labelText: 'Cidade',
                      hintText: 'Cidade',
                      isDense: true,
                    ),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
                Expanded(
                  flex: 10,
                  child: TextFormField(
                    enabled: false,
                    autocorrect: false,
                    initialValue: address?.estado.sigla,
                    decoration: const InputDecoration(
                      labelText: 'UF',
                      hintText: 'UF',
                      isDense: true,
                    ),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (Form.of(context).validate()) {
                  Form.of(context).save();

                  final lat = double.tryParse(address?.latitude ?? '0') ?? 0.0;
                  final long =
                      double.tryParse(address?.longitude ?? '0') ?? 0.0;

                  context.read<CartManager>().setAddress = address;
                  context.read<CartManager>().calculateDelivery(lat, long);
                }
              },
              child: const Text('Calcular frete'),
            ),
          ],
        );
      } else {
        return Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12),
          child: Text(
            '${address?.logradouro}, ${address?.numero} - ${address?.bairro}\n${address?.cidade.nome} - ${address?.estado.sigla}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }
    }
  }
}
