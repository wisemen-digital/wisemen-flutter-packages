import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';
import 'signing_controller.dart';
import 'signing_label_style.dart';
import 'signing_strings.dart';

/// Name label above a rounded input, with the name validation error below it.
class SigningNameInput extends StatelessWidget {
  /// Creates the name input of [controller].
  const SigningNameInput({
    required this.controller,
    required this.strings,
    super.key,
  });

  /// Signing state that owns the entered name.
  final SigningController controller;

  /// Label and error text.
  final SigningStrings strings;

  static const _minHeight = 52.0;
  static const _contentPadding = EdgeInsets.symmetric(
    horizontal: Sizes.m,
    vertical: 14,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: Sizes.xs,
      children: [
        ExcludeSemantics(
          child: Text(strings.signerName, style: theme.signingLabelStyle),
        ),
        Semantics(
          label: strings.signerName,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: _minHeight),
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, child) => TextField(
                controller: controller.nameController,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                autofillHints: const [AutofillHints.name],
                decoration: InputDecoration(
                  border:
                      inputTheme.border ??
                      const OutlineInputBorder(borderRadius: radM),
                  contentPadding: inputTheme.contentPadding ?? _contentPadding,
                  errorText: controller.showsNameError
                      ? strings.nameRequired
                      : null,
                  errorMaxLines: 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
