#!/usr/bin/env bash
# Base64-encode GH_TOKEN for HOMEBREW_DOCKER_REGISTRY_TOKEN.
# Requires TOKEN env var. Writes token=... to GITHUB_OUTPUT.
set -euo pipefail

base64_token=$(echo -n "${TOKEN}" | base64 | tr -d "\n")
echo "::add-mask::${base64_token}"
echo "token=${base64_token}" >> "${GITHUB_OUTPUT}"
