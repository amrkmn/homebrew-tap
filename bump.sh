#!/usr/bin/env bash
#
# Bump a single formula the same way the livecheck workflow does:
# creates the bump-<name>-<version> branch, applies the version bump,
# commits, pushes, and opens a PR. Never touches main directly.
#
# Usage: ./bump.sh <formula> <version>

set -euo pipefail

if [[ $# -ne 2 ]]
then
  echo "Usage: $0 <formula> <version>" >&2
  exit 1
fi

name="$1"
version="$2"
branch="bump-${name}-${version}"

# Guard from livecheck.yml: skip if branch already exists
if git ls-remote --heads origin "${branch}" | grep -q .
then
  echo "Skipping ${name} ${version} - branch '${branch}' already exists"
  exit 0
fi

bump_args=(
  --no-audit --no-browse --force
  --install-dependencies
  --version="${version}"
)

# Check for livechecked resources if available
if livecheck_out="$(brew livecheck --quiet --resources --json "amrkmn/tap/${name}" 2>/dev/null)"
then
  resource_versions="$(echo "${livecheck_out}" | jq -c '.[0] | [.resources[]? | select(.status != "skipped" and .version.latest != null) | {name: .resource, current_version: .version.current, latest_version: .version.latest}]' 2>/dev/null || true)"
  if [[ -n "${resource_versions}" && "${resource_versions}" != "[]" ]]
  then
    bump_args+=("--resource-versions=${resource_versions}")
  fi
fi

brew bump-formula-pr "${bump_args[@]}" "amrkmn/tap/${name}"
