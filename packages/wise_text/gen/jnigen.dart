// Generates Dart bindings for the Android `WiseTextPlugin` Kotlin class.
//
// Unlike the iOS swiftgen pipeline (which can summarize Swift source directly),
// jnigen's source summarizer only understands Java source. Our plugin is
// written in Kotlin, so the class is resolved from *compiled bytecode* instead:
// `addGradleDeps: true` together with `androidExample` makes jnigen build the
// example app — which compiles this plugin — and use the resulting Gradle
// classpath to find `WiseTextPlugin` and the Android SDK types it references.
//
// Because of that, do NOT set `sourcePath` to the Kotlin directory: jnigen would
// then try to parse the `.kt` files as Java, fail to find the class, and emit a
// truncated summary ("Not found" / FormatException).
//
// Run with: `dart run gen/jnigen.dart` from the package root.

import 'dart:io';

import 'package:jnigen/jnigen.dart';
import 'package:logging/logging.dart';

Future<void> main() async {
  Logger.root
    ..level = Level.INFO
    ..onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.message}');
    });
  final packageRoot = Platform.script.resolve('../');
  await generateJniBindings(
    Config(
      outputConfig: OutputConfig(
        dartConfig: DartCodeOutputConfig(
          path: packageRoot.resolve('lib/src/classifier/wise_text_classifier_android.g.dart'),
          structure: OutputStructure.singleFile,
        ),
      ),
      // Builds the example app to compile the plugin and collect its full
      // classpath (the plugin's own classes + the Android SDK). This is how the
      // Kotlin `WiseTextPlugin` class and types like Context/TextClassifier are
      // resolved.
      androidSdkConfig: AndroidSdkConfig(addGradleDeps: true, androidExample: 'example/'),
      classes: ['com.example.wise_text.WiseTextPlugin'],
    ),
  );
}
