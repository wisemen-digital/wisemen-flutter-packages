import 'package:flutter/widgets.dart';

import 'signature_controller.dart';
import 'signing_result.dart';

/// Owns the name, drawing, validation and first-ink timestamp of one
/// `SigningField`. Keep it across rebuilds; dispose it with the owning screen.
class SigningController extends ChangeNotifier {
  /// Creates an empty signing form.
  SigningController() {
    _name.addListener(_nameEdited);
    _drawing.addListener(_drawingEdited);
  }

  final _name = TextEditingController();
  final _drawing = SignatureController();
  String _lastName = '';
  bool _validationRequested = false;
  bool _disposed = false;
  int _revision = 0;
  SigningResult? _result;
  DateTime? _signedAt;
  Future<SigningResult?>? _pending;

  /// Text of the name input. Editing it behaves like typing in the field.
  TextEditingController get nameController => _name;

  /// Drawing shown by the field's `SignaturePad`.
  SignatureController get signatureController => _drawing;

  /// The entered name. Setting it also invalidates any previous confirmation.
  String get signerName => _name.text;

  set signerName(String value) {
    assert(
      ChangeNotifier.debugAssertNotDisposed(this),
      'Controller is disposed.',
    );
    _name.text = value;
  }

  /// First-ink time shown immediately by the field, or null when cleared/empty.
  /// Name edits and additional strokes retain this time until Clear is used.
  DateTime? get signedAt => _signedAt;

  /// Whether a PNG confirmation attempt is in progress.
  bool get isSubmitting => _pending != null;

  /// Whether [submit] was attempted while the trimmed name is empty.
  bool get showsNameError => _validationRequested && _nameInvalid;

  /// Whether [submit] was attempted without a stroke that has movement.
  bool get showsSignatureError => _validationRequested && _signatureInvalid;

  bool get _nameInvalid => signerName.trim().isEmpty;
  bool get _signatureInvalid => _drawing.pointCount <= _drawing.strokeCount;

  void _edited() {
    _revision++;
    _result = null;
    notifyListeners();
  }

  void _nameEdited() {
    if (_name.text == _lastName) return;
    _lastName = _name.text;
    _edited();
  }

  void _drawingEdited() {
    _signedAt = _drawing.isEmpty ? null : _signedAt ?? DateTime.now();
    _edited();
  }

  /// Clears drawing and first-ink timestamp while retaining the entered name.
  /// The next drawing starts a new timestamp.
  void clear() {
    assert(
      ChangeNotifier.debugAssertNotDisposed(this),
      'Controller is disposed.',
    );
    _drawing.clear();
  }

  /// Validates both fields and captures a transparent ink-only PNG.
  ///
  /// Returns null and shows field errors for a blank trimmed name or a drawing
  /// made only of taps. Any moving stroke is accepted; no minimum length or
  /// business threshold is imposed.
  ///
  /// Uses the first-ink timestamp already displayed by the field. Name edits
  /// and additional strokes invalidate the result but retain this timestamp;
  /// Clear resets it. Unchanged retries reuse the same result and timestamp.
  /// Concurrent calls share the pending attempt. Edits, Clear or disposal during
  /// export invalidate that attempt: it returns null without publishing stale
  /// data. Export failures propagate to the caller and can be retried.
  Future<SigningResult?> submit() {
    assert(
      ChangeNotifier.debugAssertNotDisposed(this),
      'Controller is disposed.',
    );
    if (_pending case final pending?) return pending;
    _validationRequested = true;
    if (_nameInvalid || _signatureInvalid) {
      notifyListeners();
      return Future.value();
    }
    if (_result case final result?) return Future.value(result);
    _pending = _capture(
      _revision,
      signerName.trim(),
      _signedAt!,
    );
    notifyListeners();
    return _pending!;
  }

  Future<SigningResult?> _capture(
    int revision,
    String name,
    DateTime time,
  ) async {
    try {
      final png = await _drawing.toPngBytes();
      if (_disposed || revision != _revision || png == null) return null;
      return _result = SigningResult(
        signerName: name,
        pngBytes: png,
        signedAt: time,
      );
    } finally {
      _pending = null;
      if (!_disposed) notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _result = null;
    _signedAt = null;
    _drawing
      ..removeListener(_drawingEdited)
      ..dispose();
    _name
      ..removeListener(_nameEdited)
      ..dispose();
    super.dispose();
  }
}
