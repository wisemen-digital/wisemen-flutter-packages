import 'package:flutter/material.dart';

/// A round icon button, used for the header's close and submit actions.
///
/// Shows a spinner in place of the icon while [loading].
class FeedbackCircleButton extends StatelessWidget {
  /// Creates the button.
  const FeedbackCircleButton({
    required this.buttonKey,
    required this.background,
    required this.icon,
    required this.iconColor,
    required this.onTap,
    this.loading = false,
    super.key,
  });

  /// Applied to the tappable surface so tests can target the button.
  final Key buttonKey;

  /// Fill color of the circle.
  final Color background;

  /// Glyph rendered in the centre.
  final IconData icon;

  /// Color of [icon] and of the loading spinner.
  final Color iconColor;

  /// Tap handler, or null to disable the button.
  final VoidCallback? onTap;

  /// Whether to replace [icon] with a progress indicator.
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 44,
      child: Material(
        key: buttonKey,
        color: background,
        shape: const CircleBorder(),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Center(
            child: loading
                ? SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: iconColor,
                    ),
                  )
                : Icon(icon, size: 20, color: iconColor),
          ),
        ),
      ),
    );
  }
}
