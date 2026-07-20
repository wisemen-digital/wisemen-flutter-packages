// Generates Dart bindings for the iOS `SwiftTextClassifier`.
//
// The Swift source is already `@objc`-compatible (it only exposes a method that
// takes and returns `String`), so we feed it in as an [ObjCCompatibleSwiftFileInput]
// and no Swift wrapper layer needs to be generated.
//
// Run with: `dart run gen/swiftgen.dart` from the package root.

import 'package:ffigen/ffigen.dart' as fg;
import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:swift2objc/swift2objc.dart' as swift2objc;
import 'package:swiftgen/swiftgen.dart';

Future<void> main() async {
  final logger = Logger('swiftgen')
    ..onRecord.listen((record) {
      // ignore: avoid_print
      print('${record.level.name}: ${record.message}');
    });

  await SwiftGenerator(
    target: await Target.iOSArm64Latest(),
    inputs: [
      ObjCCompatibleSwiftFileInput(
        files: [
          Uri.file('ios/wise_text/Sources/wise_text/SwiftTextClassifier.swift'),
        ],
      ),
    ],
    include: (swift2objc.Declaration d) => d.name == 'SwiftTextClassifier',
    output: Output(
      // Must match the module the plugin's Swift compiles into, which for a
      // Flutter plugin is the plugin name.
      module: 'wise_text',
      dartFile: Uri.file('lib/src/classifier/swift_text_classifier.dart'),
      // Generated Objective-C stubs; placed under ios/Classes so the podspec
      // (source_files: 'Classes/**/*') compiles them into the plugin.
      objectiveCFile: Uri.file(
        'ios/wise_text/Sources/wise_text/SwiftTextClassifier.m',
      ),
      preamble:
          '// ignore_for_file: type=lint\n'
          '// coverage:ignore-file\n',
    ),
    ffigen: FfiGeneratorOptions(
      objectiveC: fg.ObjectiveC(
        externalVersions: fg.ExternalVersions(
          ios: fg.Versions(min: Version(15, 0, 0)),
        ),
        interfaces: fg.Interfaces(
          include: (decl) => decl.originalName == 'SwiftTextClassifier',
        ),
      ),
    ),
  ).generate(logger: logger, tempDirectory: Uri.directory('temp'));
}
