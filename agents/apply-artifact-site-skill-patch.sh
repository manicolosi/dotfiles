#!/usr/bin/env bash
# (Re)insert the nicolosi deployment section into the artifact-site agent skill.
# Idempotent: drops any previously inserted copy (between the nicolosi-deployment
# markers) before inserting fresh. Safe to run after `npx skills add
# lexmount/artifact-site` reinstalls/overwrites the upstream SKILL.md.
#
# Usage: apply-artifact-site-skill-patch.sh [path-to-SKILL.md]
set -euo pipefail

SKILL="${1:-$HOME/.agents/skills/artifact-site/SKILL.md}"
SECTION="$(cd "$(dirname "$0")" && pwd)/artifact-site-deployment.md"
ANCHOR='^## Get the deployment.s current guide$'

if [[ ! -f "$SKILL" ]]; then
  echo "skill not found: $SKILL" >&2
  echo "install it first: npx skills add lexmount/artifact-site" >&2
  exit 1
fi
if [[ ! -f "$SECTION" ]]; then
  echo "section file missing: $SECTION" >&2
  exit 1
fi

tmp="$(mktemp)"
# 1) drop any previous copy of the marked section
awk '
  /<!-- nicolosi-deployment:start -->/ { skip = 1; next }
  /<!-- nicolosi-deployment:end -->/   { skip = 0; next }
  !skip
' "$SKILL" > "$tmp"
# 2) insert the section ahead of the guide-fetch heading
awk -v section="$SECTION" '
  $0 ~ ANCHOR && !done {
    while ((getline line < section) > 0) print line
    close(section)
    print ""
    done = 1
  }
  { print }
' ANCHOR="$ANCHOR" "$tmp" > "$SKILL"
rm -f "$tmp"

echo "patched: $SKILL"
