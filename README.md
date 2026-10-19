Wisemen Flutter packages monorepo

## sync_ai_skills

A Dart script that syncs AI skills from installed packages into your project for Claude Code. Each package can ship a `skills/` folder containing markdown documentation, and this script aggregates them all into the right place for Claude Code to pick up.

### What it does

1. Reads `.dart_tool/package_config.json` to find all installed packages
2. Looks for a `skills/` folder in each package
3. Copies every `.md` file found there into `.claude/skills/`, prefixed with the package name
4. Copies `main-skill.md` to `CLAUDE.md` in the project root, replacing the existing file

### Prerequisites

Run `dart pub get` (or `melos bs`) from the workspace root before running the script.

### Usage

Run from your workspace root:

```sh
# Sync skills
dart run wisecore:sync_ai_skills

# Show help
dart run wisecore:sync_ai_skills --help
```

### Adding skills to a package

Create a `skills/` folder inside your package and add markdown files:

```
packages/
  mypackage/
    skills/
      mypackage.md   ← your skill documentation
    lib/
    ...
```

The file will be copied as `mypackage_mypackage.md` into `.claude/skills/`.
