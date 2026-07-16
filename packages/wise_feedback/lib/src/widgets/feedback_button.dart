import 'package:flutter/material.dart';

/// A circular button that opens the feedback flow when tapped.
///
/// May be mounted above the app's own [MaterialApp], where no ambient
/// [Material] or [Directionality] exists yet, so it self-provides both.
class FeedbackButton extends StatelessWidget {
  /// Creates the button.
  const FeedbackButton({
    required this.onPressed,
    this.alignment = Alignment.bottomRight,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = Colors.black,
    this.icon,
    super.key,
  });

  /// Called when the button is tapped.
  final VoidCallback onPressed;

  /// Where the button sits over the app.
  final AlignmentGeometry alignment;

  /// Padding between the button and the screen edges.
  final EdgeInsetsGeometry padding;

  /// Button background color.
  final Color backgroundColor;

  /// Optional custom icon. Defaults to [Icons.bug_report].
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    Widget button = Align(
      alignment: alignment,
      child: Padding(
        padding: padding,
        child: Material(
          type: MaterialType.transparency,
          child: FloatingActionButton(
            key: const Key('wise_feedback_fab'),
            backgroundColor: backgroundColor,
            shape: const CircleBorder(),
            onPressed: onPressed,
            child: icon ?? const Icon(Icons.bug_report, color: Colors.white),
          ),
        ),
      ),
    );
    if (Directionality.maybeOf(context) == null) {
      button = Directionality(textDirection: TextDirection.ltr, child: button);
    }
    return button;
  }
}
