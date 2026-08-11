#!/usr/bin/env bash
# Bump all outdated formulae found by livecheck.
# Creates a bump-<name>-<version> branch and PR for each formula via
# `brew bump-formula-pr`. Writes skipped/bumped/failed summaries to GITHUB_OUTPUT.
set -euo pipefail

# Formulae that require manual updates (e.g., pip dependency resolution issues)
SKIP_FORMULAE=("")

SKIPPED=""
BUMPED=""
FAILED=""

jq -c '.[] | select(.status != "skipped") | select(.version.latest != .version.current)' livecheck.json | while read -r formula; do
    name="$(echo "$formula" | jq -r .formula)"
    new_ver="$(echo "$formula" | jq -r .version.latest)"

    # Check if this formula should be skipped
    skip=false
    for skip_name in "${SKIP_FORMULAE[@]}"; do
        if [[ "$name" == "$skip_name" ]]; then
            echo "⏭️  Skipping $name $new_ver (requires manual update)"
            SKIPPED="${SKIPPED}${name}@${new_ver}\n"
            skip=true
            break
        fi
    done
    [[ "$skip" == true ]] && continue

    # Skip if branch already exists remotely
    if git ls-remote --heads origin "bump-${name}-${new_ver}" | grep -q .; then
        echo "Skipping $name $new_ver - branch already exists"
        continue
    fi

    if brew bump-formula-pr \
        --no-audit --no-browse --force \
        --version="$new_ver" \
        "amrkmn/tap/${name}" 2>&1; then
        echo "✅ Bumped $name to $new_ver"
        BUMPED="${BUMPED}${name}@${new_ver}\n"
    else
        echo "❌ Failed to bump $name to $new_ver"
        FAILED="${FAILED}${name}@${new_ver}\n"
    fi
done

# Save to environment for next step
{
    echo "skipped<<EOF"
    echo -e "$SKIPPED"
    echo "EOF"
    echo "bumped<<EOF"
    echo -e "$BUMPED"
    echo "EOF"
    echo "failed<<EOF"
    echo -e "$FAILED"
    echo "EOF"
} >> "$GITHUB_OUTPUT"
