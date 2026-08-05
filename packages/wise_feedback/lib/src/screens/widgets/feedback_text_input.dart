import 'package:flutter/material.dart';

import '../../theme/wise_feedback_theme.dart';

/// A borderless text field sized to sit inside a labelled field box.
class FeedbackTextInput extends StatelessWidget {
  /// Creates the input.
  const FeedbackTextInput({
    required this.theme,
    required this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.fieldKey,
    super.key,
  });

  /// Visual configuration.
  final WiseFeedbackTheme theme;

  /// Holds the edited text.
  final TextEditingController controller;

  /// Minimum number of visible lines.
  final int minLines;

  /// Maximum number of visible lines.
  final int maxLines;

  /// Applied to the underlying `TextField` so tests can target it.
  final Key? fieldKey;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: fieldKey,
      controller: controller,
      textCapitalization: TextCapitalization.sentences,
      minLines: minLines,
      maxLines: maxLines,
      cursorColor: theme.primaryColor,
      style: TextStyle(fontSize: 17, color: theme.textColor),
      decoration: InputDecoration(
        isCollapsed: true,
        border: InputBorder.none,
        hintStyle: TextStyle(color: theme.hintColor, fontSize: 17),
      ),
    );
  }
}
