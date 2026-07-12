import 'package:flutter/material.dart';

import '../controller/feedback_controller.dart';
import 'feedback_trigger.dart';

/// Overlays a circular button that opens the feedback UI when tapped.
class FloatingButtonTrigger extends FeedbackTrigger {
  /// Creates the trigger.
  const FloatingButtonTrigger({
    this.alignment = Alignment.bottomRight,
    this.padding = const EdgeInsets.all(16),
    this.icon,
    this.backgroundColor = Colors.black,
  });

  /// Where the button sits over the app.
  final Alignment alignment;

  /// Padding between the button and the screen edges.
  final EdgeInsets padding;

  /// Optional custom icon. Defaults to [Icons.bug_report].
  final Widget? icon;

  /// Button background color.
  final Color backgroundColor;

  @override
  Widget wrap(
    BuildContext context,
    FeedbackController controller,
    Widget child,
  ) {
    return Stack(
      children: [
        child,
        Align(
          alignment: alignment,
          child: Padding(
            padding: padding,
            child: FloatingActionButton(
              key: const Key('wise_feedback_fab'),
              backgroundColor: backgroundColor,
              shape: const CircleBorder(),
              onPressed: controller.show,
              child: icon ?? const Icon(Icons.bug_report, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
