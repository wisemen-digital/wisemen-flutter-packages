import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

import 'signature_stroke.dart';

/// Owns one signature. Keep it across rebuilds and dispose it after unmounting
/// its `SignaturePad`. Use a separate controller for each pad.
class SignatureController extends ChangeNotifier {
  /// Creates an empty signature.
  SignatureController();

  final List<SignatureStroke> _strokes = [];
  Size? _canvasSize;

  /// Whether no points have been drawn. A tap counts as a single-point stroke.
  bool get isEmpty => _strokes.isEmpty;

  /// Number of strokes, including the stroke currently being drawn.
  int get strokeCount => _strokes.length;

  /// Number of distinct consecutive points sampled, including the active stroke.
  ///
  /// Sampling depends on the device. The app decides any validation threshold.
  int get pointCount =>
      _strokes.fold(0, (count, stroke) => count + stroke.length);

  /// Canvas size fixed by the first stroke since the last clear, or null when
  /// empty. Strokes and the exported PNG use this coordinate space.
  Size? get canvasSize => _canvasSize;

  /// Clears all strokes and lets the next stroke establish a new canvas size.
  /// Any finger already down must be lifted before it can draw again.
  void clear() {
    assert(
      ChangeNotifier.debugAssertNotDisposed(this),
      'Controller is disposed.',
    );
    _strokes.clear();
    _canvasSize = null;
    notifyListeners();
  }

  /// Renders a snapshot as transparent PNG bytes, or null when empty.
  ///
  /// The image includes the active stroke and uses the first stroke's canvas
  /// size, rounded up to whole pixels (one pixel per original logical pixel).
  /// Resizing the pad does not change export dimensions or stroke proportions.
  /// Export also works after the pad unmounts, until this controller is disposed.
  Future<Uint8List?> toPngBytes() async {
    assert(
      ChangeNotifier.debugAssertNotDisposed(this),
      'Controller is disposed.',
    );
    final size = _canvasSize;
    if (isEmpty || size == null) return null;

    final recorder = ui.PictureRecorder();
    paintStrokes(Canvas(recorder));
    final picture = recorder.endRecording();
    try {
      final image = await picture.toImage(
        size.width.ceil(),
        size.height.ceil(),
      );
      try {
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        if (bytes == null) throw StateError('Could not encode signature PNG.');
        return bytes.buffer.asUint8List(
          bytes.offsetInBytes,
          bytes.lengthInBytes,
        );
      } finally {
        image.dispose();
      }
    } finally {
      picture.dispose();
    }
  }

  /// Starts a stroke at [point] in canvas coordinates, sampled at [time].
  /// The first stroke since the last clear fixes [canvasSize] to [size].
  /// Called by `SignaturePad` for pointer input.
  void startStroke(Offset point, Size size, Duration time) {
    _canvasSize ??= size;
    _strokes.add(SignatureStroke(point, time));
    notifyListeners();
  }

  /// Adds [point] in canvas coordinates to the active stroke.
  /// Called by `SignaturePad` for pointer input.
  void addPoint(Offset point, Duration time) {
    if (_strokes.last.add(point, time)) notifyListeners();
  }

  /// Paints every stroke in black ink, in canvas coordinates.
  void paintStrokes(Canvas canvas) {
    paintSignature(canvas, _strokes);
  }

  @override
  void dispose() {
    _strokes.clear();
    _canvasSize = null;
    super.dispose();
  }
}
