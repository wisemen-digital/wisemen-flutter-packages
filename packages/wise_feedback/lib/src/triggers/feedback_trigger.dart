import 'package:flutter/widgets.dart';

import '../controller/feedback_controller.dart';

/// A composable way to open the feedback UI (e.g., floating button).
///
/// Each trigger wraps its child widget, optionally adding UI or behavior,
/// and uses the given controller to open the feedback flow.
// ignore: one_member_abstracts
abstract class FeedbackTrigger {
  /// Const base constructor so triggers can be declared as `const`.
  const FeedbackTrigger();

  /// Returns [child] augmented with this trigger's behavior, using
  /// [controller] to open the feedback flow.
  Widget wrap(
    BuildContext context,
    FeedbackController controller,
    Widget child,
  );
}
