#!/usr/bin/env bash
# Close stale/failed bump PRs and delete their branches so that
# `brew livecheck` can re-bump the formula.
#
# A bump PR is considered stale when:
#   1. its test-bot checks failed (e.g. a too-young npm/pip release being
#      blocked by Homebrew's 1-day release cooldown, or a GitHub Actions
#      outage that failed the runs), or
#   2. it has been open for at least MAX_AGE_DAYS days without merging.
#
# Only PRs whose head branch matches `bump-*` are touched; manually created
# PRs are left alone.
set -euo pipefail

REPO="${GITHUB_REPOSITORY}"
MAX_AGE_DAYS="${MAX_AGE_DAYS:-3}"

CLOSED=""
KEPT=""

while read -r pr; do
    number="$(echo "$pr" | jq -r .number)"
    head="$(echo "$pr" | jq -r .headRefName)"
    title="$(echo "$pr" | jq -r .title)"
    created="$(echo "$pr" | jq -r .createdAt)"

    # Only auto-generated bump branches
    [[ "$head" != bump-* ]] && continue

    # Age of the PR in days
    age_days=$(( ( $(date -u +%s) - $(date -u -d "$created" +%s) ) / 86400 ))

    # Check conclusions of the test-bot checks on the head commit
    sha="$(gh pr view "$number" --repo "$REPO" --json headRefOid --jq .headRefOid)"
    conclusions="$(gh api "repos/${REPO}/commits/${sha}/check-runs" \
        --jq '[.check_runs[] | select(.name | contains("test-bot")) | .conclusion] | unique | join(",")' \
        2>/dev/null || true)"

    reason=""
    if echo "$conclusions" | grep -qE "failure|timed_out|action_required|cancelled"; then
        reason="failed checks (${conclusions})"
    elif [[ ${age_days} -ge ${MAX_AGE_DAYS} ]]; then
        reason="open ${age_days} days (max ${MAX_AGE_DAYS})"
    fi

    if [[ -z "$reason" ]]; then
        echo "Keeping #${number} ${head}"
        KEPT="${KEPT}#${number} ${head}\n"
        continue
    fi

    echo "Closing #${number} ${head}: ${reason}"
    if gh pr close "$number" --repo "$REPO" --delete-branch \
        --comment "Closed automatically: ${reason}. Branch deleted so \`brew livecheck\` can re-bump once the release is ready (e.g. after the 1-day npm/pip release cooldown)."; then
        CLOSED="${CLOSED}#${number} ${head} (${reason})\n"
    else
        # Fallback: delete the remote branch via the API if --delete-branch failed
        gh api -X DELETE "repos/${REPO}/git/refs/heads/${head}" >/dev/null 2>&1 || true
        CLOSED="${CLOSED}#${number} ${head} (${reason})\n"
    fi
done < <(gh pr list --repo "$REPO" --state open --json number,headRefName,createdAt,title \
    --jq '.[] | select(.headRefName | startswith("bump-"))')

{
    echo "closed<<EOF"
    echo -e "$CLOSED"
    echo "EOF"
    echo "kept<<EOF"
    echo -e "$KEPT"
    echo "EOF"
} >> "$GITHUB_OUTPUT"
