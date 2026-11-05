import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'signature_controller.dart';
import 'signature_painter.dart';
import 'signature_stroke.dart';

/// A transparent drawing surface with smooth black, rounded pen strokes.
/// Faster movement produces thinner strokes; slower movement produces thicker
/// strokes. Event timestamps and velocity/width filtering keep changes gradual.
///
/// Provide finite width and height through the parent. The original canvas is
/// centered and uniformly scaled after resizing; unused margins do not accept
/// drawing. Stroke edges are inset to keep them completely inside the canvas.
///
/// The first primary pointer draws and additional fingers are ignored. Lifting,
/// cancellation, leaving the canvas, or resizing ends the stroke and retains
/// its points. Drawing claims gestures so an ancestor scroll view stays still.
/// Labels, decoration, validation and action buttons belong to the app.
class SignaturePad extends StatefulWidget {
  /// Creates a drawing surface backed by [controller].
  const SignaturePad({required this.controller, super.key});

  /// The app-owned drawing state. Do not share it between pads.
  final SignatureController controller;

  @override
  State<SignaturePad> createState() => _SignaturePadState();
}

class _SignaturePadState extends State<SignaturePad> {
  int? _pointer;
  Size? _pointerSize;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onChanged);
  }

  @override
  void didUpdateWidget(SignaturePad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onChanged);
      widget.controller.addListener(_onChanged);
      _pointer = null;
    }
  }

  void _onChanged() {
    if (widget.controller.isEmpty) _pointer = null;
  }

  Offset? _canvasPoint(Offset position, Size viewport) =>
      canvasPoint(position, viewport, widget.controller.canvasSize ?? viewport);

  void _onDown(PointerDownEvent event, Size size) {
    if (_pointer != null || event.buttons != kPrimaryButton) return;
    final point = _canvasPoint(event.localPosition, size);
    if (point == null) return;
    _pointer = event.pointer;
    _pointerSize = size;
    widget.controller.startStroke(point, size, event.timeStamp);
  }

  void _onMove(PointerMoveEvent event, Size size) {
    if (_pointer != event.pointer) return;
    final point = _canvasPoint(event.localPosition, size);
    if (size != _pointerSize || point == null) {
      _pointer = null;
      return;
    }
    widget.controller.addPoint(point, event.timeStamp);
  }

  void _onEnd(PointerEvent event) {
    if (_pointer == event.pointer) _pointer = null;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        assert(size.isFinite, 'SignaturePad requires finite width and height.');
        return RawGestureDetector(
          gestures: {
            EagerGestureRecognizer:
                GestureRecognizerFactoryWithHandlers<EagerGestureRecognizer>(
                  EagerGestureRecognizer.new,
                  (_) {},
                ),
          },
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (event) => _onDown(event, size),
            onPointerMove: (event) => _onMove(event, size),
            onPointerUp: _onEnd,
            onPointerCancel: _onEnd,
            child: CustomPaint(
              size: size,
              painter: SignaturePainter(widget.controller),
            ),
          ),
        );
      },
    );
  }
}
