import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wisewidgetslibrary/wisewidgetslibrary.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({super.key, this.isLoading = false, this.isDisabled = false, required this.title, this.isBold = false, required this.onPressed});

  final bool isLoading;
  final bool isDisabled;
  final String title;
  final bool isBold;
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
