#!/bin/bash
# commit_message.sh
# Description: Describe changes to the generated SteamCMD output as a commit
# message. Outputs an empty message if nothing changed.

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

version="$(cat steamcmd_version.txt 2> /dev/null || true)"
version="${version:-unknown}"

# Include new, untracked output files in git diff.
git add --intent-to-add -- 'steamcmd_*.txt'

mapfile -t changed < <(git diff --name-only -- 'steamcmd_*.txt' | grep -v '^steamcmd_version\.txt$' || true)

message=""
if [ "${#changed[@]}" -gt 0 ]; then
  message="SteamCMD help changed: ${changed[*]} (version ${version})"
elif ! git diff --quiet -- steamcmd_version.txt; then
  message="SteamCMD updated to version ${version} (help output unchanged)"
fi

echo "message: ${message:-<none>}"
if [ -n "${GITHUB_OUTPUT:-}" ]; then
  echo "message=${message}" >> "${GITHUB_OUTPUT}"
fi
