import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

/// A text button for use in app bars with loading and disabled states.
///
/// Displays a text label that can be styled as bold, and supports showing
/// a loading indicator while an action is in progress. The button smoothly
/// animates between the loading and normal states.
///
/// Used in the settings screen app bar for the "Done" button.
class AppBarButton extends StatelessWidget {
  /// Creates an app bar button.
  const AppBarButton({
    required this.title,
    required this.onPressed,
    super.key,
    this.isLoading = false,
    this.isDisabled = false,
    this.isBold = false,
  });

  /// Whether to show a loading indicator instead of the title.
  final bool isLoading;

  /// Whether the button is disabled and cannot be pressed.
  final bool isDisabled;

  /// The text to display on the button.
  final String title;

  /// Whether the title text should be bold.
  final bool isBold;

  /// Callback invoked when the button is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: isLoading ? 1 : 0,
            duration: Durations.medium1,
            child: const Center(child: PlatformLoadingIndicator()),
          ),
        ),
        AnimatedOpacity(
          opacity: isLoading ? 0 : 1,
          duration: Durations.medium1,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: isDisabled ? null : onPressed,
            child: Text(title, style: TextStyle(fontWeight: isBold ? FontWeight.w600 : null)),
          ),
        ),
      ],
    );
  }
}
