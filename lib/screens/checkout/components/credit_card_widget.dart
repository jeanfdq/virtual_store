import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:virtual_store/components/hidden_keyboard.dart';
import 'package:virtual_store/screens/checkout/components/credit_card_back.dart';
import 'package:virtual_store/screens/checkout/components/credit_card_front.dart';

class CreditCardWidget extends StatelessWidget {
  CreditCardWidget({super.key});

  final GlobalKey<FlipCardState> flipcardKey = GlobalKey<FlipCardState>();

  final FocusNode creditCardNumberFocus = FocusNode();
  final FocusNode creditCardValidateFocus = FocusNode();
  final FocusNode creditCardNameFocus = FocusNode();
  final FocusNode creditCardCVVFocus = FocusNode();

  // Cria botoes na barra de cima do teclado do iOS
  KeyboardActionsConfig _buildKeyboardConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardBarColor: Colors.grey.shade300,
      actions: [
        KeyboardActionsItem(
          focusNode: creditCardNumberFocus,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => creditCardValidateFocus.requestFocus(),
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.next_plan),
                ),
              );
            }
          ],
        ),
        KeyboardActionsItem(
          focusNode: creditCardValidateFocus,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () => creditCardNameFocus.requestFocus(),
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.next_plan),
                ),
              );
            }
          ],
        ),
        KeyboardActionsItem(
          focusNode: creditCardNameFocus,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () {
                  flipcardKey.currentState?.toggleCard();
                  creditCardCVVFocus.requestFocus();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.next_plan),
                ),
              );
            }
          ],
        ),
        KeyboardActionsItem(
          focusNode: creditCardCVVFocus,
          toolbarButtons: [
            (node) {
              return GestureDetector(
                onTap: () {
                  hiddenKeyboard();
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.next_plan),
                ),
              );
            }
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildKeyboardConfig(context),
      autoScroll: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FlipCard(
            key: flipcardKey,
            direction: FlipDirection.HORIZONTAL,
            flipOnTouch: false,
            front: CreditCardFront(
              creditCardNumberFocus: creditCardNumberFocus,
              creditCardValidateFocus: creditCardValidateFocus,
              creditCardNameFocus: creditCardNameFocus,
              finishedFront: () {
                flipcardKey.currentState?.toggleCard();
                creditCardCVVFocus.requestFocus();
              },
            ),
            back: CreditCardBack(creditCardCVVFocus: creditCardCVVFocus),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                flipcardKey.currentState?.toggleCard();
              },
              icon: const Icon(Icons.forward))
        ],
      ),
    );
  }
}
