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
    final button = Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        // The trigger may be mounted above the app's own MaterialApp (the
        // usual `LinearFeedback(child: MyApp())` placement), where no ambient
        // [Material] exists yet. Provide a transparent one so the button and
        // its ink effects render regardless of placement.
        child: Material(
          type: MaterialType.transparency,
          child: FloatingActionButton(
            key: const Key('wise_feedback_fab'),
            backgroundColor: backgroundColor,
            shape: const CircleBorder(),
            onPressed: controller.show,
            child: icon ?? const Icon(Icons.bug_report, color: Colors.white),
          ),
        ),
      ),
    );

    final overlay = Stack(children: [child, button]);

    // Mounted above the app's [MaterialApp] there is also no [Directionality]
    // in scope, which the [Stack] alignment and the button both require. Only
    // supply one when the surrounding tree hasn't already (so an app that
    // wraps below its MaterialApp keeps its own text direction).
    if (Directionality.maybeOf(context) == null) {
      return Directionality(textDirection: TextDirection.ltr, child: overlay);
    }
    return overlay;
  }
}
