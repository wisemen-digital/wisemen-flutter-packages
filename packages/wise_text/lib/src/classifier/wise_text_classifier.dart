import 'dart:io';

import '../models/models.dart';
import 'classifier.dart';

/// Classifies text into typed [ItemSpan]s (dates, addresses, links and phone
/// numbers) using the host platform's data detectors.
abstract class WiseTextClassifier {
  /// Gets a [WiseTextClassifier] instance for the current platform.
  static WiseTextClassifier get _instance {
    if (Platform.isIOS || Platform.isMacOS) return WiseTextClassifierIos();
    if (Platform.isAndroid) return WiseTextClassifierAndroid();
    throw UnsupportedError('WiseTextClassifier is not supported on this platform');
  }

  /// Splits [text] into an ordered list of spans covering the entire input.
  ///
  /// Detected items carry their [WiseTextItemType]; the runs between them are
  /// returned as [WiseTextItemType.text] spans so concatenating every
  /// [ItemSpan.text] reproduces the original [text].
  static Future<List<ItemSpan>> classify(String text) => _instance.classifyText(text);

  /// Instance's classifier function used by iOS and Android implementations
  Future<List<ItemSpan>> classifyText(String text);
}
