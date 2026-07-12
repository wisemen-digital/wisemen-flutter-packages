/// In-app bug reporting for Flutter that files reports as Linear issues.
library wise_feedback;

export 'src/controller/feedback_controller.dart';
export 'src/models/feedback_exception.dart';
export 'src/models/feedback_report.dart';
export 'src/models/feedback_result.dart';
export 'src/models/feedback_status.dart';
export 'src/transport/feedback_transport.dart';
export 'src/transport/linear_direct_transport.dart';
export 'src/transport/linear_proxy_transport.dart';
export 'src/triggers/feedback_trigger.dart';
export 'src/triggers/floating_button_trigger.dart';
export 'src/triggers/shake_trigger.dart';
export 'src/ui/feedback_form.dart';
export 'src/ui/linear_feedback.dart';
export 'src/ui/wise_feedback_theme.dart';
