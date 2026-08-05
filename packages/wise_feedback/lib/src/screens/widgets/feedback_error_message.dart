import 'package:flutter/material.dart';

import '../../theme/wise_feedback_theme.dart';

/// The inline error shown under the form when a submission fails.
class FeedbackErrorMessage extends StatelessWidget {
  /// Creates the error row.
  const FeedbackErrorMessage({
    required this.theme,
    required this.message,
    super.key,
  });

  /// Visual configuration.
  final WiseFeedbackTheme theme;

  /// Human-readable failure text.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        key: const Key('wise_feedback_error'),
        children: [
          Icon(Icons.error_outline, color: theme.errorColor, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: theme.errorColor),
            ),
          ),
        ],
      ),
    );
  }
}
