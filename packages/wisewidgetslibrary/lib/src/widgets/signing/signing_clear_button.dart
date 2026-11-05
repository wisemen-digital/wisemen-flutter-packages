import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';
import 'signing_controller.dart';

/// Pill button that clears the drawing; disabled while the canvas is empty.
/// The app's `TextButtonTheme` takes precedence over the pill defaults.
class SigningClearButton extends StatelessWidget {
  /// Creates the Clear button of [controller].
  const SigningClearButton({
    required this.controller,
    required this.label,
    this.icon,
    super.key,
  });

  /// Signing state whose drawing is cleared.
  final SigningController controller;

  /// Button text, which also serves as its accessible label.
  final String label;

  /// Optional decorative icon. Inherit [IconTheme] for state-aware colors;
  /// its semantics are excluded because [label] already names the action.
  final Widget? icon;

  static const _minHeight = 36.0;
  static const _padding = EdgeInsets.symmetric(horizontal: 14, vertical: 6);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = (theme.textButtonTheme.style ?? const ButtonStyle()).merge(
      TextButton.styleFrom(
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        foregroundColor: theme.colorScheme.onSurface,
        textStyle: theme.textTheme.bodyLarge,
        minimumSize: const Size(0, _minHeight),
        padding: _padding,
        shape: const StadiumBorder(),
      ),
    );
    return ListenableBuilder(
      listenable: controller,
      builder: (context, child) => TextButton(
        style: style,
        onPressed: controller.signatureController.isEmpty
            ? null
            : controller.clear,
        // TextButton.icon fixes the normal-size gap at 8px; use a Row for the
        // 4px gap while retaining SDK button state handling.
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: Sizes.xs,
          children: [
            if (icon case final icon?) ExcludeSemantics(child: icon),
            Flexible(child: Text(label)),
          ],
        ),
      ),
    );
  }
}
