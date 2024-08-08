import 'package:flutter/services.dart';

class PositiveNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow empty input
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Only allow positive numbers
    final isPositiveNumber = (double.tryParse(newValue.text) != null && double.parse(newValue.text) >= 0)||newValue.text==".";
    if (isPositiveNumber) {
      return newValue;
    } else {
      // If the new value is not a positive number, keep the old value
      return oldValue;
    }
  }
}
