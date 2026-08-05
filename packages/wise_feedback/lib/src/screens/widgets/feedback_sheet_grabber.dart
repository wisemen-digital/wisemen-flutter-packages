import 'package:flutter/material.dart';

/// Fill of the grabber pill.
const Color _kGrabberColor = Color(0x33000000);

/// The pill at the top of the sheet that signals it can be dragged.
class FeedbackSheetGrabber extends StatelessWidget {
  /// Creates the grabber.
  const FeedbackSheetGrabber({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 8, bottom: 4),
      child: Center(
        child: SizedBox(
          width: 36,
          height: 5,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: _kGrabberColor,
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
        ),
      ),
    );
  }
}
