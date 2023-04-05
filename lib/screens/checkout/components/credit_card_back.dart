import 'package:flutter/material.dart';

import 'package:virtual_store/screens/checkout/components/credit_card_text_field.dart';

class CreditCardBack extends StatelessWidget {
  const CreditCardBack({
    Key? key,
    required this.creditCardCVVFocus,
  }) : super(key: key);

  final FocusNode creditCardCVVFocus;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(
              16)), // para que o card acompanhe o Radius do container
      elevation: 8,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey,
        ),
        height: 200,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.black87,
              height: 44,
            ),
            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    margin: const EdgeInsets.only(left: 16),
                    color: Colors.white60,
                    child: CreditCardTextField(
                        title: null,
                        hint: 'CVV',
                        keyboardType: TextInputType.number,
                        maxLenght: 3,
                        textAlign: TextAlign.end,
                        textColor: Colors.black,
                        focusNode: creditCardCVVFocus,
                        validator: (value) {
                          if (value != null) {
                            if (value.length != 3) {
                              return 'CVV inválido';
                            }
                          } else {
                            return 'CVV inválido';
                          }
                          return null;
                        }),
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
