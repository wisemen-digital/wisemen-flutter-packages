Wisemen Flutter packages monorepo

## sync_ai_skills

A Dart script that syncs AI skills from installed packages into your local AI tool configuration. Each package can ship a `skills/` folder containing markdown documentation, and this script aggregates them all into the right place for your AI assistant to pick up.

### What it does

1. Reads `.dart_tool/package_config.json` to find all installed packages
2. Looks for a `skills/` folder in each package
3. Copies every `.md` file found there into the target AI platform's directory, prefixed with the package name

### Supported platforms

| Platform | Flag value | Target directory | File extension |
|---|---|---|---|
| Claude Code | `claude-code` | `.claude/skills/` | `.md` |
| GitHub Copilot | `copilot` | `.github/instructions/` | `.instructions.md` |

Copilot files are automatically prefixed with `applyTo: "**"` frontmatter so they are applied across all files.

### Prerequisites

Run `dart pub get` (or `melos bs`) from the workspace root before running the script.

### Usage

Run from your workspace root:

```sh
# Sync for Claude Code only (default)
dart run wisecore:sync_ai_skills

# Sync for GitHub Copilot only
dart run wisecore:sync_ai_skills --agent copilot

# Sync for both Claude Code and Copilot
dart run wisecore:sync_ai_skills --agent claude-code --agent copilot

# Short flag form
dart run wisecore:sync_ai_skills -a claude-code -a copilot

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

The file will be copied as `mypackage_mypackage.md` (or `.instructions.md` for Copilot) into the platform directory.
