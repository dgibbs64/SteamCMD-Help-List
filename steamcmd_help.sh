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
cd "${rootdir}" || exit
mkdir -pv "steamcmd"
cd "steamcmd" || exit
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
echo ""
echo "./steamcmd.sh +login anonymous +help +quit"
echo "================================="
./steamcmd.sh +login anonymous +help +quit > "${rootdir}/steamcmd_help.txt"
sed -i '1,/Waiting/d; s/\x1b//g; s/\[0m//g; s/\[1m//g; /CWorkThreadPool/d; /workthreadpool.cpp/d; /CProcessWorkItem/d' "${rootdir}/steamcmd_help.txt"
echo ""
echo "./steamcmd.sh +login anonymous +help login +quit"
echo "================================="
./steamcmd.sh +login anonymous +help login +quit | tee "${rootdir}/steamcmd_help_login.txt"
sed -i '1,/Waiting/d; s/\x1b//g; s/\[0m//g; s/\[1m//g; /CWorkThreadPool/d; /workthreadpool.cpp/d; /CProcessWorkItem/d' "${rootdir}/steamcmd_help_login.txt"
echo ""
echo "./steamcmd.sh +login anonymous +help scripts +quit"
echo "================================="
./steamcmd.sh +login anonymous +help scripts +quit | tee "${rootdir}/steamcmd_help_scripts.txt"
sed -i '1,/Waiting/d; s/\x1b//g; s/\[0m//g; s/\[1m//g; /CWorkThreadPool/d; /workthreadpool.cpp/d; /CProcessWorkItem/d' "${rootdir}/steamcmd_help_scripts.txt"
echo ""
echo "./steamcmd.sh +login anonymous +help commandline +quit"
echo "================================="
./steamcmd.sh +login anonymous +help commandline +quit | tee "${rootdir}/steamcmd_help_commandline.txt"
sed -i '1,/Waiting/d; s/\x1b//g; s/\[0m//g; s/\[1m//g; /CWorkThreadPool/d; /workthreadpool.cpp/d; /CProcessWorkItem/d' "${rootdir}/steamcmd_help_commandline.txt"
echo ""
echo "./steamcmd.sh +login anonymous +help convars +quit"
echo "================================="
./steamcmd.sh +login anonymous +help convars +quit | tee "${rootdir}/steamcmd_help_convars.txt"
sed -i '1,/Waiting/d; s/\x1b//g; s/\[0m//g; s/\[1m//g; /CWorkThreadPool/d; /workthreadpool.cpp/d; /CProcessWorkItem/d' "${rootdir}/steamcmd_help_convars.txt"
echo ""
echo "./steamcmd.sh +login anonymous +help app_build +quit"
echo "================================="
./steamcmd.sh +login anonymous +help app_build +quit | tee "${rootdir}/steamcmd_help_app_build.txt"
sed -i '1,/Waiting/d; s/\x1b//g; s/\[0m//g; s/\[1m//g; /CWorkThreadPool/d; /workthreadpool.cpp/d; /CProcessWorkItem/d' "${rootdir}/steamcmd_help_app_build.txt"
echo ""
echo "./steamcmd.sh +login anonymous +help app_update +quit"
echo "================================="
./steamcmd.sh +login anonymous +help app_update +quit | tee "${rootdir}/steamcmd_help_app_update.txt"
sed -i '1,/Waiting/d; s/\x1b//g; s/\[0m//g; s/\[1m//g; /CWorkThreadPool/d; /workthreadpool.cpp/d; /CProcessWorkItem/d' "${rootdir}/steamcmd_help_app_update.txt"
echo ""
echo "tidy up"
rm -rf "${rootdir}/tmp"
rm -rf "${rootdir}/steamcmd"
