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
echo "./steamcmd.sh +login anonymous +help +quit"
echo "help:" > "${rootdir}/steamcmd_help.txt"
./steamcmd.sh +login anonymous +help +quit > "${rootdir}/steamcmd_help.txt"
echo "help Login:" > "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help login +quit"
./steamcmd.sh +login anonymous +help login +quit > "${rootdir}/steamcmd_help.txt"
echo "help Scripts:" > "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help scripts +quit"
./steamcmd.sh +login anonymous +help scripts +quit > "${rootdir}/steamcmd_help.txt"
echo "help commandline:"
echo "./steamcmd.sh +login anonymous +help commandline +quit"
./steamcmd.sh +login anonymous +help commandline +quit > "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help convars +quit"
echo "help commandline:" > "${rootdir}/steamcmd_help.txt"
./steamcmd.sh +login anonymous +help convars +quit > "${rootdir}/steamcmd_help.txt"
echo "help app_build:" > "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help app_build +quit"
./steamcmd.sh +login anonymous +help app_build +quit > "${rootdir}/steamcmd_help.txt"
echo "help app_update:" > "${rootdir}/steamcmd_help.txt"
echo "./steamcmd.sh +login anonymous +help app_update +quit"
./steamcmd.sh +login anonymous +help app_update +quit > "${rootdir}/steamcmd_help.txt"
echo ""
cat "${rootdir}/steamcmd_help.txt"

echo "Tidy up."
rm -rf "${rootdir}/tmp"
rm -rf "${rootdir}/steamcmd"


git config --global user.email "me@danielgibbs.co.uk"
git config --global user.name "dgibbs64"

git remote set-url origin https://dgibbs64:${GH_TOKEN}@github.com/dgibbs64/SteamCMD-Help-List.git

git checkout ${TRAVIS_BRANCH}
git add . steamcmd_commands.txt
git update-index --add --chmod=+x push.sh
git commit -m 'Make push.sh executable'
git commit --message "Travis build: $(date +%Y-%m-%d)"
git push --set-upstream origin ${TRAVIS_BRANCH}
