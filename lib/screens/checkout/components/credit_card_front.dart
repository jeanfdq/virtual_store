import 'package:flutter/material.dart';

import 'package:virtual_store/screens/checkout/components/credit_card_text_field.dart';

class CreditCardFront extends StatelessWidget {
  const CreditCardFront({
    Key? key,
    required this.creditCardNumberFocus,
    required this.creditCardValidateFocus,
    required this.creditCardNameFocus,
    this.finishedFront,
  }) : super(key: key);

  final FocusNode creditCardNumberFocus;
  final FocusNode creditCardValidateFocus;
  final FocusNode creditCardNameFocus;
  final VoidCallback? finishedFront;

  @override
  Widget build(BuildContext context) {
    return Card(
      // para que o card acompanhe o Radius do container8,

      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.blueGrey,
        ),
        height: 200,
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  CreditCardTextField(
                    title: 'Número do cartão',
                    maskField: '####-####-####-####',
                    hint: 'XXXX XXXX XXXX XXXX',
                    keyboardType: TextInputType.number,
                    maxLenght: 19,
                    focusNode: creditCardNumberFocus,
                    onSubmited: (_) => creditCardNumberFocus.nextFocus(),
                    validator: (value) {
                      if (value != null) {
                        if (value.length != 19) {
                          return 'inválido!';
                        }
                      } else {
                        return 'inválido!';
                      }
                      return null;
                    },
                  ),
                  CreditCardTextField(
                    title: 'Validade',
                    maskField: '##/##',
                    hint: '12/20',
                    keyboardType: TextInputType.number,
                    maxLenght: 5,
                    focusNode: creditCardValidateFocus,
                    onSubmited: (p0) {},
                    validator: (value) {
                      if (value != null) {
                        if (value.length != 5) {
                          return 'inválido';
                        }
                      } else {
                        return 'inválido';
                      }
                      return null;
                    },
                  ),
                  CreditCardTextField(
                    title: 'Titular',
                    hint: 'Nome completo',
                    keyboardType: TextInputType.name,
                    focusNode: creditCardNameFocus,
                    onSubmited: (_) => finishedFront,
                    validator: (value) {
                      if (value != null) {
                        if (value.isEmpty || value.length <= 3) {
                          return 'inváldio.';
                        }
                      } else {
                        return 'inválido';
                      }
                      return null;
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
