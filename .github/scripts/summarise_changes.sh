#!/bin/bash
# summarise_changes.sh
# Description: Describe changes to the generated SteamCMD output. Prepends an
# entry to CHANGELOG.md and outputs a commit message. Outputs an empty message
# if nothing changed.

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

changelog="CHANGELOG.md"
repo_url="https://github.com/${GITHUB_REPOSITORY:-dgibbs64/SteamCMD-Help-List}"
version="$(cat steamcmd_version.txt 2> /dev/null || echo "unknown")"

# Include new, untracked output files in git diff.
git add --intent-to-add -- 'steamcmd_*.txt'

mapfile -t changed < <(git diff --name-only -- 'steamcmd_*.txt' | grep -v '^steamcmd_version\.txt$' || true)
version_changed=false
if ! git diff --quiet -- steamcmd_version.txt; then
  version_changed=true
fi

message=""
if [ "${#changed[@]}" -gt 0 ]; then
  message="SteamCMD help changed: ${changed[*]} (version ${version})"
elif [ "${version_changed}" = true ]; then
  message="SteamCMD updated to version ${version} (help output unchanged)"
fi

if [ -n "${message}" ]; then
  entry="$(mktemp)"
  {
    echo "## $(date -u +%Y-%m-%d) - SteamCMD version ${version}"
    echo ""
    if [ "${#changed[@]}" -eq 0 ]; then
      echo "- SteamCMD version changed; help output unchanged"
    fi
    for file in "${changed[@]}"; do
      read -r added removed _ < <(git diff --numstat -- "${file}")
      echo "- [${file}](${repo_url}/commits/main/${file}): +${added} / -${removed} lines"
    done
    echo ""
  } > "${entry}"

  if [ -f "${changelog}" ]; then
    # Insert the new entry after the header (first two lines).
    { head -n 2 "${changelog}"; cat "${entry}"; tail -n +3 "${changelog}"; } > "${changelog}.tmp"
    mv "${changelog}.tmp" "${changelog}"
  else
    { echo "# Changelog"; echo ""; cat "${entry}"; } > "${changelog}"
  fi
  rm -f "${entry}"
  sed -n '1,20p' "${changelog}"
fi

echo "message: ${message:-<none>}"
if [ -n "${GITHUB_OUTPUT:-}" ]; then
  echo "message=${message}" >> "${GITHUB_OUTPUT}"
fi
