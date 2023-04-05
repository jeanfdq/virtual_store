import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:virtual_store/utils/validations/validator_form_fields.dart';

class CustomTextFieldRounded extends StatelessWidget
    with ValidationsFormFields {
  const CustomTextFieldRounded(
      {super.key,
      required this.controller,
      this.keyboard = TextInputType.text,
      this.icon,
      this.iconColor,
      required this.hintText,
      this.hintTextColor,
      this.backgroundColor,
      this.backgroundWithOpacity = false,
      this.isSecurity = false,
      this.maxLenght,
      required this.validator,
      this.mask,
      this.onSaved});

  final TextEditingController controller;
  final TextInputType keyboard;
  final IconData? icon;
  final Color? iconColor;
  final String hintText;
  final Color? hintTextColor;
  final Color? backgroundColor;
  final bool backgroundWithOpacity;
  final bool isSecurity;
  final int? maxLenght;
  final String? Function(String?) validator;
  final String? mask;
  final Function(String?)? onSaved;

  @override
  Widget build(BuildContext context) {
    final formatter = MaskTextInputFormatter(mask: mask);

    return TextFormField(
      inputFormatters: [formatter],
      validator: validator,
      controller: controller,
      maxLength: maxLenght,
      obscureText: isSecurity,
      keyboardAppearance: Brightness.light,
      keyboardType: keyboard,
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: iconColor,
        ),
        hintText: hintText.trim(),
        hintStyle: TextStyle(color: hintTextColor),
        filled: true,
        fillColor:
            backgroundColor?.withOpacity(backgroundWithOpacity ? 0.4 : 1),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(26)),
          borderSide: BorderSide(
            width: 0,
            color: backgroundColor ?? Colors.transparent,
          ),
        ),
      ),
      onSaved: onSaved,
    );
  }
}
