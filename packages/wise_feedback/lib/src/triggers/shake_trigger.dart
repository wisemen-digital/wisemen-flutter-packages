import 'package:flutter/widgets.dart';
import 'package:shake/shake.dart';

import '../controller/feedback_controller.dart';
import 'feedback_trigger.dart';

/// Opens the feedback UI when the device is shaken.
class ShakeTrigger extends FeedbackTrigger {
  /// Creates the trigger.
  const ShakeTrigger();

  @override
  Widget wrap(
    BuildContext context,
    FeedbackController controller,
    Widget child,
  ) {
    return _ShakeListener(controller: controller, child: child);
  }
}

class _ShakeListener extends StatefulWidget {
  const _ShakeListener({required this.controller, required this.child});

  final FeedbackController controller;
  final Widget child;

  @override
  State<_ShakeListener> createState() => _ShakeListenerState();
}

class _ShakeListenerState extends State<_ShakeListener> {
  ShakeDetector? _detector;

  @override
  void initState() {
    super.initState();
    _detector = ShakeDetector.autoStart(
      onPhoneShake: (_) => widget.controller.show(),
    );
  }

  @override
  void dispose() {
    _detector?.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
