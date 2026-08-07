#!/usr/bin/env bash
# Run brew livecheck and print the outdated formulae.
# The output is also saved to livecheck.json for the bump step.
set -euo pipefail

brew livecheck --tap="$GITHUB_REPOSITORY" --json > livecheck.json
jq -c '.[] | select(.status != "skipped") | select(.version.latest != .version.current)' livecheck.json
