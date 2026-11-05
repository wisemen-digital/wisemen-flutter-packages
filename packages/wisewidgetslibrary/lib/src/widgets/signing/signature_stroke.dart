import 'dart:math' as math;

import 'package:flutter/widgets.dart';

const _initialStrokeWidth = 2.5;
const _minStrokeWidth = 1.2;
const _maxStrokeWidth = 3.6;
const _positionWindow = 3.0;
const _tipTravel = 2.0;

// Exponential smoothing: the share of the previous value kept per sample.
const _retained = .65;
const _added = 1 - _retained;

/// Pen color for display and export; the PNG is always black ink.
const signatureInkColor = Color(0xFF000000);

/// Inset that keeps the widest stroke and its antialiasing inside the canvas.
const signatureEdgeInset = _maxStrokeWidth / 2 + 1;

typedef _InkPoint = ({Offset position, double width});

/// One pen stroke with velocity-based widths, in canvas coordinates.
class SignatureStroke {
  /// Starts a stroke at [point], sampled at [_lastTime].
  SignatureStroke(Offset point, this._lastTime)
    : _points = [(position: point, width: _initialStrokeWidth)];

  final List<_InkPoint> _points;
  Duration _lastTime;
  double _velocity = 0;

  /// Number of distinct consecutive points.
  int get length => _points.length;

  /// Adds [point] sampled at [time]; returns false for a duplicate point.
  bool add(Offset point, Duration time) {
    final previous = _points.last;
    final distance = (point - previous.position).distance;
    if (distance == 0) return false;
    // Clamp clock anomalies and long pauses; neither should create a width jump.
    final milliseconds = ((time - _lastTime).inMicroseconds / 1000).clamp(
      1,
      64,
    );
    _velocity = _velocity * _retained + distance / milliseconds * _added;
    final target =
        _minStrokeWidth +
        (_maxStrokeWidth - _minStrokeWidth) / (1 + _velocity * 1.5);
    _points.add((
      position: point,
      width: previous.width * _retained + target * _added,
    ));
    _lastTime = time;
    return true;
  }
}

/// The area of [viewport] that shows [canvas], uniformly scaled and centered.
Rect canvasRect(Size canvas, Size viewport) {
  final scale = math.min(
    viewport.width / canvas.width,
    viewport.height / canvas.height,
  );
  return Alignment.center.inscribe(canvas * scale, Offset.zero & viewport);
}

/// Maps [position] in [viewport] to canvas coordinates of a [canvas]-sized
/// signature, clamped to the edge inset. Null outside the visible canvas or
/// when the canvas is too small to draw in.
Offset? canvasPoint(Offset position, Size viewport, Size canvas) {
  if (canvas.shortestSide <= signatureEdgeInset * 2 || !canvas.isFinite) {
    return null;
  }
  final rect = canvasRect(canvas, viewport);
  if (!rect.contains(position)) return null;
  final point = (position - rect.topLeft) / (rect.width / canvas.width);
  return Offset(
    point.dx.clamp(signatureEdgeInset, canvas.width - signatureEdgeInset),
    point.dy.clamp(signatureEdgeInset, canvas.height - signatureEdgeInset),
  );
}

/// Paints [strokes] in black ink, in canvas coordinates.
void paintSignature(Canvas canvas, List<SignatureStroke> strokes) {
  final paint = Paint()..color = signatureInkColor;
  for (final stroke in strokes) {
    if (stroke._points.length == 1) {
      canvas.drawCircle(
        stroke._points.first.position,
        _initialStrokeWidth / 2,
        paint,
      );
    } else {
      final (points, tips) = _smoothPositions(stroke._points);
      for (var i = 1; i < tips.length; i++) {
        canvas.drawPath(
          _strokeOutline(points.sublist(tips[i - 1], tips[i] + 1)),
          paint,
        );
      }
    }
  }
}

(List<_InkPoint>, List<int>) _smoothPositions(List<_InkPoint> points) {
  final distances = [0.0];
  for (var i = 1; i < points.length; i++) {
    distances.add(
      distances.last + (points[i].position - points[i - 1].position).distance,
    );
  }
  final tips = [0];
  var left = 0;
  var right = 0;
  for (var i = 1; i < points.length - 1; i++) {
    while (left + 1 < i &&
        distances[left + 1] <= distances[i] - _positionWindow) {
      left++;
    }
    while (right < points.length - 1 &&
        distances[right] < distances[i] + _positionWindow) {
      right++;
    }
    final incoming = points[i].position - points[i - 1].position;
    final outgoing = points[i + 1].position - points[i].position;
    final before = points[i].position - points[left].position;
    final after = points[right].position - points[i].position;
    // A single backwards sample can be quantization/jitter. A deliberate tip
    // also reverses over a wider neighborhood with meaningful travel both ways.
    if (incoming.dx * outgoing.dx + incoming.dy * outgoing.dy < 0 &&
        before.dx * after.dx + before.dy * after.dy < 0 &&
        before.distance >= _tipTravel &&
        after.distance >= _tipTravel) {
      tips.add(i);
    }
  }
  tips.add(points.length - 1);
  final smoothed = List<_InkPoint>.of(points);
  for (var run = 1; run < tips.length; run++) {
    final start = tips[run - 1];
    final end = tips[run];
    left = start;
    for (var i = start + 1; i < end; i++) {
      final low = math.max(distances[start], distances[i] - _positionWindow);
      final high = math.min(distances[end], distances[i] + _positionWindow);
      while (left + 1 < i && distances[left + 1] <= low) {
        left++;
      }
      var position = Offset.zero;
      var weight = 0.0;
      for (var j = left; j < end && distances[j] < high; j++) {
        final a = math.max(low, distances[j]);
        final b = math.min(high, distances[j + 1]);
        final length = distances[j + 1] - distances[j];
        if (b <= a || length <= 0) {
          continue;
        }
        final p = Offset.lerp(
          points[j].position,
          points[j + 1].position,
          (a - distances[j]) / length,
        )!;
        final q = Offset.lerp(
          points[j].position,
          points[j + 1].position,
          (b - distances[j]) / length,
        )!;
        final u = 1 - (a - distances[i]).abs() / _positionWindow;
        final v = 1 - (b - distances[i]).abs() / _positionWindow;
        // Integrate position × triangular weight along each segment, rather
        // than per event: dense event clusters must not pull the ink sideways.
        position += (p * (2 * u + v) + q * (u + 2 * v)) * ((b - a) / 6);
        weight += (u + v) * (b - a) / 2;
      }
      if (weight > 0) {
        smoothed[i] = (position: position / weight, width: points[i].width);
      }
    }
  }
  // Run endpoints include deliberate tips and the latest live sample. Pinning
  // them keeps tips intact and follows the pointer without waiting for events.
  return (smoothed, tips);
}

_InkPoint _midpoint(_InkPoint a, _InkPoint b) => (
  position: (a.position + b.position) / 2,
  width: (a.width + b.width) / 2,
);

Path _strokeOutline(List<_InkPoint> points) {
  final curve = [points.first];
  // Quadratics stay within the smoothed samples' convex hull and pass through
  // their midpoints. The latest endpoint remains at the actual pointer position.
  for (var i = 0; i < points.length; i++) {
    final control = points[i];
    final start = i == 0 ? control : _midpoint(points[i - 1], control);
    final end = i == points.length - 1
        ? control
        : _midpoint(control, points[i + 1]);
    final length =
        (control.position - start.position).distance +
        (end.position - control.position).distance;
    final steps = (length / 2).ceil().clamp(1, 32);
    for (var step = 1; step <= steps; step++) {
      final t = step / steps;
      final u = 1 - t;
      final position =
          start.position * (u * u) +
          control.position * (2 * u * t) +
          end.position * (t * t);
      if (position == curve.last.position) continue;
      curve.add((
        position: position,
        width:
            start.width * u * u + control.width * 2 * u * t + end.width * t * t,
      ));
    }
  }
  final normals = <Offset>[];
  for (var i = 0; i < curve.length; i++) {
    final before = curve[math.max(0, i - 1)].position;
    final after = curve[math.min(curve.length - 1, i + 1)].position;
    var tangent = after - before;
    if (tangent.distance == 0) tangent = curve[i].position - before;
    normals.add(
      tangent.distance == 0
          ? const Offset(0, 1)
          : Offset(-tangent.dy, tangent.dx) / tangent.distance,
    );
  }
  final path = Path();
  for (var i = 0; i < curve.length; i++) {
    final edge = curve[i].position + normals[i] * (curve[i].width / 2);
    if (i == 0) {
      path.moveTo(edge.dx, edge.dy);
    } else {
      path.lineTo(edge.dx, edge.dy);
    }
  }
  path.arcTo(
    Rect.fromCircle(center: curve.last.position, radius: curve.last.width / 2),
    normals.last.direction,
    -math.pi,
    false,
  );
  for (var i = curve.length - 1; i >= 0; i--) {
    final edge = curve[i].position - normals[i] * (curve[i].width / 2);
    path.lineTo(edge.dx, edge.dy);
  }
  path.arcTo(
    Rect.fromCircle(
      center: curve.first.position,
      radius: curve.first.width / 2,
    ),
    (-normals.first).direction,
    -math.pi,
    false,
  );
  return path..close();
}
