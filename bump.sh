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

brew bump-formula-pr \
  --no-audit --no-browse --force \
  --version="${version}" \
  "amrkmn/tap/${name}"
