import 'package:flutter/material.dart';

/// Icon and text color of the inline submission error.
const Color _kErrorColor = Color(0xFFD32F2F);

/// The inline error shown under the form when a submission fails.
class FeedbackErrorMessage extends StatelessWidget {
  /// Creates the error row.
  const FeedbackErrorMessage({required this.message, super.key});

  /// Human-readable failure text.
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        key: const Key('wise_feedback_error'),
        children: [
          const Icon(Icons.error_outline, color: _kErrorColor, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: _kErrorColor),
            ),
          ),
        ],
      ),
    );
  }
}
