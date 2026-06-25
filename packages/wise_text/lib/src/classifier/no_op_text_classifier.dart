import '../models/models.dart';
import 'wise_text_classifier.dart';

/// [NoOpTextClassifier] for platforms that don't have a native text classifier
class NoOpTextClassifier implements WiseTextClassifierInterface {
  @override
  Future<List<ItemSpan>> classifyText(String text) {
    return Future.value([ItemSpan(text: text, type: WiseTextItemType.text)]);
  }
}
