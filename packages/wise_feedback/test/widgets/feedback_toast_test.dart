import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_feedback/src/widgets/feedback_toast.dart';

void main() {
  testWidgets('FeedbackToast renders message and fires onDismiss on tap',
      (tester) async {
    var dismissed = 0;
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(),
        child: FeedbackToast(
          message: 'Saved',
          isError: false,
          onDismiss: () => dismissed++,
        ),
      ),
    );

    expect(find.text('Saved'), findsOneWidget);
    await tester.tap(find.text('Saved'));
    await tester.pump();
    expect(dismissed, 1);
  });
}
