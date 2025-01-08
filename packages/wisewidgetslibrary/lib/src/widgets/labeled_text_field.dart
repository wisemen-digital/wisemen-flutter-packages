import 'dart:async';

import 'package:conditional_wrap/conditional_wrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants/constants.dart';

/// A [TextField] with a label above it.
class LabeledTextField extends StatelessWidget {
  /// Constructor [LabeledTextField]
  const LabeledTextField({
    this.textInputAction,
    this.disabled = false,
    this.textCapitalization,
    this.isRequired = true,
    this.scrollPadding = const EdgeInsets.all(20),
    this.readOnly = false,
    this.showAndroidLabel = false,
    super.key,
    this.controller,
    this.decoration = const InputDecoration(),
    this.onChanged,
    this.style,
    this.focusNode,
    this.inputFormatters,
    this.keyboardType,
    this.label,
    this.labelStyle,
    this.cursorColor,
    this.onFieldSubmitted,
    this.onEditingComplete,
  });

  /// Controller for the text field
  final TextEditingController? controller;

  /// Decoration for the text field
  final InputDecoration decoration;

  /// Callback for onChanged
  final void Function(String)? onChanged;

  /// [TextStyle] for the text field
  final TextStyle? style;

  /// [TextInputAction] for the text field
  final TextInputAction? textInputAction;

  /// Is the text field disabled
  final bool disabled;

  /// [TextCapitalization] for the text field
  final TextCapitalization? textCapitalization;

  /// Is the text field required
  final bool isRequired;

  /// Focus node for the text field
  final FocusNode? focusNode;

  /// List of [TextInputFormatter] for the text field
  final List<TextInputFormatter>? inputFormatters;

  /// [TextInputType] for the text field
  final TextInputType? keyboardType;

  /// Padding for the scroll view
  final EdgeInsets scrollPadding;

  /// Is the text field read only
  final bool readOnly;

  /// Label for the text field
  final String? label;

  /// [TextStyle] for the label
  final TextStyle? labelStyle;

  /// Show the label on Android
  final bool showAndroidLabel;

  /// [Color] for the cursor
  final Color? cursorColor;

  /// Callback for onFieldSubmitted
  final FutureOr<void> Function(String text)? onFieldSubmitted;

  /// Callback for onEditingComplete
  final FutureOr<void> Function()? onEditingComplete;

  bool get _showCupertinoLabel => label != null && !showAndroidLabel;

  TextStyle? _labelStyle(BuildContext context) =>
      labelStyle ?? Theme.of(context).inputDecorationTheme.labelStyle;

  @override
  Widget build(BuildContext context) {
    return WidgetWrapper(
      wrapper: (child) {
        if (_showCupertinoLabel) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label!,
                style: _labelStyle(context),
              ),
              gapH5,
              child,
            ],
          );
        } else {
          return child;
        }
      },
      child: TextField(
        controller: controller,
        cursorColor: cursorColor,
        keyboardType: keyboardType,
        onSubmitted: (text) => onFieldSubmitted?.call(text),
        focusNode: focusNode,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        enabled: !disabled,
        onEditingComplete: onEditingComplete,
        onChanged: onChanged,
        decoration: decoration.copyWith(
          label: showAndroidLabel && label != null ? Text(label!) : null,
          labelStyle: _labelStyle(
            context,
          ),
          floatingLabelStyle: _labelStyle(
            context,
          ),
        ),
        readOnly: readOnly,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        scrollPadding: scrollPadding,
        style: style,
      ),
    );
  }
}
