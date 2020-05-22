#!/bin/bash
# steamcmd_help.sh
# Author: Daniel Gibbs
# Website: http://danielgibbs.co.uk
# Version: 180826
# Description: Output all of the help details from SteamCMD.

rootdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

# Install SteamCMD
echo ""
echo "Installing SteamCMD"
echo "================================="
cd "${rootdir}"
mkdir -pv "steamcmd"
cd "steamcmd"
if [ ! -f "steamcmd.sh" ]; then
    echo -e "downloading steamcmd_linux.tar.gz...\c"
    wget -N /dev/null http://media.steampowered.com/client/steamcmd_linux.tar.gz 2>&1 | grep -F HTTP | cut -c45-| uniq
    tar --verbose -zxf "steamcmd_linux.tar.gz"
    rm -v "steamcmd_linux.tar.gz"
    chmod +x "steamcmd.sh"
else
    echo "Steam already installed!"
fi

echo ""
echo "Getting SteamCMD Help"
echo "================================="
cd "${rootdir}/steamcmd"

echo "./steamcmd.sh +login anonymous"
./steamcmd.sh +login anonymous +quit
echo "help:" > "${rootdir}/steamcmd_help.txt"
echo "=================================" >> "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help +quit"
./steamcmd.sh +login anonymous +help +quit >> "${rootdir}/steamcmd_help.txt"

echo "help login:" >> "${rootdir}/steamcmd_help.txt"
echo "=================================" >> "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help login +quit"
./steamcmd.sh +login anonymous +help login +quit >> "${rootdir}/steamcmd_help.txt"

echo "help scripts:" >> "${rootdir}/steamcmd_help.txt"
echo "=================================" >> "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help scripts +quit"
./steamcmd.sh +login anonymous +help scripts +quit >> "${rootdir}/steamcmd_help.txt"

echo "help commandline:" >> "${rootdir}/steamcmd_help.txt"
echo "=================================" >> "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help commandline +quit"
./steamcmd.sh +login anonymous +help commandline +quit >> "${rootdir}/steamcmd_help.txt"


echo "help convars:" >> "${rootdir}/steamcmd_help.txt"
echo "=================================" >> "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help convars +quit"
./steamcmd.sh +login anonymous +help convars +quit >> "${rootdir}/steamcmd_help.txt"

echo "help app_build:" >> "${rootdir}/steamcmd_help.txt"
echo "=================================" >> "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help app_build +quit"
./steamcmd.sh +login anonymous +help app_build +quit >> "${rootdir}/steamcmd_help.txt"

echo "help app_update:" >> "${rootdir}/steamcmd_help.txt"
echo "=================================" >> "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help app_update +quit"
./steamcmd.sh +login anonymous +help app_update +quit >> "${rootdir}/steamcmd_help.txt"

echo ""
echo "SteamCMD Help Output"
echo "================================="
cat "${rootdir}/steamcmd_help.txt"

echo "Tidy up."
rm -rf "${rootdir}/tmp"
rm -rf "${rootdir}/steamcmd"
