// ignore_for_file: avoid_dynamic_calls, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';

const skillsDirectory = '.claude/skills';

void main(List<String> arguments) async {
  // 1. Setup CLI Argument Parser
  final parser = ArgParser()
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

  print('🤖 Syncing AI skills for Claude Code...\n');

  // 2. Read Dart's package cache
  final packageConfigFile = File('.dart_tool/package_config.json');
  if (!packageConfigFile.existsSync()) {
    print(
      '❌ Error: .dart_tool/package_config.json not found. Run `dart pub get` first.',
    );
    exit(1);
  }

  // 3. Ensure the target directory exists
  final targetDir = Directory(skillsDirectory);
  if (!targetDir.existsSync()) {
    targetDir.createSync(recursive: true);
  }

  // 4. Scan installed packages
  final config = jsonDecode(packageConfigFile.readAsStringSync());
  final packages = config['packages'] as List;
  final packageConfigDir = packageConfigFile.parent.uri;
  var copiedCount = 0;

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

          // 5. Copy the file into the project
          // Special case: main-skill.md becomes the project's CLAUDE.md
          if (fileName == 'main-skill.md') {
            entity.copySync('CLAUDE.md');
            copiedCount++;
            print('  -> Copied $fileName to CLAUDE.md');
            continue;
          }

          final destFileName = '${name}_$fileName';
          entity.copySync('$skillsDirectory/$destFileName');
          copiedCount++;
          print('  -> Copied $fileName to $skillsDirectory/$destFileName');
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
