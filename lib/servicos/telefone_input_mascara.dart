import 'package:flutter/services.dart';

class TelefoneInputMascara extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String formatted = '';
    if (digits.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    if (digits.length < 3) {
      // Até 2 dígitos → só coloca o que foi digitado
      formatted = digits;
    } else if (digits.length <= 6) {
      // Fixo até 6 dígitos após o DDD
      formatted =
          '(${digits.substring(0, 2)}) ${digits.substring(2, digits.length)}';
    } else if (digits.length <= 10) {
      // Fixo completo (8 dígitos)
      formatted =
          '(${digits.substring(0, 2)}) ${digits.substring(2, 6)}-${digits.substring(6, digits.length)}';
    } else {
      // Celular completo (9 dígitos)
      formatted =
          '(${digits.substring(0, 2)}) ${digits.substring(2, 7)}-${digits.substring(7, digits.length.clamp(7, 11))}';
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
