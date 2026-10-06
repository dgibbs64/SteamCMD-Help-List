# SteamCMD Help List

<p align="center">
  <a href="https://developer.valvesoftware.com/wiki/SteamCMD"><img src="https://user-images.githubusercontent.com/4478206/197542699-ae13797a-78bb-4f37-81c2-d4880fd7709f.jpg" alt="SteamCMD"></a>
<br>
</p>
<p align="center">
<a href="https://github.com/dgibbs64/SteamCMD-Help-List/actions/workflows/action-generate_output.yml"><img alt="Generate Output" src="https://github.com/dgibbs64/SteamCMD-Help-List/actions/workflows/action-generate_output.yml/badge.svg"></a>
<a href="https://developer.valvesoftware.com/wiki/SteamCMD"><img src="https://img.shields.io/badge/SteamCMD-000000?style=flat-square&amp;logo=Steam&amp;logoColor=white" alt="SteamCMD"></a>
<a href="https://www.gnu.org/software/bash/"><img src="https://img.shields.io/badge/Made with BASH-1f425f?style=flat-square&amp;logo=gnu bash&amp;logoColor=white" alt="Made with Bash"></a>
<a href="https://github.com/dgibbs64/SteamCMD-Help-List/blob/main/LICENSE.md"><img src="https://img.shields.io/github/license/dgibbs64/SteamCMD-Help-List?style=flat-square" alt="MIT License"></a>
</p>

## Description

A daily-updated copy of the built-in help output from [SteamCMD](https://developer.valvesoftware.com/wiki/SteamCMD), Valve's command-line Steam client. A GitHub Actions workflow runs SteamCMD every day and commits any changes, so the commit history also shows when Valve changes the help text.

## Help topics

| File                                                           | Command             | Description                                                      |
| -------------------------------------------------------------- | ------------------- | ---------------------------------------------------------------- |
| [steamcmd_help.txt](steamcmd_help.txt)                         | `+help`             | Usage and list of help topics                                    |
| [steamcmd_help_login.txt](steamcmd_help_login.txt)             | `+help login`       | Logging in to Steam                                              |
| [steamcmd_help_scripts.txt](steamcmd_help_scripts.txt)         | `+help scripts`     | Executing a sequence of commands via a script file               |
| [steamcmd_help_commandline.txt](steamcmd_help_commandline.txt) | `+help commandline` | Executing commands directly via the OS command line              |
| [steamcmd_help_convars.txt](steamcmd_help_convars.txt)         | `+help convars`     | Options and settings that affect this program session            |
| [steamcmd_help_app_build.txt](steamcmd_help_app_build.txt)     | `+help app_build`   | Building Steam application content (licensed developers only)    |
| [steamcmd_help_app_update.txt](steamcmd_help_app_update.txt)   | `+help app_update`  | Installing/updating a Steam application (e.g. dedicated servers) |
| [steamcmd_find_all.txt](steamcmd_find_all.txt)                 | `+find .`           | Every command and convar SteamCMD knows about                    |

## Usage

To generate the output yourself, install SteamCMD so that `steamcmd` is on your `PATH`, then download and run the script:

```bash
wget https://raw.githubusercontent.com/dgibbs64/SteamCMD-Help-List/main/steamcmd_help.sh
chmod +x steamcmd_help.sh
./steamcmd_help.sh
```

The `.txt` files are written next to the script.
