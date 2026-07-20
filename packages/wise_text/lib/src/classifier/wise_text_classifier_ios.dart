import 'package:objective_c/objective_c.dart' as objc;

import '../models/models.dart';
import 'classifier.dart';

/// iOS implementation of [WiseTextClassifierInterface] backed by the swiftgen-generated
/// [SwiftTextClassifier], which wraps `NSDataDetector`.
class WiseTextClassifierIos implements WiseTextClassifierInterface {
  /// Creates [WiseTextClassifierIos] instance with native swiftgen generated [SwiftTextClassifier]
  WiseTextClassifierIos() : _native = SwiftTextClassifier();

  final SwiftTextClassifier _native;

  @override
  Future<List<ItemSpan>> classifyText(String text) async {
    // The native side returns the detected ranges packed as little blocks of
    // three 32-bit ints — (start, length, typeCode) — in an NSData buffer.
    // Dart already holds the source string, so it rebuilds the full span list
    // (including the plain-text gaps) from those offsets.
    final data = _native.classifyTextWithText(text.toNSString());
    final triples = data.toList().buffer.asInt32List();

    return ItemSpan.spansFromRanges(text, triples);
  }

  @override
  void dispose() {
    _native.release();
  }
}
