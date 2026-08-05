import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/feedback_status.dart';
import '../../theme/wise_feedback_theme.dart';
import 'feedback_circle_button.dart';

/// The form's header: close button, centred title, brand submit button.
///
/// The submit button tracks [status], showing a spinner and refusing taps while
/// a report is in flight.
class FeedbackFormHeader extends StatelessWidget {
  /// Creates the header.
  const FeedbackFormHeader({
    required this.theme,
    required this.status,
    required this.onClose,
    required this.onSubmit,
    super.key,
  });

  /// Visual configuration.
  final WiseFeedbackTheme theme;

  /// Submission state driving the submit button.
  final ValueListenable<FeedbackStatus> status;

  /// Dismisses the sheet without submitting, or null to disable the button.
  final VoidCallback? onClose;

  /// Submits the report.
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 12, 16, 8),
      child: Row(
        children: [
          FeedbackCircleButton(
            buttonKey: const Key('wise_feedback_close'),
            background: theme.iconButtonColor,
            icon: Icons.close_rounded,
            iconColor: theme.labelColor,
            onTap: onClose,
          ),
          Expanded(
            child: Text(
              theme.sheetTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: theme.textColor,
              ),
            ),
          ),
          ValueListenableBuilder<FeedbackStatus>(
            valueListenable: status,
            builder: (context, status, _) => FeedbackCircleButton(
              buttonKey: const Key('wise_feedback_submit'),
              background: theme.primaryColor,
              icon: Icons.check_rounded,
              iconColor: Colors.white,
              loading: status.isSubmitting,
              onTap: status.isSubmitting ? null : onSubmit,
            ),
          ),
        ],
      ),
    );
  }
}
