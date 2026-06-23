import 'dart:io';

import 'item_span.dart';
import 'wise_text_classifier_ios.dart';

/// Classifies text into typed [ItemSpan]s (dates, addresses, links, phone
/// numbers and transit info) using the host platform's data detectors.
abstract class WiseTextClassifier {
  /// Creates a [WiseTextClassifier] instance for the current platform.
  factory WiseTextClassifier() {
    if (Platform.isIOS) return WiseTextClassifierIos();
    throw UnsupportedError(
      'WiseTextClassifier is not supported on this platform',
    );
  }

  /// Splits [text] into an ordered list of spans covering the entire input.
  ///
  /// Detected items carry their [WiseTextItemType]; the runs between them are
  /// returned as [WiseTextItemType.text] spans so concatenating every
  /// [ItemSpan.text] reproduces the original [text].
  List<ItemSpan> classifyText(String text);
}
