import 'package:flutter/widgets.dart';

import 'signature_controller.dart';
import 'signature_stroke.dart';

/// Paints a [SignatureController]'s canvas, uniformly scaled and centered.
class SignaturePainter extends CustomPainter {
  /// Repaints whenever [controller] changes.
  const SignaturePainter(this.controller) : super(repaint: controller);

  /// The signature to paint.
  final SignatureController controller;

  @override
  void paint(Canvas canvas, Size size) {
    final original = controller.canvasSize;
    if (original == null || size.isEmpty) return;
    final rect = canvasRect(original, size);
    canvas
      ..save()
      ..translate(rect.left, rect.top)
      ..scale(rect.width / original.width);
    controller.paintStrokes(canvas);
    canvas.restore();
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.controller != controller;
}
