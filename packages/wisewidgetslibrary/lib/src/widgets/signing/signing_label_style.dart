import 'package:flutter/material.dart';

/// Label style shared by the signing widgets and app layouts built from them.
extension SigningLabelStyle on ThemeData {
  /// Style of the name label and "Sign here", so both read as labels.
  /// Uses the input theme's label style, or muted `bodyLarge`.
  TextStyle? get signingLabelStyle =>
      inputDecorationTheme.labelStyle ??
      textTheme.bodyLarge?.copyWith(color: colorScheme.onSurfaceVariant);
}
