#!/usr/bin/env bash
# Send a notification to the ntfy topic.
# Usage: ntfy.sh <title> <message>
set -euo pipefail

title="${1:?usage: ntfy.sh <title> <message>}"
message="${2:?usage: ntfy.sh <title> <message>}"

: "${NTFY_URL:?NTFY_URL must be set}"

# Support both Bearer token and Basic auth
if [[ -n "${NTFY_TOKEN:-}" ]]; then
    # Bearer token authentication
    curl -X POST \
        -H "Authorization: Bearer ${NTFY_TOKEN}" \
        -H "Title: ${title}" \
        -d "$(echo -e "${message}")" \
        "${NTFY_URL}/homebrew-tap"
elif [[ -n "${NTFY_AUTH:-}" ]]; then
    # Basic auth (username:password in base64)
    curl -X POST \
        -H "Authorization: Basic ${NTFY_AUTH}" \
        -H "Title: ${title}" \
        -d "$(echo -e "${message}")" \
        "${NTFY_URL}/homebrew-tap"
else
    # No auth
    curl -X POST \
        -H "Title: ${title}" \
        -d "$(echo -e "${message}")" \
        "${NTFY_URL}/homebrew-tap"
fi
