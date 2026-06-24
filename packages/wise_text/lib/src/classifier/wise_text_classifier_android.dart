import 'package:jni/jni.dart';
import 'package:jni_flutter/jni_flutter.dart' as jnif;

import '../models/models.dart';
import 'classifier.dart';
import 'wise_text_classifier_android.g.dart';

/// Android implementation of [WiseTextClassifier] backed by the jnigen-generated
/// [WiseTextPlugin], which wraps the platform `TextClassifier`.
class WiseTextClassifierAndroid implements WiseTextClassifier {
  /// Creates [WiseTextClassifierAndroid] instance with native [WiseTextPlugin] using jni's context
  WiseTextClassifierAndroid() {
    final context = jnif.androidApplicationContext;
    _native = WiseTextPlugin(context.as(Context.type));
  }

  late final WiseTextPlugin _native;

  @override
  Future<List<ItemSpan>> classifyText(String text) async {
    // The native side returns the detected ranges as a flat int array of
    // (start, length, typeCode) triples. Dart already holds the source string,
    // so it rebuilds the full span list (including the plain-text gaps) from
    // those offsets. `getRange` copies the whole array out in a single JNI call.
    final array = await _native.classifyText(text.toJString());
    final triples = array.getRange(0, array.length);

    return ItemSpan.spansFromRanges(text, triples);
  }
}
