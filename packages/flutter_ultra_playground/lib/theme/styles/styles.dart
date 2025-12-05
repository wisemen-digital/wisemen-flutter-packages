import 'package:flutter/material.dart';
import 'package:flutter_ultra_playground/theme/theme.dart';

InputDecoration textFieldDecoration({String? label, String? hintText, Color? fillColor, bool noStroke = false}) {
  final border = OutlineInputBorder(
    borderSide: BorderSide(color: const Color(0xFFCFD4DC), width: noStroke ? 0 : 1),
    borderRadius: BorderRadius.circular(10),
  );

  return InputDecoration(
    filled: true,
    fillColor: fillColor ?? Colors.white,
    labelText: label,
    hintText: hintText,
    hintStyle: AppStyles.hint,
    floatingLabelBehavior: hintText != null ? FloatingLabelBehavior.always : null,
    labelStyle: AppStyles.label,
    border: border,
    focusedBorder: border,
    enabledBorder: border,
    disabledBorder: border,
    errorBorder: border.copyWith(borderSide: const BorderSide(color: Colors.red)),
    errorStyle: const TextStyle(color: Colors.red),
    focusedErrorBorder: border,
    focusColor: Colors.black,
    isDense: true,
    contentPadding: const EdgeInsets.all(16.0),
    errorMaxLines: 5,
  );
}
