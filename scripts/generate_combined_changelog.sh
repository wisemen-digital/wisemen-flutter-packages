#!/usr/bin/env sh
set -eu

# Appends a new dated section to a combined changelog built from every package
# listed in .github/package-filters.yaml, covering a rolling look-back window.
#
# Each run PREPENDS a section (newest first), separated by a '---' divider, so
# the file accumulates a history of runs rather than being overwritten.
#
# A run section contains, per package:
#   1. The package name.
#   2. New CHANGELOG.md entries added within the window (git diff additions).
#   3. Pull requests that impacted the package (Phase 2 — label based).
#
# Usage (run from the repository root):
#   scripts/generate_combined_changelog.sh --days 7 --out COMBINED_CHANGELOG.md
#
# POSIX sh compatible — runs under sh, bash, or via ./ (the shebang).

DAYS=7
OUT="COMBINED_CHANGELOG.md"
FILTERS=".github/package-filters.yaml"

# Git's canonical empty-tree hash, used as the diff base when the repository
# has no commit older than the look-back window.
EMPTY_TREE="4b825dc642cb6eb9a060e54bf8d69288fbee4904"

while [ $# -gt 0 ]; do
  case "$1" in
    --days) DAYS="$2"; shift 2 ;;
    --out) OUT="$2"; shift 2 ;;
    --filters) FILTERS="$2"; shift 2 ;;
    -h|--help)
      cat <<'EOF'
Generate a combined changelog from all packages in package-filters.yaml.
Each run prepends a new dated section rather than overwriting the file.

Usage:
  scripts/generate_combined_changelog.sh [options]

Options:
  --days <n>        Look-back window in days (default: 7).
  --out <path>      Output file path (default: COMBINED_CHANGELOG.md).
  --filters <path>  Path to package-filters.yaml (default: .github/package-filters.yaml).
  -h, --help        Show this help.
EOF
      exit 0 ;;
    *) echo "❌ Unknown argument: $1" >&2; exit 1 ;;
  esac
done

case "$DAYS" in
  ''|*[!0-9]*) echo "❌ Error: --days must be a positive integer." >&2; exit 1 ;;
esac
if [ "$DAYS" -le 0 ]; then
  echo "❌ Error: --days must be a positive integer." >&2
  exit 1
fi

if [ ! -f "$FILTERS" ]; then
  echo "❌ Error: $FILTERS not found. Run from the repository root." >&2
  exit 1
fi

# 1. Package names = the top-level YAML keys (no indentation, ending in ':').
#    Package names are simple identifiers, so word-splitting the list is safe.
PACKAGES="$(grep -E '^[A-Za-z0-9_]+:[[:space:]]*$' "$FILTERS" | sed 's/:.*//')"
if [ -z "$PACKAGES" ]; then
  echo "❌ Error: no packages found in $FILTERS." >&2
  exit 1
fi
echo "📦 Packages: $(echo "$PACKAGES" | tr '\n' ' ')"

# 2. Resolve the diff base: the newest commit older than the window.
BASE="$(git rev-list -1 --before="${DAYS} days ago" HEAD || true)"
if [ -z "$BASE" ]; then
  FROM="$EMPTY_TREE"
  START="the beginning"
  echo "⚠️  No commit older than ${DAYS} days; diffing against the empty tree."
else
  FROM="$BASE"
  START="$(git show -s --format=%cs "$BASE")"
fi
TODAY="$(date +%F)"

# Scratch files for this run's new section and the reassembled file.
TMP_DIR="${TMPDIR:-/tmp}"
NEWBLOCK="${TMP_DIR}/cc_block.$$"
PRIOR="${TMP_DIR}/cc_prior.$$"
ASSEMBLED="${TMP_DIR}/cc_all.$$"
trap 'rm -f "$NEWBLOCK" "$PRIOR" "$ASSEMBLED"' EXIT

# 3. Build this run's per-package sections.
: > "$NEWBLOCK"
ANY=0
for pkg in $PACKAGES; do
  path="packages/${pkg}/CHANGELOG.md"

  # Added CHANGELOG lines, minus the '+++' header, with the leading '+'
  # stripped, headings demoted three levels so a changelog's '## 1.2.3' nests
  # under the run ('##'), package ('###') and '#### Changelog additions', and
  # leading / trailing blank lines trimmed. '|| true' keeps an empty grep from
  # aborting under set -e.
  additions="$(
    git diff --no-color "$FROM" HEAD -- "$path" \
      | grep '^+' | grep -v '^+++' \
      | sed 's/^+//' \
      | sed -E 's/^(#+ )/###\1/' \
      | awk '{ l[NR]=$0 }
             END {
               s=1; e=NR;
               while (s<=e && l[s] ~ /^[[:space:]]*$/) s++;
               while (e>=s && l[e] ~ /^[[:space:]]*$/) e--;
               for (i=s; i<=e; i++) print l[i];
             }' \
      || true
  )"

  [ -z "$additions" ] && continue
  ANY=1

  {
    echo "### ${pkg}"
    echo
    echo "#### Changelog additions"
    echo
    echo "$additions"
    echo
    echo "#### Pull requests"
    echo
    echo "_Pending — populated from PR labels (coming soon)._"
    echo
  } >> "$NEWBLOCK"
done

if [ "$ANY" -eq 0 ]; then
  echo "ℹ️  No changelog changes in the last ${DAYS} days; leaving ${OUT} unchanged."
  exit 0
fi

# 4. Extract prior run sections (existing file minus its title). Drop a leading
#    section from the same run date so re-running today replaces it rather than
#    stacking a duplicate.
: > "$PRIOR"
if [ -f "$OUT" ]; then
  awk -v today="$TODAY" '
    BEGIN { started = 0; skip = 0 }
    {
      if (started == 0) {
        if ($0 == "# Combined changelog") next
        if ($0 == "") next
        started = 1
        if (index($0, "## " today " ") == 1) { skip = 1; next }
      }
      if (skip == 1) {
        if ($0 == "---") skip = 0
        next
      }
      print
    }
  ' "$OUT" > "$PRIOR"
fi

# 5. Reassemble: title, this run's section, divider + prior sections.
{
  echo "# Combined changelog"
  echo
  echo "## ${TODAY} — window ${START} → ${TODAY}"
  echo
  cat "$NEWBLOCK"
  if [ -s "$PRIOR" ]; then
    echo "---"
    echo
    cat "$PRIOR"
  fi
} > "$ASSEMBLED"
mv "$ASSEMBLED" "$OUT"

echo "✅ Updated $OUT"
