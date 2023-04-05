import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CreditCardTextField extends StatelessWidget {
  const CreditCardTextField({
    Key? key,
    required this.title,
    this.maskField,
    required this.hint,
    required this.keyboardType,
    this.maxLenght,
    required this.validator,
    this.textAlign,
    this.textColor,
    this.focusNode,
    this.onSubmited,
  }) : super(key: key);

  final String? title;
  final String? maskField;
  final String hint;
  final TextInputType keyboardType;
  final int? maxLenght;
  final FormFieldValidator<String> validator;
  final TextAlign? textAlign;
  final Color? textColor;
  final FocusNode? focusNode;
  final Function(String)? onSubmited;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? inputFormatter = [];

    if (maskField != null && keyboardType == TextInputType.number) {
      inputFormatter.add(FilteringTextInputFormatter.digitsOnly);
      inputFormatter.add(MaskTextInputFormatter(
          mask: maskField, type: MaskAutoCompletionType.lazy));
    }

    return FormField<String>(
        validator: validator,
        builder: (state) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    if (state.hasError)
                      Text(
                        '    ${state.errorText} ',
                        style: const TextStyle(
                            color: Colors.redAccent, fontSize: 8),
                      )
                  ],
                ),
                TextFormField(
                  keyboardType: keyboardType,
                  focusNode: focusNode,
                  onFieldSubmitted: onSubmited,
                  autocorrect: false,
                  enableSuggestions: false,
                  inputFormatters: inputFormatter,
                  maxLength: maxLenght,
                  textAlign: textAlign ?? TextAlign.start,
                  style: TextStyle(
                    color: textColor ?? Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 2),
                    counterText: "",
                    hintText: hint,
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  // Para modificar o estado do FormField senao o texto de erro nao some apos digitar corretamente
                  onChanged: (value) => state.didChange(value),
                ),
              ],
            ),
          );
        });
  }
}
