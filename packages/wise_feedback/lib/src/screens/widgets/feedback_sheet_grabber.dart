import 'package:flutter/material.dart';

import '../../theme/wise_feedback_theme.dart';

/// The pill at the top of the sheet that signals it can be dragged.
class FeedbackSheetGrabber extends StatelessWidget {
  /// Creates the grabber.
  const FeedbackSheetGrabber({required this.theme, super.key});

  /// Visual configuration.
  final WiseFeedbackTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Center(
        child: SizedBox(
          width: 36,
          height: 5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: theme.grabberColor,
              borderRadius: const BorderRadius.all(Radius.circular(100)),
            ),
          ),
        ),
      ),
    );
  }
}
