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

# merge_find_output <file>
# Merge the ConVars/Commands sections from several "find" calls into one
# de-duplicated list, sorted by name. Lines that are not "name = value : desc"
# or "name : desc" entries (e.g. wrapped description text) are dropped.
merge_find_output() {
  local file="${1}"
  awk '
    /^ConVars:$/ { section = 1; next }
    /^Commands:$/ { section = 2; next }
    section && match($0, /^ *[^ =:]+ +(= "|:( |$))/) {
      name = $1
      if (!seen[section, name]++) {
        print section "\t" name "\t" $0
      }
    }
  ' "${file}" \
    | sort -t "$(printf '\t')" -k1,1n -k2,2 \
    | awk -F '\t' '
      $1 != last { print (NR > 1 ? "\n" : "") ($1 == 1 ? "ConVars:" : "Commands:"); last = $1 }
      { sub(/^[^\t]*\t[^\t]*\t/, ""); print }
    ' > "${file}.tmp"
  mv "${file}.tmp" "${file}"
}

echo ""
echo "Getting SteamCMD Help"
echo "================================="

run_steamcmd "steamcmd_help.txt" +help
for topic in login scripts commandline convars app_build app_update; do
  run_steamcmd "steamcmd_help_${topic}.txt" "+help ${topic}"
done

# Full list of all commands and convars. "find" matches a substring of the
# name or description and has no wildcard, so search for every letter.
find_args=()
for letter in {a..z}; do
  find_args+=("+find ${letter}")
done
run_steamcmd "steamcmd_find_all.txt" "${find_args[@]}"
merge_find_output "${rootdir}/steamcmd_find_all.txt"
echo ""
echo "steamcmd_find_all.txt: $(grep -c . "${rootdir}/steamcmd_find_all.txt") lines after merge"

echo ""
echo "tidy up"
rm -rf "${rootdir}/tmp" "${rootdir}/steamcmd"
