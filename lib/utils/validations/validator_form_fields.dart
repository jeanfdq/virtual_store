import 'package:virtual_store/utils/extensions/string_ext.dart';

mixin ValidationsFormFields {
  String? isNotEmpty(String? value, [String? message]) {
    if (value!.isEmpty) return message ?? 'Este campo é obrigatório.';
    return null;
  }

  String? isValidEmail(String? value, [String? message]) {
    if (!value!.isValidEmail()) return message ?? 'Informe um e-mail válido.';
    return null;
  }

  String? hasQuantityChars(String? value, int quantityChar, [String? message]) {
    if (value!.length < quantityChar) {
      return message ??
          'Você deve informar pelo menos $quantityChar carateres.';
    }
    return null;
  }

  String? confirmedPasswordValid(String? value, String password) =>
      value?.trim() != password.trim()
          ? 'Confirmação diferente da senha informada.'
          : null;

  String? validators(List<String? Function()> validators) {
    for (final func in validators) {
      final validation = func();
      if (validation != null) return validation;
    }
    return null;
  }
}
