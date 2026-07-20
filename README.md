Wisemen Flutter packages monorepo

| Package                                              |                    Documentation                     |                                                       pub                                                        |                                          CI                                          |
| ----------------------------------------------------- | :---------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------: | :-------------------------------------------------------------------------------------: |
| [`wise_nav_bar`][wise_nav_bar-link]                   |     [Documentation][wise_nav_bar-documentation]      |         [![wise_nav_bar pub.dev badge][wise_nav_bar-pub-badge]][wise_nav_bar-pub-badge-link]         | [![][ci-build-badge]][ci-build-badge-link] |
| [`wise_review`][wise_review-link]                     |       [Documentation][wise_review-documentation]       |            [![wise_review pub.dev badge][wise_review-pub-badge]][wise_review-pub-badge-link]            | [![][ci-build-badge]][ci-build-badge-link] |
| [`wise_scalars`][wise_scalars-link]                   |      [Documentation][wise_scalars-documentation]      |          [![wise_scalars pub.dev badge][wise_scalars-pub-badge]][wise_scalars-pub-badge-link]          | [![][ci-build-badge]][ci-build-badge-link] |
| [`wise_theming`][wise_theming-link]                   |      [Documentation][wise_theming-documentation]      |          [![wise_theming pub.dev badge][wise_theming-pub-badge]][wise_theming-pub-badge-link]          | [![][ci-build-badge]][ci-build-badge-link] |
| [`wise_zitadel_login`][wise_zitadel_login-link]       |   [Documentation][wise_zitadel_login-documentation]   |    [![wise_zitadel_login pub.dev badge][wise_zitadel_login-pub-badge]][wise_zitadel_login-pub-badge-link]    | [![][ci-build-badge]][ci-build-badge-link] |
| [`wiseclient`][wiseclient-link]                       |       [Documentation][wiseclient-documentation]       |            [![wiseclient pub.dev badge][wiseclient-pub-badge]][wiseclient-pub-badge-link]            | [![][ci-build-badge]][ci-build-badge-link] |
| [`wisecore`][wisecore-link]                           |        [Documentation][wisecore-documentation]        |              [![wisecore pub.dev badge][wisecore-pub-badge]][wisecore-pub-badge-link]              | [![][ci-build-badge]][ci-build-badge-link] |
| [`wisewidgetslibrary`][wisewidgetslibrary-link]       |   [Documentation][wisewidgetslibrary-documentation]   |    [![wisewidgetslibrary pub.dev badge][wisewidgetslibrary-pub-badge]][wisewidgetslibrary-pub-badge-link]    | [![][ci-build-badge]][ci-build-badge-link] |

CI runs as a single matrix workflow ([Run linter and analyze][ci-build-badge-link]) that only tests the packages affected by a given change, so all rows share the same badge.

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

## For maintainers

### pub.dev release process

1. Create a pull request with your changes
2. Update `pubspec.yaml` with appropriate package version and add an entry to your package's `CHANGELOG.md`
3. Gather approvals and ensure CI passes
4. Merge
5. Tag your merge commit on `main` with `<package_name>-v<version>` and let the GitHub Actions do the rest.

[wise_nav_bar-link]: https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wise_nav_bar
[wise_nav_bar-documentation]: https://pub.dev/documentation/wise_nav_bar/latest/
[wise_nav_bar-pub-badge]: https://img.shields.io/pub/v/wise_nav_bar
[wise_nav_bar-pub-badge-link]: https://pub.dev/packages/wise_nav_bar

[wise_review-link]: https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wise_review
[wise_review-documentation]: https://pub.dev/documentation/wise_review/latest/
[wise_review-pub-badge]: https://img.shields.io/pub/v/wise_review
[wise_review-pub-badge-link]: https://pub.dev/packages/wise_review

[wise_scalars-link]: https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wise_scalars
[wise_scalars-documentation]: https://pub.dev/documentation/wise_scalars/latest/
[wise_scalars-pub-badge]: https://img.shields.io/pub/v/wise_scalars
[wise_scalars-pub-badge-link]: https://pub.dev/packages/wise_scalars

[wise_theming-link]: https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wise_theming
[wise_theming-documentation]: https://pub.dev/documentation/wise_theming/latest/
[wise_theming-pub-badge]: https://img.shields.io/pub/v/wise_theming
[wise_theming-pub-badge-link]: https://pub.dev/packages/wise_theming

[wise_zitadel_login-link]: https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wise_zitadel_login
[wise_zitadel_login-documentation]: https://pub.dev/documentation/wise_zitadel_login/latest/
[wise_zitadel_login-pub-badge]: https://img.shields.io/pub/v/wise_zitadel_login
[wise_zitadel_login-pub-badge-link]: https://pub.dev/packages/wise_zitadel_login

[wiseclient-link]: https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wiseclient
[wiseclient-documentation]: https://pub.dev/documentation/wiseclient/latest/
[wiseclient-pub-badge]: https://img.shields.io/pub/v/wiseclient
[wiseclient-pub-badge-link]: https://pub.dev/packages/wiseclient

[wisecore-link]: https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wisecore
[wisecore-documentation]: https://pub.dev/documentation/wisecore/latest/
[wisecore-pub-badge]: https://img.shields.io/pub/v/wisecore
[wisecore-pub-badge-link]: https://pub.dev/packages/wisecore

[wisewidgetslibrary-link]: https://github.com/wisemen-digital/wisemen-flutter-packages/tree/main/packages/wisewidgetslibrary
[wisewidgetslibrary-documentation]: https://pub.dev/documentation/wisewidgetslibrary/latest/
[wisewidgetslibrary-pub-badge]: https://img.shields.io/pub/v/wisewidgetslibrary
[wisewidgetslibrary-pub-badge-link]: https://pub.dev/packages/wisewidgetslibrary

[ci-build-badge]: https://img.shields.io/github/actions/workflow/status/wisemen-digital/wisemen-flutter-packages/package_check.yml?branch=main&label=CI
[ci-build-badge-link]: https://github.com/wisemen-digital/wisemen-flutter-packages/actions/workflows/package_check.yml
