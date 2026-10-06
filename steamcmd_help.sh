#!/bin/bash
# steamcmd_help.sh
# Author: Daniel Gibbs
# Website: https://danielgibbs.co.uk
# Description: Output all of the help details from SteamCMD.

set -euo pipefail

rootdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Strip SteamCMD startup noise and ANSI escape codes from the output.
clean_output() {
  sed '1,/Waiting for client config/d' \
    | sed -E 's/\x1b\[[0-9;]*m//g; s/\[[0-9;]*m//g' \
    | grep -vE '^OK$|Waiting for user info|Unloading Steam API|CWorkThreadPool|workthreadpool\.cpp|CProcessWorkItem|CHTTPClientThreadPool' \
    || true
}

# run_steamcmd <output file> <steamcmd args...>
run_steamcmd() {
  local outfile="${rootdir}/${1}"
  shift
  echo ""
  echo "steamcmd +login anonymous $* +quit"
  echo "================================="
  # SteamCMD exit codes are unreliable, so check the output instead.
  { steamcmd +login anonymous "$@" +quit || true; } | clean_output > "${outfile}"
  cat "${outfile}"
  if [ ! -s "${outfile}" ]; then
    echo "Error: ${outfile} is empty" >&2
    exit 1
  fi
}

echo ""
echo "Getting SteamCMD Help"
echo "================================="

# Record the SteamCMD version from its startup banner, e.g.
# "Steam Console Client (c) Valve Corporation - version 1788292693".
version="$({ steamcmd +quit || true; } | sed -nE '/Steam Console Client/{s/.* version ([0-9]+).*/\1/p;q}')"
if [ -n "${version}" ]; then
  echo "SteamCMD version: ${version}"
  echo "${version}" > "${rootdir}/steamcmd_version.txt"
else
  echo "Warning: could not detect SteamCMD version" >&2
fi

run_steamcmd "steamcmd_help.txt" +help
for topic in login scripts commandline convars app_build app_update; do
  run_steamcmd "steamcmd_help_${topic}.txt" "+help ${topic}"
done

echo ""
echo "tidy up"
rm -rf "${rootdir}/tmp" "${rootdir}/steamcmd"
