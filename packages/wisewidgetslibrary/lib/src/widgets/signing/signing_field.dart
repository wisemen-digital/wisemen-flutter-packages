import 'package:flutter/material.dart';

import 'signing_canvas.dart';
import 'signing_clear_button.dart';
import 'signing_controller.dart';
import 'signing_label_style.dart';
import 'signing_name_input.dart';
import 'signing_strings.dart';
import 'signing_style.dart';

/// Name input, signature canvas, Clear and first-ink signing metadata.
///
/// Place in a parent with finite width, usually a scroll view so the name field
/// remains reachable with the keyboard open. Height follows the content and
/// text scale. The app owns its submit button and calls [SigningController.submit].
/// Uses the surrounding Material theme for fields, typography and buttons.
class SigningField extends StatelessWidget {
  /// Creates a signing component. Use one controller per field.
  const SigningField({
    required this.controller,
    this.strings = const SigningStringsEn(),
    this.canvasDecoration,
    this.clearIcon,
    this.metadataStyle,
    this.timestampFormat,
    super.key,
  });

  /// App-owned signing state, retained across rebuilds and rotation.
  final SigningController controller;

  /// App-supplied labels and field errors.
  final SigningStrings strings;

  /// Optional canvas card styling; see [SigningCanvas.decoration].
  final BoxDecoration? canvasDecoration;

  /// Optional decorative Clear icon; see [SigningClearButton.icon].
  final Widget? clearIcon;

  /// Optional metadata style; see [SigningCanvas.metadataStyle].
  final TextStyle? metadataStyle;

  /// Optional `intl` date pattern; see [SigningCanvas.timestampFormat].
  final String? timestampFormat;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: signingSectionGap,
      children: [
        SigningNameInput(controller: controller, strings: strings),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: signingSectionGap,
          children: [
            Text(
              strings.signHere,
              style: Theme.of(context).signingLabelStyle,
            ),
            SigningClearButton(
              controller: controller,
              label: strings.clear,
              icon: clearIcon,
            ),
          ],
        ),
        SigningCanvas(
          controller: controller,
          strings: strings,
          decoration: canvasDecoration,
          metadataStyle: metadataStyle,
          timestampFormat: timestampFormat,
        ),
      ],
    );
  }
}
