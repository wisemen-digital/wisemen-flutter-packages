// ignore_for_file: one_member_abstracts

import 'dart:io';

import '../models/models.dart';
import 'classifier.dart';

/// Classifies text into typed [ItemSpan]s (dates, addresses, links and phone
/// numbers) using the host platform's data detectors.
class WiseTextClassifier {
  /// Creates [WiseTextClassifier] instance with [WiseTextClassifierInterface] platform implementation or given classifier
  WiseTextClassifier({WiseTextClassifierInterface? classifier})
    : instance = switch (classifier) {
        WiseTextClassifierInterface() => classifier,
        null when Platform.isIOS || Platform.isMacOS => WiseTextClassifierIos(),
        null when Platform.isAndroid => WiseTextClassifierAndroid(),
        null => NoOpTextClassifier(),
      };

  /// Platform [WiseTextClassifierInterface] implementation that can natively call `classifyText`
  final WiseTextClassifierInterface instance;

  /// Splits [text] into an ordered list of spans covering the entire input.
  ///
  /// Detected items carry their [WiseTextItemType]; the runs between them are
  /// returned as [WiseTextItemType.text] spans so concatenating every
  /// [ItemSpan.text] reproduces the original [text].
  Future<List<ItemSpan>> classify(String text) => instance.classifyText(text);

  /// Disposes of native references used by FFI classes
  void dispose() => instance.dispose();
}

/// Classifies text into typed [ItemSpan]s (dates, addresses, links and phone
/// numbers) using the host platform's data detectors.
abstract interface class WiseTextClassifierInterface {
  /// Instance's classifier function used by iOS and Android implementations
  Future<List<ItemSpan>> classifyText(String text);

  /// Dispose used FFI elements on platforms
  void dispose();
}
