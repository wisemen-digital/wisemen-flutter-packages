# Working in this repo

A monorepo of Flutter packages published to pub.dev, managed with melos and a
pub workspace (every package sets `resolution: workspace`).

These are conventions for maintaining **this repo**. Guidance for writing
Flutter app code lives in `packages/*/skills/*.md`, which `sync_ai_skills.dart`
copies into consuming projects — don't put repo-maintenance rules there, they
are noise in a downstream app.

## Adding or changing a package

**pubspec.yaml** — match the other packages exactly (the shape was unified in
`46c8c6a`). Diverging here gets caught in review every time:

```yaml
name: <name>
description: <one line>
version: <x.y.z>
homepage: https://github.com/wisemen-digital/wisemen-flutter-packages/packages/<name>
repository: https://github.com/wisemen-digital/wisemen-flutter-packages/packages/<name>

environment:
  sdk: ">=3.10.0 <4.0.0"
  flutter: '>=3.19.5'
resolution: workspace
dependencies:
```

Note there is no blank line between `resolution: workspace` and
`dependencies:`, and the URLs use `/packages/<name>` — not `/tree/main/packages/<name>`.

**CHANGELOG.md** — describes the released package, not how the PR got there.
An initial release lists what the package does; it does not log the review
iterations ("removed X", "renamed Y") for code that never shipped.

**analysis_options.yaml** — packages should not have one. The analyzer walks up
to the root file, so a package-local file containing only
`include: ../../analysis_options.yaml` does nothing. If you need to exclude
generated code, add the path to the root file's `analyzer.exclude` list next to
`packages/sandbox/**`, keeping exclusions in one place.

**No generated code, and no `intl_utils` localization.** Apps here localize with
ARB files and generated `l10n.dart` — packages do not. Ship user-facing text as
an abstract class of plain getters with one implementation per language, the way
a package ships a theme class, and let the consumer register their own against a
locale. That keeps the package free of a build step, a `flutter_intl` pubspec
block, a `flutter_localizations` dependency, a `LocalizationsDelegate` the
consumer has to install, and an `analyzer.exclude` entry for the output.
`wise_feedback`'s `WiseFeedbackStrings` is the reference. Reach for generated
code in a package only when hand-writing genuinely does not make sense.

**.github/package-filters.yaml** — add an entry listing only the package's own
path:

```yaml
<name>:
  - 'packages/<name>/**'
```

Older entries also list `.github/actions/**` and `.github/workflows/**`; don't
copy that. A workflow edit should not rebuild every package.

**.github/workflows/publish.yml** — add `"<name>-v*"` to the tag list, or
tagging a release silently publishes nothing.

## Formatting

CI runs `dart format . --set-exit-if-changed` per package, and two things make
that stricter than it looks.

**The SDK constraint selects the formatter style.** Dart uses the short style
below language version 3.7 and the tall style at or above it. Raising a
package's `sdk:` constraint across that line reformats every file in it. That
is expected — land it as its own commit so the real change stays reviewable.

**Stay on the latest stable Flutter.** CI resolves `channel: stable`. An older
local Dart formats some constructs differently, so a locally clean package can
still fail CI.

## Stacked PRs

The `gh stack` extension (`gh stack view` / `rebase` / `submit`) manages the
branch chains here — reach for it before rebasing anything by hand. After the
bottom PR merges, `gh stack rebase` cascades the rest; `gh stack rebase --abort`
restores every branch if a rebase goes wrong.

**If you do rebase by hand, `git rebase <parent>` is the wrong command.** PRs
here land rebase-merged, so the parent's commits reach `main` with new SHAs. The
child branch still carries the originals, and any that were conflict-resolved on
the way in no longer match by patch-id — so git cannot tell they are already
upstream and replays them onto a base that has them, conflict by conflict.
Rebase the child's *own* commits instead:

```bash
git rebase --onto <new-parent-tip> <old-parent-tip>
```

`<old-parent-tip>` is the parent commit the child was branched from; everything
above it is the child's real work. Verify the split first with
`git log --oneline <old-parent-tip>..HEAD` — that should list only the child's
commits and nothing belonging to the parent.

Two things to watch when the merged PR changed shared API or formatting:

- Commits that exist only to satisfy the pre-merge state — "adopt <the API that
  was just deleted>", "satisfy CI dart format" — are obsolete. Drop them rather
  than resolving their conflicts.
- A PR whose diff touches no path in `package-filters.yaml` (anything only under
  `packages/sandbox/**`) generates no CI job. Its checks show as *skipping*,
  which is not the same as passing.
