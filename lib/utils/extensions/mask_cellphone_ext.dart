import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

extension MaskFormatter on MaskTextInputFormatter {
  MaskTextInputFormatter cellphoneMask() {
    return MaskTextInputFormatter(
        mask: '(##) #####-####',
        filter: {"#": RegExp(r'[0-9]')},
        type: MaskAutoCompletionType.lazy);
  }
}
