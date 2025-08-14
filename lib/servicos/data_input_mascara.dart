import 'package:flutter/services.dart';

class DataInputMascara extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitos = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    String formatado = '';
    if (digitos.isEmpty) {
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    // Apenas dia (até 2 dígitos)
    if (digitos.length <= 2) {
      int diaNum = int.tryParse(digitos) ?? 0;
      if (diaNum > 31) {
        digitos = '31';
      }
      formatado = digitos;
    }
    // Dia e mês
    else if (digitos.length <= 4) {
      String dia = digitos.substring(0, 2);
      int diaNum = int.tryParse(dia) ?? 0;
      if (diaNum > 31) dia = '31';

      String mes = digitos.substring(2);
      int mesNum = int.tryParse(mes) ?? 0;
      if (mesNum > 12) mes = '12';

      formatado = '$dia/$mes';
    } else {
      String dia = digitos.substring(0, 2);
      int diaNum = int.tryParse(dia) ?? 0;
      if (diaNum > 31) dia = '31';

      String mes = digitos.substring(2, 4);
      int mesNum = int.tryParse(mes) ?? 0;
      if (mesNum > 12) mes = '12';

      String ano = digitos.substring(4);
      formatado = '$dia/$mes/$ano';
    }
    return TextEditingValue(
      text: formatado,
      selection: TextSelection.collapsed(offset: formatado.length),
    );
  }
}
