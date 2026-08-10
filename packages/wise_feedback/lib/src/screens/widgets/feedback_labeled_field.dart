import 'package:flutter/material.dart';

import '../../theme/wise_feedback_theme.dart';

/// A label above a bordered, rounded box wrapping [child].
class FeedbackLabeledField extends StatelessWidget {
  /// Creates the labelled field.
  const FeedbackLabeledField({
    required this.theme,
    required this.label,
    required this.child,
    super.key,
  });

  /// Visual configuration.
  final WiseFeedbackTheme theme;

  /// Text shown above the box.
  final String label;

  /// The input rendered inside the box.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 12, bottom: 4),
          child: Text(
            label,
            style: TextStyle(fontSize: 15, color: theme.labelColor),
          ),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 52),
          alignment: AlignmentDirectional.centerStart,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: theme.fieldFillColor,
            borderRadius: BorderRadius.circular(theme.fieldRadius),
            border: Border.all(color: theme.fieldBorderColor),
          ),
          child: child,
        ),
      ],
    );
  }
}
