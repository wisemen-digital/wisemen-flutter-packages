import 'dart:convert';
import 'dart:io';
import 'package:args/args.dart';

// 🛠️ Map your AI platforms to their respective local directories
const platformDirectories = {
  'claude-code': '.claude/skills',
};

void main(List<String> arguments) async {
  // 1. Setup CLI Argument Parser
  final parser = ArgParser()
    ..addMultiOption(
      'agent',
      abbr: 'a',
      help: 'Choose which AI platforms to install skills for.',
      allowed: platformDirectories.keys,
      defaultsTo: ['claude-code'], // Default if no flags are passed
    )
    ..addFlag('help', abbr: 'h', negatable: false, help: 'Show usage info.');

  final ArgResults argResults;
  try {
    argResults = parser.parse(arguments);
  } catch (e) {
    print('❌ Error: $e\n');
    print('Usage: dart run scripts/sync_ai_skills.dart [options]');
    print(parser.usage);
    exit(1);
  }

  if (argResults['help'] as bool) {
    print('Usage: dart run scripts/sync_ai_skills.dart [options]');
    print(parser.usage);
    exit(0);
  }

  final selectedAgents = argResults['agent'] as List<String>;
  print('🤖 Syncing AI skills for: ${selectedAgents.join(', ')}...\n');

  // 2. Read Dart's package cache
  final packageConfigFile = File('.dart_tool/package_config.json');
  if (!packageConfigFile.existsSync()) {
    print(
      '❌ Error: .dart_tool/package_config.json not found. Run `dart pub get` first.',
    );
    exit(1);
  }

  // 3. Ensure target directories exist
  for (final agent in selectedAgents) {
    final targetDir = Directory(platformDirectories[agent]!);
    if (!targetDir.existsSync()) {
      targetDir.createSync(recursive: true);
    }
  }

  // 4. Scan installed packages
  final config = jsonDecode(packageConfigFile.readAsStringSync());
  final packages = config['packages'] as List;
  final packageConfigDir = packageConfigFile.parent.uri;
  int copiedCount = 0;

  for (final package in packages) {
    final name = package['name'];
    final rootUri = packageConfigDir.resolve(package['rootUri'] as String);
    final packagePath = rootUri.toFilePath(windows: Platform.isWindows);

    // Look for a 'skills' folder in the package
    final sourceSkillsDir = Directory('$packagePath/skills');

    if (sourceSkillsDir.existsSync()) {
      print('📦 Found skills in package: $name');

      await for (final entity in sourceSkillsDir.list()) {
        if (entity is File) {
          final fileName = entity.uri.pathSegments.last;

          // 5. Copy the file to every selected platform's directory
          for (final agent in selectedAgents) {
            final targetDirPath = platformDirectories[agent]!;

            // Note: Cursor specifically prefers .mdc extensions, you could add logic
            // here to rename files if required by a specific platform.
            final destFile = File('$targetDirPath/${name}_$fileName');

            entity.copySync(destFile.path);
            copiedCount++;
            print('  -> Copied $fileName to $targetDirPath');
          }
        }
      }
    }
  }

  if (copiedCount == 0) {
    print('🤷‍♂️ No skills found in any of your installed packages.');
  } else {
    print('\n✅ Successfully synced $copiedCount skill file(s)!');
  }
}
