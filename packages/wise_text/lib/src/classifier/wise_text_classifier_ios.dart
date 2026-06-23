import 'dart:convert';

import 'package:objective_c/objective_c.dart' as objc;

import 'item_span.dart';
import 'wise_text_bindings.dart' as bindings;
import 'wise_text_classifier.dart';

/// iOS implementation of [WiseTextClassifier] backed by the swiftgen-generated
/// [bindings.SwiftTextClassifier], which wraps `NSDataDetector`.
class WiseTextClassifierIos implements WiseTextClassifier {
  WiseTextClassifierIos() : _native = bindings.SwiftTextClassifier();

  final bindings.SwiftTextClassifier _native;

  @override
  List<ItemSpan> classifyText(String text) {
    final json = _native
        .classifyTextWithText(text.toNSString())
        .toDartString();

    final decoded = jsonDecode(json);
    if (decoded is! List) return [];

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(ItemSpan.fromJson)
        .toList(growable: false);
  }
}
