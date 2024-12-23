// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AppNumberInputField extends StatelessWidget {
  final TextEditingController? textEditingController;
  final void Function(String)? onChanged;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? hintText;
  final InputBorder? border;
  final String? suffixText;
  final double? minValue;
  final double? maxValue;
  final TextAlign textAlign;

  AppNumberInputField(
      {Key? key,
      this.textEditingController,
      this.onChanged,
      this.style,
      this.hintStyle,
      this.hintText,
      this.border,
      this.suffixText,
      this.minValue,
      this.maxValue,
      this.textAlign = TextAlign.center})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      textAlign: textAlign,
      maxLines: 1,
      style: style,
      decoration: InputDecoration(
        suffixText: suffixText,
        border: border,
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: EdgeInsets.all(16.0),
      ),
      inputFormatters: [
        // Optional: use this to restrict input to only numbers
        FilteringTextInputFormatter.digitsOnly,
        ThousandsSeparatorInputFormatter(),
        _ValueRangeInputFormatter(minValue: minValue, maxValue: maxValue),
      ],
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat formatter = NumberFormat("#,###");

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) return newValue;

    // Remove all commas for processing
    final String sanitizedText = newValue.text.replaceAll(',', '');
    final int? value = int.tryParse(sanitizedText);

    if (value == null) return oldValue;

    // Format the input with commas
    final String formattedText = formatter.format(value);
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

class _ValueRangeInputFormatter extends TextInputFormatter {
  final double? minValue;
  final double? maxValue;

  _ValueRangeInputFormatter({this.minValue, this.maxValue});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (minValue == null && maxValue == null) {
      return newValue;
    }

    final double? value = double.tryParse(newValue.text);
    if (value != null) {
      if (minValue != null && value < minValue!) {
        return oldValue;
      }
      if (maxValue != null && value > maxValue!) {
        return oldValue;
      }
    }

    return newValue;
  }
}
