#!/usr/bin/env bash
#
# BASH Debugger:
# set -x
#
# Copyright 2023 M T <encode2m4v -at- gmail.com>
#
# This software may be used and distributed according to the terms of the
# MIT License or the GNU General Public License version 3 (or any later version).
#
the_instructions='
encode2m4v                                     User Contributed Documentation                                   encode2m4v

NAME
      encode2m4v  - Transcodes video files using HandBrakeCLI

VERSION
      Version 0.9.6

SUMMARY
  Encodes .mp4 files to .m4v files recursing directories to find all .mp4 files
  with the ability to include subtitles into the encoded file and/or upconvert
  the output to 1080. Other options are possible using command line arguments.

SYNOPSIS
      encode2m4v "root directory/" [switch(es) [option(s)]]

      Manditory:
           "root directory/" (directory to start the search for videos to transcode)

      Switches:
           -g/--guide (read the full manual)
           -h/--help (usage with switches)
           -v/--version
           -p/--preset=
           -j/--json=
           -i/--inext=
           -e/--ext=
           -s/--subtitle=
           -t/--transopt=
           -u/--upconvert
           -n/--noupconvert
           -c/--continue
           -b/--break
           -o/--output=
           -r/--recreatedirs
           -m/--move=
           -a/--all
           -l/--logfile=
           -d/--details
           -q/--quiet


HELP
      encode2m4v -h  or  --help


REQUIREMENTS
  handbrakeCLI.exe  - installed in same directory, /Applications/HandBrakeCLI (Mac OS)
                      or in PATH, or as flatpak (Linux)

DETAILS
------------
DESCRIPTION  Transcodes files and recurses folders in current directory "." (or
             "root directory".) Finds all .mp4 (or "--inext") files and transcodes
             them into an .m4v (or "--ext") file using the "HQ 1080p30 Surround"
             (or --preset) HandBrakeCLI preset. Originally meant to be copied to the
             directory to start the recursive search (root) and run from there, it
             also has command line switches (arguments) which can be passed in to set
             the "root" folder and other switches to set processing options.

    PROMPTS  1) Prompts for the subtitle extension (??.srt) or "none" (0) to add
             2) Prompts whether or not to upconvert to resolution 1920 x 1080

   DEFAULTS  Default HandBrakeCLI preset: HQ 1080p30 Surround

             Default  HandBrakeCLI Transcoding options:
                   --vfr --crop 0:0:0:0 --auto-anamorphic --keep-display-aspect
             Default HandBrakeCLI transcoding options for adding subtitles:
                   --subtitle-lang-list eng,spa --native-language eng

    OPTIONS
        Switches
            -h, --help
                See a synopsis.

            -g, --guide
                Browse the manpage.

            -v, --version
                Display the encode2m4v version.

            -p, --preset=
                HandBrakeCLI Preset to use when encoding. (Enclose in quotes "<preset>")

            -j, --json=
                HandBrake .json settings file to use when encoding. (Enclose in quotes "<filename>.json")

            -i, --inext=
                Input video file extension to encode. (Enclose in quotes ".ext")

            -e, --ext=
                Output video file extension to transcode to. (Enclose in quotes ".ext")

            -s, --subtitle=
                Subtitle extension to include into Output file. Must end in .srt (SubRipper type) (Enclose in quotes ".ext")

            -t, --transopt=
                Transcoding options to use when calling HandBrakeCLI (Enclose in quotes "----")

            -u, --upconvert
                Upconvert all encoded files.

            -n, --noupconvert
                Do NOT upconvert all encoded vided files.

            -c, --continue
                Continue encoding if a file is missing the designated subtitle file for the video file.

            -b, --break
                Stop (Break) the encoding process if a file is missing the designated subtitle file for the video file.

            -o, --output=
                Output Directory to place all encoded videos.

            -r, --recreatedirs
                Re-create the same directory structure found in the incoming directory (root directory.)

            -m, --move=
                Directory to move all source files into (out of root directory) once they have been re-encoded.

            -l, --logfile=
                Logfile filename to use to log information to a .json format log file. (Enclose in quotes "logfile.json")
                Saved in root of output directory.

            -d, --details
                Details of the HandBrakeCLI transcoding will be shown.

            -q, --quiet
                Work in quiet mode. Display no outputs or prompts unless necessary.

   WARNINGS  If the output file exists (or is the same name as the input file
             and in the same directory) THE FILE WILL BE OVERWRITTEN (defaultj /
             THIS IS PARTICULARY DANGEROUS IF OUTPUTTING TO A FILE EXTENSION
             WHICH IS THE SAME AS THE INPUT EXTENSION. This is only possible
             if using command line options - SO BE CAREFUL!

   SEE ALSO
             encode2m4v Documentation: https://docs.encode2m4v.sh

             encode2m4v Wiki: https://github.com/encode2m4v/encode2m4v/wiki

       BUGS  ... (yes...)

     AUTHOR
             Written by M T ...

REPORTING BUGS
             See our issues on GitHub:

                  https://github.com/encode2m4v/encode2m4v/issues

COPYRIGHT
             Copyright  © 2023 M T  License GPLv3+: GNU GPL version 3 or later.

             This program is free software: you can redistribute it and/or modify
             it under the terms of the GNU General Public License as published by
             the Free Software Foundation, either version 3 of the License, or
             (at your option) any later version.

             This program is distributed in the hope that it will be useful,
             but WITHOUT ANY WARRANTY; without even the implied warranty of
             MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
             GNU General Public License for more details.

             You should have received a copy of the GNU General Public License
             along with this program.  If not, see <https://www.gnu.org/licenses/>.

encode2m4v                                     User Contributed Documentation                                   encode2m4v
'
# WORKING ON:
#
#  FIX "-?" SWITCH
#
# OTHER OPTIONS TO INCLUDE LATER:
#
#   - SWITCH - to set subtitles to set as defaults ( - , -- /  HandBrakeCLI_transcoding_options_for_adding_subtitles )
#
#   - SWITCH - to set default subtitle language ( -, --native= / HandBrakeCLI_subtitle_native_language )
#
#   - SWITCH TO PASS IN THE UPCONVERT RESOLUTION ( - , --  ="1080" / 720 / 1080 / 2160   / HandBrakeCLI_upconvert_option )
#
#     SWITCH - to set added subtitle language ( -d, --dialect=  / HandBrakeCLI_srt_language )
#
#   - WAY TO ADD MULTIPLE FILE EXTENSIONS TO FIND AS INPUT EXTENSION (or all known?)
#
#  SET LANGUAGES FOR SUBTITLE ADDITION - AS VARIABLES (DEFAULTS)
#   MAYBE A SWITCH OPTION (-d, --dialect ) TO SET
#    can it add multiple subtitles? (or all with same filename and detect language)
#
#  BE ABLE TO READ A encode2m4v CONFIG FILE AND USE THOSE SETTINGS
#
#  OPTION TO CHANGE THE DEFAULTS OF encodeM4V (e.g prest or output file path)
#
#  - rename all variables to use descriptive lower_case notation
#
# TO TEST:
#
#    Test as cron job ...
#
# NOTE:
#         Thank you to all those who worked on HandBrake and also all those who asked
#         and answered questions online on using HandBrake(CLI) and using BASH and the
#         authors of the Blog sites and example scripts I have perused to learn from.
#

# SET the app details
filename_version="0p9p6"
the_version_major="0"
the_version_minor="9"
the_version_micro="6"
version="$the_version_major.$the_version_minor.$the_version_micro"
the_app_name="encode2m4v"
the_version="$the_app_name Version $version"

# TEST FOR REQUIRED COMMANDS (APPLICATIONS)
#
# TEST FOR HandBrakeCLI APPLICATION
#
# Try to find the HandBrakeCLI application, then...
# Assign the command to the HandBrakeCLIprog variable
# I realize this is messy...
if ! type -P "/Applications/HandbrakeCLI" &> /dev/null; then
  if ! type -P "HandbrakeCLI" &> /dev/null; then
    if ! type -P "./HandbrakeCLI" &> /dev/null; then
      if ! type -P "HandbrakeCLI.exe" &> /dev/null; then
        flatpak_directory="$HOME/.var/app"
        flatpak_command="flatpak run"
        if [[ ! -n "$(find "$flatpak_directory" -type d -iname "*HandBrakeCLI*")" ]]; then
          echo >&2 "$the_app_name requires the \"HandBrakeCLI\" application, but it's not installed.  Aborting."; exit 1;
        else
          flatpak_app=$(bash -c "find '$flatpak_directory' -type d -iname '*HandBrakeCLI*' -printf '%f\n'")
          HandBreakCLIProg="$flatpak_command $flatpak_app"
        fi
      else
        HandBreakCLIProg=`which "HandbrakeCLI.exe"`
      fi
    else
      HandBreakCLIProg=`which "./HandbrakeCLI"`
    fi
  else
    HandBreakCLIProg=`which "HandbrakeCLI"`
  fi
else
  HandBreakCLIProg=`which "/Applications/HandBrakeCLI"`
fi
# SET the help and usage strings
the_usage1="encode2m4v \"root (transcode) directory\" [switch(es) [option(s)]]"
the_usage2="Try: 'encode2m4v --help' for more information."
the_help0="encode2m4v \"root (transcode) directory\" [switch(es) [option(s)]]"
the_help1="  switch(es):       |  option  |   (results)"
the_help2="----------------------------------------------------------------------------------------------------"
the_help3=" -h, --help         |  [none]  | Display this help and exit"
the_help4=" -v, --version      |  [none]  | Display the encoodeM4Vs version"
the_help5=" -g, --guide        |  [none]  | Display the instruction guide for usage (MAN type Page)"
# the_help6=" -f, --file=        |  CONFIG  | Use the CONFIG file as encode2m4v settings"
the_help7=" -p, --preset=      | \"PRESET\" | HandBrake Preset (e.g. \"HQ 1080p30 Surround\" - the default)"
the_help8=" -j, --json=        |  \"FILE\"  | HandBrake .json preset file (e.g. \"My HandBrake Preset.json\")"
the_help9=" -i, --inext=       |  \".ext\"  | Input file Extension (e.g. \".mp4\" - the default)"
the_help10=" -e, --ext=         |  \".ext\"  | Output file Extension (e.g. \".m4v\" - the default or \".mkv\")"
the_help11=" -s, --subtitle=    |  \".ext\"  | Subtitle Extension (e.g. \".srt\" - the default) or \"NONE\" or 0"
the_help12=" -t, --transopt=    |  \"OPTS\"  | Transcoding Options (e.g. \"--quality 22.0 --cfr -r 30 --loose-anamorphic\""
the_help13=" -u, --upconvert    |  [none]  | Up-convert all video to 1080"
the_help14=" -n, --noupconvert  |  [none]  | Do Not Up-convert all video to 1080"
the_help15=" -c, --continue     |  [none]  | Continue encoding if subtitle file is missing"
the_help16=" -b, --break        |  [none]  | Stop (break) encoding if subtitle file is missing (DEFAULT)"
the_help17=" -o, --output=      |   \"DIR\"  | Directory to output all encoded files - DEFAULT IS SAME AS INPUT"
the_help18=" -r, --recreatedirs |  [none]  | When using an output directory - recreate input directory structure"
the_help19=" -m, --move=        |   \"DIR\"  | Directory to move original files once they have been encoded"
the_help20=" -l, --logfile=     |  \"FILE\"  | Logfile for output of all processing - PLACED IN OUTPUT DIRECTORY"
the_help21=" -d, --details      |  [none]  | Details mode (show HandBrakeCLI processing)"
the_help22=" -q, --quiet        |  [none]  | Quiet mode (no confirmation prompts or details)"

# DEFAULT PRESET TO USE IF NOT SPECIFIED
preset_to_use="HQ 1080p30 Surround"
preset_to_use_set="not set"
# HandBrake .json to USE IF SPECIFIED
HandBrake_json_to_use=""
HandBrake_json_to_use_set="not set"
# DEFAULT TRANSCODING OPTIONS:
default_HandBrakeCLI_transcoding_options="--vfr --crop 0:0:0:0 --auto-anamorphic --keep-display-aspect"
HandBrakeCLI_transcoding_options="$default_HandBrakeCLI_transcoding_options"
HandBrakeCLI_transcoding_options_set="not set"
# DEFAULT TRANSCODING OPTIONS FOR ADDING SUBS:
default_subtitle_language_list="eng,spa"
HandBrakeCLI_subtitle_language_list="${default_subtitle_language_list}"
default_subtitle_native_language="eng"
HandBrakeCLI_subtitle_native_language="${default_subtitle_native_language}"
default_HandBrakeCLI_transcoding_options_for_adding_subtitles="--subtitle-lang-list ${default_subtitle_language_list} --native-language ${default_subtitle_native_language}"
HandBrakeCLI_transcoding_options_for_adding_subtitles="--subtitle-lang-list ${HandBrakeCLI_subtitle_language_list} --native-language ${HandBrakeCLI_subtitle_native_language}"
HandBrakeCLI_transcoding_options_for_adding_subtitles_set="not set"
# DEFAULT SRT OPTIONS
default_srt_language="eng"
default_HandBrakeCLI_srt_language="--srt-lang $default_srt_language"
HandBrakeCLI_srt_language="$default_HandBrakeCLI_srt_language"
HandBrakeCLI_srt_language_set="not set"
# DEFAULT UPCONVERT OPTIONS
HandBrakeCLI_upconvert_720_option="--width 1280 --height 720"
HandBrakeCLI_upconvert_1080_option="--width 1920 --height 1080"
HandBrakeCLI_upconvert_2160_option="--width 3840 --height 2160"
HandBrakeCLI_upconvert_4320_option="--width 7680 --height 4320"
declare -a HandBrakeCLI_upconvert_options_array=("--width 1280 --height 720"
																          "--width 1920 --height 1080"
                                          "--width 3840 --height 2160"
                                          "--width 7680 --height 4320")
default_HandBrakeCLI_upconvert_option="$HandBrakeCLI_upconvert_1080_option"
HandBrakeCLI_upconvert_option="$default_HandBrakeCLI_upconvert_option"
HandBrakeCLI_upconvert_option_set="not set"
# VALID PRESETS FROM HandBrakeCLI v1.6.0:
preset_list="Valid presets are:
    General/
        Very Fast 2160p60 4K AV1
		        AV1 video (up to 2160p60) and AAC stereo audio, in an MP4
		        container.
        Very Fast 2160p60 4K HEVC
		        H.265 video (up to 2160p60) and AAC stereo audio, in an MP4
		        container.
        Very Fast 1080p30
		        Small H.264 video (up to 1080p30) and AAC stereo audio, in
		        an MP4 container.
        Very Fast 720p30
		        Small H.264 video (up to 720p30) and AAC stereo audio, in an
		        MP4 container.
        Very Fast 576p25
		        Small H.264 video (up to 576p25) and AAC stereo audio, in an
		        MP4 container.
        Very Fast 480p30
		        Small H.264 video (up to 480p30) and AAC stereo audio, in an
		        MP4 container.
        Fast 2160p60 4K AV1
		        AV1 video (up to 2160p60) and AAC stereo audio, in an MP4
		        container.
        Fast 2160p60 4K HEVC
		        H.265 video (up to 2160p60) and AAC stereo audio, in an MP4
		        container.
        Fast 1080p30
		        H.264 video (up to 1080p30) and AAC stereo audio, in an MP4
		        container.
        Fast 720p30
		        H.264 video (up to 720p30) and AAC stereo audio, in an MP4
		        container.
        Fast 576p25
		        H.264 video (up to 576p25) and AAC stereo audio, in an MP4
		        container.
        Fast 480p30
		        H.264 video (up to 480p30) and AAC stereo audio, in an MP4
		        container.
        HQ 2160p60 4K AV1 Surround
		        High quality AV1 video (up to 2160p60), AAC stereo audio,
		        and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        HQ 2160p60 4K HEVC Surround
		        High quality H.265 video (up to 2160p60), AAC stereo audio,
		        and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        HQ 1080p30 Surround
		        High quality H.264 video (up to 1080p30), AAC stereo audio,
		        and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        HQ 720p30 Surround
		        High quality H.264 video (up to 720p30), AAC stereo audio,
		        and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        HQ 576p25 Surround
		        High quality H.264 video (up to 576p25), AAC stereo audio,
		        and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        HQ 480p30 Surround
		        High quality H.264 video (up to 480p30), AAC stereo audio,
		        and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        Super HQ 2160p60 4K AV1 Surround
		        Super high quality AV1 video (up to 2160p60), AAC stereo
		        audio, and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        Super HQ 2160p60 4K HEVC Surround
		        Super high quality H.265 video (up to 2160p60), AAC stereo
		        audio, and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        Super HQ 1080p30 Surround
		        Super high quality H.264 video (up to 1080p30), AAC stereo
		        audio, and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        Super HQ 720p30 Surround
		        Super high quality H.264 video (up to 720p30), AAC stereo
		        audio, and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        Super HQ 576p25 Surround
		        Super high quality H.264 video (up to 576p25), AAC stereo
		        audio, and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
        Super HQ 480p30 Surround
		        Super high quality H.264 video (up to 480p30), AAC stereo
		        audio, and Dolby Digital (AC-3) surround audio, in an MP4
		        container.
    Web/
        Creator 2160p60 4K
		        High quality video for publishing via online services such
		        as Vimeo and YouTube. H.264 video (up to 2160p60) and high
		        bit rate AAC stereo audio in an MP4 container.
        Creator 1440p60 2.5K
		        High quality video for publishing via online services such
		        as Vimeo and YouTube. H.264 video (up to 1440p60) and high
		        bit rate AAC stereo audio in an MP4 container.
        Creator 1080p60
		        High quality video for publishing via online services such
		        as Vimeo and YouTube. H.264 video (up to 1080p60) and high
		        bit rate AAC stereo audio in an MP4 container.
        Creator 720p60
		        High quality video for publishing via online services such
		        as Vimeo and YouTube. H.264 video (up to 720p60) and high
		        bit rate AAC stereo audio in an MP4 container.
        Email 25 MB 3 Minutes 720p30
		        Up to 3 minutes of video in 25 MB or less, for sharing via
		        email services such as Gmail. H.264 video (up to 720p30) and
		        AAC stereo audio, in an MP4 container.
        Email 25 MB 5 Minutes 480p30
		        Up to 5 minutes of video in 25 MB or less, for sharing via
		        email services such as Gmail. H.264 video (up to 480p30) and
		        AAC stereo audio, in an MP4 container.
        Email 25 MB 10 Minutes 288p30
		        Up to 10 minutes of video in 25 MB or less, for sharing via
		        email services such as Gmail. H.264 video (up to 288p30) and
		        AAC stereo audio, in an MP4 container.
        Social 100 MB 5 Minutes 1080p30
		        Up to 5 minutes of video in 100 MB or less, for sharing via
		        online social communities such as Discord. H.264 video (up
		        to 1080p30) and AAC stereo audio, in an MP4 container.
        Social 50 MB 5 Minutes 720p30
		        Up to 5 minutes of video in 50 MB or less, for sharing via
		        online social communities such as Discord. H.264 video (up
		        to 720p30) and AAC stereo audio, in an MP4 container.
        Social 50 MB 10 Minutes 480p30
		        Up to 10 minutes of video in 50 MB or less, for sharing via
		        online social communities such as Discord. H.264 video (up
		        to 480p30) and AAC stereo audio, in an MP4 container.
        Social 8 MB 3 Minutes 360p30
		        Up to 3 minutes of video in 8 MB or less, for sharing via
		        online social communities such as Discord. H.264 video (up
		        to 360p30) and AAC stereo audio, in an MP4 container.
    Devices/
        Amazon Fire 2160p60 4K HEVC Surround
		        H.265 video (up to 2160p60), AAC stereo audio, and Dolby
		        Digital (AC-3) audio, in an MP4 container. Compatible with
		        Amazon Fire TV 3rd Generation and later; Fire TV Stick 4K;
		        Fire TV Cube.
        Amazon Fire 1080p30 Surround
		        H.264 video (up to 1080p30), AAC stereo audio, and Dolby
		        Digital (AC-3) audio, in an MP4 container. Compatible with
		        Amazon Fire TV 1st Generation and later; Fire TV Stick 1st
		        Generation and later; Fire HD 10 7th Generation (2017); Fire
		        HDX 4th Generation (2014).
        Amazon Fire 720p30
		        H.264 video (up to 720p30) and AAC stereo audio, in an MP4
		        container. Compatible with Amazon Fire HD 4th Generation
		        (2014) and later; Kindle Fire HDX 3rd Generation (2013);
		        Kindle Fire HD 2nd Generation (2012) and later.
        Android 1080p30
		        H.264 video (up to 1080p30) and AAC stereo audio, in an MP4
		        container. Compatible with Android devices.
        Android 720p30
		        H.264 video (up to 720p30) and AAC stereo audio, in an MP4
		        container. Compatible with Android devices.
        Android 576p25
		        H.264 video (up to 576p25) and AAC stereo audio, in an MP4
		        container. Compatible with Android devices.
        Android 480p30
		        H.264 video (up to 480p30) and AAC stereo audio, in an MP4
		        container. Compatible with Android devices.
        Apple 2160p60 4K HEVC Surround
		        H.265 video (up to 2160p60), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Apple iPhone 7 and later; Apple TV 4K.
        Apple 1080p60 Surround
		        H.264 video (up to 1080p60), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Apple iPad 5th and 6th Generation; iPad mini
		        2, 3, and 4; iPad Air 1st Generation and Air 2; iPad Pro
		        1st, 2nd, and 3rd Generation; Apple TV 4th Generation and
		        later.
        Apple 1080p30 Surround
		        H.264 video (up to 1080p30), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Apple iPhone 5, 5s, SE, 6, 6 Plus, 6s, 6s
		        Plus, and later; iPod touch 6th Generation; iPad 3rd, 4th
		        Generation and later; iPad mini 1st Generation and later;
		        Apple TV 3rd, 4th Generation and later.
        Apple 720p30 Surround
		        H.264 video (up to 720p30), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Apple iPhone 4, 4S, and later; iPod touch
		        4th, 5th Generation and later; iPad 1st Generation, iPad 2,
		        and later; Apple TV 2nd Generation and later.
        Apple 540p30 Surround
		        H.264 video (up to 540p30), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Apple iPhone 1st Generation, 3G, 3GS, and
		        later; iPod touch 1st, 2nd, 3rd Generation and later; iPod
		        Classic; Apple TV 1st Generation and later.
        Chromecast 2160p60 4K HEVC Surround
		        H.265 video (up to 2160p60), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Google Chromecast Ultra.
        Chromecast 1080p60 Surround
		        H.264 video (up to 1080p60), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Google Chromecast 3rd Generation.
        Chromecast 1080p30 Surround
		        H.264 video (up to 1080p30), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Google Chromecast 1st, 2nd Generation and
		        later.
        Playstation 2160p60 4K Surround
		        H.264 video (up to 2160p60), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Playstation 4 Pro.
        Playstation 1080p30 Surround
		        H.264 video (up to 1080p30), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Playstation 3 and 4.
        Playstation 720p30
		        H.264 video (up to 720p30) and AAC stereo audio, in an MP4
		        container. Compatible with Playstation Vita TV.
        Playstation 540p30
		        H.264 video (up to 540p30) and AAC stereo audio, in an MP4
		        container. Compatible with Playstation Vita.
        Roku 2160p60 4K HEVC Surround
		        H.265 video (up to 2160p60), AAC stereo audio, and surround
		        audio, in an MKV container. Compatible with Roku 4,
		        Streaming Stick+, Premiere+, and Ultra.
        Roku 1080p30 Surround
		        H.264 video (up to 1080p30), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Roku 1080p models.
        Roku 720p30 Surround
		        H.264 video (up to 720p30), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Roku 720p models.
        Roku 576p25
		        H.264 video (up to 576p25) and AAC stereo audio, in an MP4
		        container. Compatible with Roku standard definition models.
        Roku 480p30
		        H.264 video (up to 480p30) and AAC stereo audio, in an MP4
		        container. Compatible with Roku standard definition models.
        Xbox 1080p30 Surround
		        H.264 video (up to 1080p30), AAC stereo audio, and Dolby
		        Digital (AC-3) surround audio, in an MP4 container.
		        Compatible with Xbox One.
    Matroska/
        AV1 MKV 2160p60 4K
		        AV1 video (up to 2160p60) and Opus stereo audio, in an MKV
		        container.
        H.265 MKV 2160p60 4K
		        H.265 video (up to 2160p60) and AAC stereo audio, in an MKV
		        container.
        H.265 MKV 1080p30
		        H.265 video (up to 1080p30) and AAC stereo audio, in an MKV
		        container.
        H.265 MKV 720p30
		        H.265 video (up to 720p30) and AAC stereo audio, in an MKV
		        container.
        H.265 MKV 576p25
		        H.265 video (up to 576p25) and AAC stereo audio, in an MKV
		        container.
        H.265 MKV 480p30
		        H.265 video (up to 480p30) and AAC stereo audio, in an MKV
		        container.
        H.264 MKV 2160p60 4K
		        H.264 video (up to 2160p60) and AAC stereo audio, in an MKV
		        container.
        H.264 MKV 1080p30
		        H.264 video (up to 1080p30) and AAC stereo audio, in an MKV
		        container.
        H.264 MKV 720p30
		        H.264 video (up to 720p30) and AAC stereo audio, in an MKV
		        container.
        H.264 MKV 576p25
		        H.264 video (up to 576p25) and AAC stereo audio, in an MKV
		        container.
        H.264 MKV 480p30
		        H.264 video (up to 480p30) and AAC stereo audio, in an MKV
		        container.
        VP9 MKV 2160p60 4K
		        VP9 video (up to 2160p60) and Opus stereo audio, in an MKV
		        container.
        VP9 MKV 1080p30
		        VP9 video (up to 1080p30) and Opus stereo audio, in an MKV
		        container.
        VP9 MKV 720p30
		        VP9 video (up to 720p30) and Opus stereo audio, in an MKV
		        container.
        VP9 MKV 576p25
		        VP9 video (up to 576p25) and Opus stereo audio, in an MKV
		        container.
        VP9 MKV 480p30
		        VP9 video (up to 480p30) and Opus stereo audio, in an MKV
		        container.
    Hardware/
        AV1 QSV 2160p 4K
		        Intel Quick Sync Video hardware accelerated AV1 video (up to
		        2160p) and AAC stereo audio, in an MP4 container.
        H.265 NVENC 2160p 4K
		        Nvidia NVENC hardware accelerated H.265 video (up to 2160p)
		        and AAC stereo audio, in an MP4 container.
        H.265 NVENC 1080p
		        Nvidia NVENC hardware accelerated H.265 video (up to 1080p)
		        and AAC stereo audio, in an MP4 container.
        H.265 QSV 2160p 4K
		        Intel Quick Sync Video hardware accelerated H.265 video (up
		        to 2160p) and AAC stereo audio, in an MP4 container.
        H.265 QSV 1080p
		        Intel Quick Sync Video hardware accelerated H.265 video (up
		        to 1080p) and AAC stereo audio, in an MP4 container.
        H.265 VCN 2160p 4K
		        AMD VCN hardware accelerated H.265 video (up to 2160p) and
		        AAC stereo audio, in an MP4 container.
        H.265 VCN 1080p
		        AMD VCN hardware accelerated H.265 video (up to 1080p) and
		        AAC stereo audio, in an MP4 container.
        H.265 MF 2160p 4K
		        Hardware accelerated H.265 video (up to 2160p) and AAC
		        stereo audio, in an MP4 container for ARM based platforms
		        using Media Foundation
        H.265 MF 1080p
		        Hardware accelerated H.265 video (up to 1080p) and AAC
		        stereo audio, in an MP4 container for ARM based platforms
		        using Media Foundation
    Production/
        Production Max
		        Maximum bit rate, constant frame rate H.264 video and high
		        bit rate AAC stereo audio in an MP4 container. For
		        professional use as an intermediate format for video
		        editing. Creates gigantic files.
        Production Standard
		        High bit rate, constant frame rate H.264 video and high bit
		        rate AAC stereo audio in an MP4 container. For professional
		        use as an intermediate format for video editing. Creates
		        very large files.
        Production Proxy 1080p
		        Intra-only, constant frame rate H.264 video (up to 1080p)
		        and high bit rate AAC stereo audio in an MP4 container. For
		        professional use as a low resolution proxy format for video
		        editing.
        Production Proxy 540p
		        Intra-only, constant frame rate H.264 video (up to 540p) and
		        high bit rate AAC stereo audio in an MP4 container. For
		        professional use as a low resolution proxy format for video
		        editing.
    CLI Defaults/
        CLI Default"
declare -a valid_presets_array=("Very Fast 2160p60 4K AV1"
																"Very Fast 2160p60 4K HEVC"
																"Very Fast 1080p30"
																"Very Fast 720p30"
																"Very Fast 576p25"
																"Very Fast 480p30"
																"Fast 2160p60 4K AV1"
																"Fast 2160p60 4K HEVC"
																"Fast 1080p30"
																"Fast 720p30"
																"Fast 576p25"
																"Fast 480p30"
																"HQ 2160p60 4K AV1 Surround"
																"HQ 2160p60 4K HEVC Surround"
																"HQ 1080p30 Surround"
																"HQ 720p30 Surround"
																"HQ 576p25 Surround"
																"HQ 480p30 Surround"
																"Super HQ 2160p60 4K AV1 Surround"
																"Super HQ 2160p60 4K HEVC Surround"
																"Super HQ 1080p30 Surround"
																"Super HQ 720p30 Surround"
																"Super HQ 576p25 Surround"
																"Super HQ 480p30 Surround"
																"Creator 2160p60 4K"
																"Creator 1440p60 2.5K"
																"Creator 1080p60"
																"Creator 720p60"
																"Email 25 MB 3 Minutes 720p30"
																"Email 25 MB 5 Minutes 480p30"
																"Email 25 MB 10 Minutes 288p30"
																"Social 100 MB 5 Minutes 1080p30"
																"Social 50 MB 5 Minutes 720p30"
																"Social 50 MB 10 Minutes 480p30"
																"Social 8 MB 3 Minutes 360p30"
																"Amazon Fire 2160p60 4K HEVC Surround"
																"Amazon Fire 1080p30 Surround"
																"Amazon Fire 720p30"
																"Android 1080p30"
																"Android 720p30"
																"Android 576p25"
																"Android 480p30"
																"Apple 2160p60 4K HEVC Surround"
																"Apple 1080p60 Surround"
																"Apple 1080p30 Surround"
																"Apple 720p30 Surround"
																"Apple 540p30 Surround"
																"Chromecast 2160p60 4K HEVC Surround"
																"Chromecast 1080p60 Surround"
																"Chromecast 1080p30 Surround"
																"Playstation 2160p60 4K Surround"
																"Playstation 1080p30 Surround"
																"Playstation 720p30"
																"Playstation 540p30"
																"Roku 2160p60 4K HEVC Surround"
																"Roku 1080p30 Surround"
																"Roku 720p30 Surround"
																"Roku 576p25"
																"Roku 480p30"
																"Xbox 1080p30 Surround"
																"AV1 MKV 2160p60 4K"
																"H.265 MKV 2160p60 4K"
																"H.265 MKV 1080p30"
																"H.265 MKV 720p30"
																"H.265 MKV 576p25"
																"H.265 MKV 480p30"
																"H.264 MKV 2160p60 4K"
																"H.264 MKV 1080p30"
																"H.264 MKV 720p30"
																"H.264 MKV 576p25"
																"H.264 MKV 480p30"
																"VP9 MKV 2160p60 4K"
																"VP9 MKV 1080p30"
																"VP9 MKV 720p30"
																"VP9 MKV 576p25"
																"VP9 MKV 480p30"
																"AV1 QSV 2160p 4K"
																"H.265 NVENC 2160p 4K"
																"H.265 NVENC 1080p"
																"H.265 QSV 2160p 4K"
																"H.265 QSV 1080p"
																"H.265 VCN 2160p 4K"
																"H.265 VCN 1080p"
																"H.265 MF 2160p 4K"
																"H.265 MF 1080p"
																"Production Max"
																"Production Standard"
																"Production Proxy 1080p"
																"Production Proxy 540p"
																"CLI Default"
                                "")  # NO PRESET
declare -a valid_input_file_extensions_array=(".m4v"
																          ".mp4"
                                          ".mkv"
                                          ".avi"
                                          ".mov"
                                          ".m4a"
                                          ".3gp"
                                          ".3g2"
                                          ".mj2"
                                          ".*")

declare -a valid_output_file_extensions_array=(".m4v"
																          ".mp4"
                                          ".mkv")

# SET DEFAULT TRANSCODE DIRECTORY
transcode_directory="./"
transcode_directory_set="not set"

# SET DEFAULT OUTPUT DIRECTORY - SAME AS INPUT DIRECTORY
output_directory="$transcode_directory"
output_directory_set="not set"

# SET DEFAULT move DIRECTORY - SAME AS INPUT DIRECTORY - files not moved unless "set"
move_directory="$transcode_directory"
move_directory_set="not set"

# SET DEFAULT INPUT FILE EXTENSION - DEFAULT IS .mp4
input_file_extension=".mp4"
input_file_extension_set="not set"

# SET DEFAULT OUTPUT FILE EXTENSION - DEFAULT IS .m4v
output_file_extension=".m4v"
output_file_extension_set="not set"

# SET FACT THAT SUBTITLES OR NOT HAS NOT BEEN SET
add_subs_set="not set"
subtitle_extension_set="not set"
add_subs_skip="FALSE"

# SET "true" if read (used) NEXT ARGUMENT FOR OPTION TO SWITCH before
skip_next_arg="false"

# Up-Convert - set or NOT
up_convert_set="not set"
up_convert="FALSE" # the default if not set

# Up-Convert level
declare -a up_convert_level_array=("720"
																    "1080"
                                    "2160"
                                    "4320")
up_convert_level="1080"  # Default up-convert
up_convert_level_set="not set"

# Continue - set or NOT
continue_set="not set"
continue="FALSE" # the default if not set

# Make Directory Structure - set or NOT
make_directory_structure_set="not set"
make_directory_structure="FALSE" # the default if not set

# LOG FILE - Set or NOT
log_file="none"
log_file_set="not set"
make_log_file="FALSE" # the default if not set

# Details - set or NOT
details_set="not set"
details="FALSE" # the default if not set

# Quiet - set or NOT
quiet_set="not set"
quiet="FALSE" # the default if not set

clean_up() {
  # Perform program exit housekeeping
  tput sgr0
  rm -f "$TEMP_FILE"
  [[ $1 == 0 ]] && echo -e "\nThank you for using encode2m4v!"
  exit $1
}

# Set to clean_up on <ctrl> + c etc...
trap clean_up SIGHUP SIGINT SIGTERM

error_exit() {
  # Display error message and exit
  echo "${the_app_name}: ${1:-"Unknown Error"}" 1>&2
  clean_up 1
}

#
# Cycle through command line args - set for what is found or display and exit
#
# READ COMMAND LINE SWITCHES or # CONFIG FILE # INTO ARRAY
#    IF ONLY -h OR --help THEN DISPLAY the_usage(*) AND QUIT
#    IF ONLY -v or --version THEN DISPLAY the_version AND QUIT
#    IF SWITCH IS RECOGNIZED THEN PUT/SET APPROPRIATE SETTINGS FOR OPTION
#    IF SWITCH IS NOT RECOGNIZED THEN EXIT WITH ERROR AND DISPLAY UNRECOGNIZED SWITCH & the_usage(*)
# IF NO SWITCHES ALL THE THE PROMPTS WILL OCCUR
#
cmd_line_args_array=( "$@" )
# Set the number of arguments passed on the command line into cmd_line_args_array_length
cmd_line_args_array_length=${#cmd_line_args_array[@]}
for ((i=0;i<1;i++)); do cmd_line_cmd="${!i}"; done  # set the command line as what was run (before arguments)

for ((arg_index=0;arg_index<$cmd_line_args_array_length;arg_index++)); do

	# NEED TO READ FIRST ARGUMENT AS DIRECTORY TO SET AS STARTING DIRECTORY
	if [[ $arg_index -eq 0 ]] ; then  # CAN GET RID OF ALL BELOW, BUT KEEP LAST ONE???
    if [[ "${cmd_line_args_array[arg_index]^^}" != "-V" ]] &&
			 [[ "${cmd_line_args_array[arg_index]^^}" != "--VERSION" ]] &&
			 [[ "${cmd_line_args_array[arg_index]^^}" != "-H" ]] &&
			 [[ "${cmd_line_args_array[arg_index]^^}" != "--HELP" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "-G" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--GUIDE" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "-F" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--FILE"* ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "-P" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--PRESET"* ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "-J" ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "--JSON"* ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "-S" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--SUBTITLE"* ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "-T" ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "--TRANSOPT"* ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "-U" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--UPCONVERT" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "-N" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--NOUPCONVERT" ]] &&
			 [[ "${cmd_line_args_array[arg_index]^^}" != "-C" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--CONTINUE" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "-B" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--BREAK" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "-O" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--OUTPUT"* ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "-R" ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "--RECREATEDIRS" ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "-M" ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "--MOVE"* ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "-L" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--LOGFILE"* ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "-D" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--DETAILS" ]] &&
			 [[ "${cmd_line_args_array[arg_index]^^}" != "-Q" ]] &&
		   [[ "${cmd_line_args_array[arg_index]^^}" != "--QUIET" ]] &&
       [[ "${cmd_line_args_array[arg_index]^^}" != "-"* ]] ; then
	      transcode_directory="${cmd_line_args_array[arg_index]}"
    	  transcode_directory_set="set"
    		# NEED TO PUT TEST TO SEE IF VALID AND EXISTING DIRECTORY
    		#
        # CHECK FOR transcode_directory EXISTENCE
        if [ -d "$transcode_directory" ] && ! [ -h "$transcode_directory" ] ; then
          transcode_directory_found="TRUE"
        else
          error_description="ERROR: INVALID \"TRANSCODE\" Directory:"
          tput setaf 1
          tput setab 7
          echo ""
          echo -e "$error_description "
          echo -e "\nThe directory passed in: \"$transcode_directory\" DOES NOT EXIST!\n"
          echo "USAGE: $the_usage1"
          echo "$the_usage2"
          echo ""
          transcode_directory_found="FALSE"
          tput sgr0
          error_exit "${error_description}"
  	      # exit 1
        fi

        # if transcode_directory does not end with a / then add it...
        if [[ ! "$transcode_directory" == */ ]] ; then
          # echo 'It does NOT end with a "/"' ADD IT
          transcode_directory="$transcode_directory/"
        # else
        #   echo 'It does end with a "/"'
        fi

        # SET IN ORDER FOR NEXT WHILE LOOP TO SKIP arg_index 0 - IT WAS THE transcode_directory
        #
    		skip_next_arg="true"
	   elif	[ "${cmd_line_args_array[arg_index]^^}" == "-F" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--FILE"* ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-P" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--PRESET"* ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-J" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--JSON"* ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-S" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--SUBTITLE"* ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-T" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--TRANSOPT"* ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-U" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--UPCONVERT" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-N" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--NOUPCONVERT" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-C" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--CONTINUE" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-B" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--BREAK" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-O" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--OUTPUT"* ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-R" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--RECREATEDIRS" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-M" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--MOVE"* ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-L" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--LOGFILE"* ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-D" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--DETAILS" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-Q" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "--QUIET" ] ||
          [ "${cmd_line_args_array[arg_index]^^}" == "-"* ] ; then
		      # ARGUMENTS FOUND, BUT NOT A TRANSCODE DIRECTORY
          error_description="ERROR: MISSING \"TRANSCODE\" Directory"
          tput setaf 1
          tput setab 7
          echo ""
		      echo -e "$error_description Check usage:\n"
          echo "USAGE: $the_usage1"
          echo "$the_usage2"
          echo ""
          tput sgr0
          error_exit "${error_description}"
  	      # exit 1
	      fi
      fi
	if [[ $skip_next_arg != "true" ]] ; then # IF CURRENT ARG WAS NOT USED AS OPTION FOR LAST SWITCH
		arg="${cmd_line_args_array[arg_index]}";
	  case "${arg^^}" in
	    "-V" | "--VERSION")  # DISPLAY THE VERSION NUMBER AND EXIT
        tput setaf 1
        tput setab 7
        echo ""
			  echo $the_version
        tput sgr0
				exit 0
				;;
			"-H" | "--HELP")  # HOW DO I GET "-?" |  IN HERE?? # DISPLAY THE HELP AND EXIT
        tput setaf 1
        tput setab 7
        echo ""
				echo "USAGE: $the_help0"
				echo "$the_help1"
				echo "$the_help2"
				echo "$the_help3"
				echo "$the_help4"
				echo "$the_help5"
				# echo "$the_help6"
				echo "$the_help7"
				echo "$the_help8"
				echo "$the_help9"
				echo "$the_help10"
				echo "$the_help11"
				echo "$the_help12"
				echo "$the_help13"
				echo "$the_help14"
				echo "$the_help15"
    		echo "$the_help16"
        echo "$the_help17"
        echo "$the_help18"
        echo "$the_help19"
        echo "$the_help20"
        echo "$the_help21"
        echo "$the_help22"
        tput sgr0
				exit 0
			;;
			"-G" | "--GUIDE") # DISPLAY THE GUIDE USING more AND EXIT
        tput setaf 1
        tput setab 7
        echo ""
        # use temp file in temp directory for the ManPaage file
        # to be able to use more to show it
        if [ -d "~/tmp" ]; then
          TEMP_DIR=~/tmp
        else
          TEMP_DIR=/tmp
        fi
        TEMP_FILE="$TEMP_DIR/$the_app_name.$$.$RANDOM"
				echo "$the_instructions" > "$TEMP_FILE"
        more "$TEMP_FILE"
        clean_up 0
        tput sgr0
				exit 0
				;;
			"-P" | "--PRESET="* )  # SET A HandBrakeCLI PRESET
				if [[ "${arg^^}" == "-P" ]]; then
					# must have another arg... CHECK CASE - AS BELOW OR ERROR - CHECK MUST BE VALID PRESET
					# if -p option is last arg THEN  MISSING PRESET NAME OPTION
					if (( $arg_index == ($cmd_line_args_array_length - 1) )) ; then
            error_description="MISSING \"HandBrake Preset\""
            tput setaf 1
            tput setab 7
            echo ""
						echo -e "$error_description Check usage:\n"
						echo "USAGE: (examples)"
						echo "$cmd_line_cmd <root directory> -p \"HQ 1080p30 Surround\""
						echo "OR"
						echo "$cmd_line_cmd <root directory> --preset=\"HQ 1080p30 Surround\""
						echo ""
						echo "For full usage use the -h or --help switch."
						echo ""
            tput sgr0
            error_exit "${error_description}"
    	      # exit 1
					else

						# FIRST SET -
						preset_to_use="${cmd_line_args_array[(arg_index+1)]}"  # arg after -p
					  # THEN - VALIDATE AGAINST THE VALID HandBrake PRESETS
						if [[ "${valid_presets_array[*]}" =~ "${preset_to_use}" ]] || [[ "${preset_to_use}" == "" ]] ; then
              preset_to_use_set="set"
            else # NOT A VALID PRESET
              error_description="BAD \"HandBrake Preset\""
              tput setaf 1
              tput setab 7
              echo ""
							echo -e "$error_description Check usage:\n"
							echo "USAGE: (examples)"
							echo "$cmd_line_cmd <root directory> -p \"HQ 1080p30 Surround\""
							echo "OR"
							echo "$cmd_line_cmd <root directory> --preset=\"HQ 1080p30 Surround\""
							echo ""
              echo "$preset_list"
							echo ""
							echo "For full usage use the -h or --help switch."
							echo ""
              tput sgr0
              error_exit "${error_description}"
      	      # exit 1
						fi
            # NEXT ARG USED AS OPTION TO THIS CURRENT ARG
						skip_next_arg="true"
					fi
				elif [[ "${arg^^}" == "--PRESET="* ]]; then

					# VALIDATE RIGHT SIDE FOR VALID HandBrake PRESET
					preset_to_use=$(echo "$arg" | grep -o '[^=]*$')
					# CHECK IF VALID OR Not
					#
          if [[ "${valid_presets_array[*]}" =~ "${preset_to_use}" ]] || [[ "${preset_to_use}" == "" ]] ; then
            preset_to_use_set="set"
          else # NOT A VALID PRESET
            error_description="BAD \"HandBrake Preset\""
            tput setaf 1
            tput setab 7
            echo ""
						echo -e "$error_description Check usage:\n"
						echo "USAGE: (examples)"
						echo "$cmd_line_cmd <root directory> -p \"HQ 1080p30 Surround\""
						echo "OR"
						echo "$cmd_line_cmd <root directory> --preset=\"HQ 1080p30 Surround\""
						echo""
						echo "$preset_list"
						echo ""
						echo "For full usage use the -h or --help switch."
						echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
					fi
					skip_next_arg="false"
				fi
				;;
      "-J" | "--JSON="* ) # SET A HandBrake .json setting file
        if [[ "${arg^^}" == "-J" ]]; then
          # must have another arg...
          # if -j option is last arg THEN  MISSING .json setting filename OPTION
          if (( $arg_index == ($cmd_line_args_array_length - 1) )) ; then
            error_description="MISSING \"HandBrake .json settings file\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description Check usage:\n"
            echo "USAGE: (examples)"
            echo "$cmd_line_cmd <root directory> -j \"My HandBrake settings.json\""
            echo "OR"
            echo "$cmd_line_cmd <root directory> --json=\"My HandBrake settings.json\""
            echo ""
            echo "For full usage use the -h or --help switch."
            echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          else

            # FIRST SET -
            HandBrake_json_to_use="${cmd_line_args_array[(arg_index+1)]}"
            # THEN - CHECK THAT .json FILE EXISTS
            if [[ -f "$HandBrake_json_to_use" ]]; then
              HandBrake_json_to_use_set="set"
            else
              error_description="MISSING \"HandBrake .json settings file\""
              tput setaf 1
              tput setab 7
              echo ""
              echo -e "$error_description Check usage:\n"
              echo "USAGE: (examples)"
              echo "$cmd_line_cmd <root directory> -j \"My HandBrake settings.json\""
              echo "OR"
              echo "$cmd_line_cmd <root directory> --json=\"My HandBrake settings.json\""
              echo ""
              echo "For full usage use the -h or --help switch."
              echo ""
              tput sgr0
              error_exit "${error_description}"
              # exit 1
            fi
            # NEXT ARG USED AS OPTION TO THIS CURRENT ARG
            skip_next_arg="true"
          fi
        elif [[ "${arg^^}" == "--JSON="* ]]; then

          # VALIDATE RIGHT SIDE FOR VALID HandBrake .json settings file
          HandBrake_json_to_use=$(echo "$arg" | grep -o '[^=]*$')
          # THEN - CHECK THAT .json FILE EXISTS
          if [[ -f "$HandBrake_json_to_use" ]]; then
            HandBrake_json_to_use_set="set"
          else
            error_description="MISSING \"HandBrake .json settings file\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description Check usage:\n"
            echo "USAGE: (examples)"
            echo "$cmd_line_cmd <root directory> -j \"My HandBrake settings.json\""
            echo "OR"
            echo "$cmd_line_cmd <root directory> --json=\"My HandBrake settings.json\""
            echo""
            echo "For full usage use the -h or --help switch."
            echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          fi
          skip_next_arg="false"
        fi
        ;;
        "-I" | "--INEXT="* )
        if [[ "${arg^^}" == "-I" ]]; then
          # must have another arg...
          # if -i option is last arg THEN  MISSING INPUT FILE EXTENSION OPTION
          if (( $arg_index == ($cmd_line_args_array_length - 1) )) ; then
            error_description="MISSING \"Input Extension\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description Check usage:\n"
            echo "USAGE: (examples)"
            echo "$cmd_line_cmd <root directory> -i \".mp4\""
            echo "OR"
            echo "$cmd_line_cmd <root directory> --inext=\".mkv\""
            echo ""
            echo "For full usage use the -h or --help switch."
            echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          else

            # SET - THEN - VALIDATE AGAINST THE VALID input EXTENSIONS
            input_file_extension="${cmd_line_args_array[(arg_index+1)]}"
            if [[ "${valid_input_file_extensions_array[*]^^}" =~ "${input_file_extension^^}" ]] ; then
              input_file_extension_set="set"
            else # NOT A VALID EXTENSION
              error_description="BAD \"Input Extension\""
              tput setaf 1
              tput setab 7
              echo ""
              echo -e "$error_description Check usage:\n"
              echo "USAGE: (examples)"
              echo "$cmd_line_cmd <root directory> -i \".mp4\""
              echo "OR"
              echo "$cmd_line_cmd <root directory> --inext=\".mkv\""
              echo ""
              echo "For full usage use the -h or --help switch."
              echo ""
              tput sgr0
              error_exit "${error_description}"
              # exit 1
            fi
            skip_next_arg="true"
          fi
        elif [[ "${arg^^}" == "--INEXT="* ]]; then

          # SET INPUT EXTENSION
          input_file_extension=$(echo "$arg" | grep -o '[^=]*$')
          # CHECK IF VALID OR Not
          #
          if [[ "${valid_input_file_extensions_array[*]^^}" =~ "${input_file_extension^^}" ]] ; then
            input_file_extension_set="set"
          else  # NOT A VALID EXTENSION
            error_description="BAD \"Input Extension\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description Check usage:\n"
            echo "USAGE: (examples)"
            echo "$cmd_line_cmd <root directory> -i \".mp4\""
            echo "OR"
            echo "$cmd_line_cmd <root directory> --inext=\".mkv\""
            echo ""
            echo "For full usage use the -h or --help switch."
            echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          fi
          skip_next_arg="false"
        fi
        ;;
      "-E" | "--EXT="* )
        if [[ "${arg^^}" == "-E" ]]; then
          # must have another arg...
          # if -e option is last arg THEN  MISSING OUTPUT FILE EXTENSION OPTION
          if (( $arg_index == ($cmd_line_args_array_length - 1) )) ; then
            error_description="MISSING \"Output File Extension\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description Check usage:\n"
            echo "USAGE: (examples)"
            echo "$cmd_line_cmd <root directory> -e \".mkv\""
            echo "OR"
            echo "$cmd_line_cmd <root directory> --ext=\".m4v\""
            echo ""
            echo "For full usage use the -h or --help switch."
            echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          else

            # SET AS NEXT ARGUMENT
            output_file_extension="${cmd_line_args_array[(arg_index+1)]}"

            # VALIDATE AGAINST VALID OUTPUT EXTENSIONS ARRAY
            if [[ "${valid_output_file_extensions_array[*]^^}" =~ "${output_file_extension^^}" ]] ; then
              output_file_extension_set="set"
            else # NOT A VALID OUTPUT FILE EXTENSION
              error_description="BAD \"Output File Extension\""
              tput setaf 1
              tput setab 7
              echo ""
              echo -e "$error_description Check usage:\n"
              echo "USAGE: (examples)"
              echo "$cmd_line_cmd <root directory> -e \".mkv\""
              echo "OR"
              echo "$cmd_line_cmd <root directory> --ext=\".m4v\""
              echo ""
              echo "For full usage use the -h or --help switch."
              echo ""
              tput sgr0
              error_exit "${error_description}"
              # exit 1
            fi
            skip_next_arg="true"
          fi
        elif [[ "${arg^^}" == "--EXT="* ]]; then

          # SET EXTENSION AS NEXT ARG
          output_file_extension=$(echo "$arg" | grep -o '[^=]*$')
          # CHECK IF VALID OR Not
          #
          if [[ "${valid_output_file_extensions_array[*]^^}" =~ "${output_file_extension^^}" ]] ; then
            output_file_extension_set="set"
          else # NOT VALID OUTPUT EXTENSION
            error_description="BAD \"Input Extension\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description Check usage:\n"
            echo "USAGE: (examples)"
            echo "$cmd_line_cmd <root directory> -e \".mkv\""
            echo "OR"
            echo "$cmd_line_cmd <root directory> --ext=\".m4v\""
            echo ""
            echo "For full usage use the -h or --help switch."
            echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          fi
          skip_next_arg="false"
        fi
        ;;
			"-S" | "--SUBTITLE="* )
				if [[ "${arg^^}" == "-S" ]]; then
					#must have another arg... CHECK CASE - AS BELOW OR ERROR - CHECK MUST END IN .srt
					# if -s option is last arg THEN  MISSING EXTENSION OPTION
					if (( $arg_index == ($cmd_line_args_array_length - 1) )) ; then
            error_description="MISSING \"subtitle_extension\""
            tput setaf 1
            tput setab 7
            echo ""
						echo -e "$error_description Check usage:\n"
						echo "USAGE: (examples)"
						echo "$cmd_line_cmd <root directory> -s \".srt\""
						echo "OR"
						echo "$cmd_line_cmd <root directory> --subtitle=\"_en.srt\""
						echo ""
						echo "For full usage use the -h or --help switch."
						echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
					else
            # CHECK FOR VALID SUBTITLE EXTENSION (END IN .srt...)
						subtitle_extension="${cmd_line_args_array[(arg_index+1)]}"

					  # TEST IF VALID srt SETTING
						if [[ "$subtitle_extension" != "0" ]] && [[ "${subtitle_extension^^}" != "NONE" ]] && [[ -n "$subtitle_extension" ]] && [[ -z ${subtitle_extension##*.srt} ]] || [[ -z ${subtitle_extension##*.SRT} ]] ; then
							subtitle_extension_set="set"
							add_subs="TRUE"
							add_subs_set="set"
            elif [[ "$subtitle_extension" == "0" ]] || [[ "${subtitle_extension^^}" == "NONE" ]] ; then
              subtitle_extension_set="set"
  						sub_choice="none"
  						add_subs="FALSE"
  						add_subs_set="set"
            elif [[ ! -z ${subtitle_extension##*.srt} ]] && [[ ! -z ${subtitle_extension##*.SRT} ]] ; then
              # NOT AN .srt FILE - BAD EXTENSION
              error_description="BAD \"subtitle_extension\""
              tput setaf 1
              tput setab 7
              echo ""
              echo -e "$error_description - must be SubRipper type and end in .srt - Check usage:\n"
  						echo "USAGE: (examples)"
  						echo "$cmd_line_cmd <root directory> -s \".srt\""
  						echo "OR"
  						echo "$cmd_line_cmd <root directory> --subtitle=\"_en.srt\""
  						echo ""
  						echo "For full usage use the -h or --help switch."
  						echo ""
              tput sgr0
              error_exit "${error_description}"
              # exit 1
            else # EXTENSION SET TO NO SUBTITLES
							subtitle_extension_set="set"
							sub_choice="none"
							add_subs="FALSE"
							add_subs_set="set"
						fi
						skip_next_arg="true"
					fi
				elif [[ "${arg^^}" == "--SUBTITLE="* ]]; then

					# VALIDATE RIGHT SIDE FOR CORRECT SUBTITLE EXTENSION (NOT MISSING THE. AND ...)
					subtitle_extension=$(echo "$arg" | grep -o '[^=]*$')
					# NEED TO CHECK IF VALID OR Not
					#
					if [[ "$subtitle_extension" != "0" ]] && [[ "${subtitle_extension^^}" != "NONE" ]] && [[ -n "$subtitle_extension" ]] && [[ -z ${subtitle_extension##*.srt} ]] || [[ -z ${subtitle_extension##*.SRT} ]] ; then
						subtitle_extension_set="set"
						add_subs="TRUE"
						add_subs_set="set"
          elif [[ "$subtitle_extension" == "0" ]] || [[ "${subtitle_extension^^}" == "NONE" ]] ; then
            subtitle_extension_set="set"
						sub_choice="none"
						add_subs="FALSE"
						add_subs_set="set"
          elif [[ ! -z ${subtitle_extension##*.srt} ]] && [[ ! -z ${subtitle_extension##*.SRT} ]] ; then
            # NOT AN .srt FILE - BAD EXTENSION
            error_description="BAD \"subtitle_extension\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description - must be SubRipper type and end in .srt - Check usage:\n"
						echo "USAGE: (examples)"
						echo "$cmd_line_cmd <root directory> -s \".srt\""
						echo "OR"
						echo "$cmd_line_cmd <root directory> --subtitle=\"_en.srt\""
						echo ""
						echo "For full usage use the -h or --help switch."
						echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          else # EXTENSION SET TO NO SUBTITLES
						subtitle_extension_set="set"
						sub_choice="none"
						add_subs="FALSE"
						add_subs_set="set"
					fi
					skip_next_arg="false"
				fi
			;;
    "-T" | "--TRANSOPT="* )
			if [[ "${arg^^}" == "-T" ]]; then
				# must have another arg...
				# if -t option is last arg THEN  MISSING TRANSCODE OPTIONS argument
				if (( $arg_index == ($cmd_line_args_array_length - 1) )) ; then
          error_description="MISSING \"transcode options\""
          tput setaf 1
          tput setab 7
          echo ""
					echo -e "$error_description Check usage:\n"
					echo "USAGE: (examples)"
					echo "$cmd_line_cmd <root directory> -t \"<options>\""
					echo "OR"
					echo "$cmd_line_cmd <root directory> --transopt=\"<options>\""
					echo ""
					echo "For full usage use the -h or --help switch."
					echo ""
          tput sgr0
          error_exit "${error_description}"
          # exit 1
				else
					HandBrakeCLI_transcoding_options="${cmd_line_args_array[(arg_index+1)]}"
          HandBrakeCLI_transcoding_options_set="set"
					skip_next_arg="true"
				fi
			elif [[ "${arg^^}" == "--TRANSOPT="* ]]; then

				# VALIDATE RIGHT SIDE FOR VALID HandBrakeCLI transcoding options (ha!)
				HandBrakeCLI_transcoding_options=$(echo "$arg" | grep -o '[^=]*$')
        HandBrakeCLI_transcoding_options_set="set"
				# NEED TO CHECK IF VALID OR Not
				#
				skip_next_arg="false"
			fi
			;;
			"-U" | "--UPCONVERT")
      	# echo "Upconverting to 1080!"
				up_convert="TRUE"
				up_convert_set="set"
			;;
			"-N" | "--NOUPCONVERT")
      	# echo "NOT Upconverting to 1080..."
				up_convert="FALSE"
				up_convert_set="set"
				;;
			"-C" | "--CONTINUE")
				# Continue if subtitle file is not found
				continue="TRUE"
				continue_set="set"
				;;
			"-B" | "--BREAK")
				# Stop if subtitle file is not found
				continue="FALSE"
				continue_set="set"
				;;
      "-O" | "--OUTPUT="* )
        if [[ "${arg^^}" == "-O" ]]; then
          # must have another arg...
          # if -o option is last arg THEN  MISSING OUTPUT DIRECTORY OPTION
          if (( $arg_index == ($cmd_line_args_array_length - 1) )) ; then
            error_description="MISSING \"Output Directory\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description Check usage:\n"
            echo "USAGE: (examples)"
            echo "$cmd_line_cmd <root directory> -o \"/Users/MyUser/Movies/Processed/\""
            echo "OR"
            echo "$cmd_line_cmd <root directory> --output=\"/Users/MyUser/Movies/Processed/\""
            echo ""
            echo "For full usage use the -h or --help switch."
            echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          else

            # BEFORE SETTING - VALIDATE - IF SET TO ONE DIRECTORY EXISTING FILES
            # OR EARLIER PROCESSED FILES WITH SAME NAME WILL BE OVERWRITTEN
            output_directory="${cmd_line_args_array[(arg_index+1)]}"
            output_directory_set="set"
            # if output_directory does not end with a / then add it...
            if [[ ! "$output_directory" == */ ]] ; then
              # It does NOT end with a "/" ADD IT
              output_directory="$output_directory/"
            # else
            #   It does end with a "/"
            fi
            skip_next_arg="true"
          fi
        elif [[ "${arg^^}" == "--OUTPUT="* ]]; then

          # BEFORE SETTING - VALIDATE - IF SET TO ONE DIRECTORY EXISTING FILES
          # OR EARLIER PROCESSED FILES WITH SAME NAME WILL BE OVERWRITTEN
          output_directory=$(echo "$arg" | grep -o '[^=]*$')
          output_directory_set="set"
          # if output_directory does not end with a / then add it...
          if [[ ! "$output_directory" == */ ]] ; then
            # It does NOT end with a "/"
            output_directory="$output_directory/"
          # else
          #   It does end with a "/"
          fi
          skip_next_arg="false"
        fi
        ;;
      "-R" | "--RECREATEDIRS")
        # Set to make same directory structure in output directory
        make_directory_structure="TRUE"
        make_directory_structure_set="set"
        ;;
      "-M" | "--MOVE="* )
        if [[ "${arg^^}" == "-M" ]]; then
          # must have another arg...
          # if -m option is last arg THEN  MISSING move DIRECTORY OPTION
          if (( $arg_index == ($cmd_line_args_array_length - 1) )) ; then
            error_description="MISSING \"Move (to) Directory\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description Check usage:\n"
            echo "USAGE: (examples)"
            echo "$cmd_line_cmd <root directory> -m \"/Users/MyUser/Movies/Processed/\""
            echo "OR"
            echo "$cmd_line_cmd <root directory> --move=\"/Users/MyUser/Movies/Processed/\""
            echo ""
            echo "For full usage use the -h or --help switch."
            echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          else

            # BEFORE SETTING - VALIDATE - IF SET TO ONE DIRECTORY EXISTING FILES
            # OR EARLIER PROCESSED FILES WITH SAME NAME WILL BE OVERWRITTEN
            move_directory="${cmd_line_args_array[(arg_index+1)]}"
            move_directory_set="set"
            # if move_directory does not end with a / then add it...
            if [[ ! "$move_directory" == */ ]] ; then
              # It does NOT end with a "/" ADD IT
              move_directory="$move_directory/"
            # else
            #   It does end with a "/"
            fi
            skip_next_arg="true"
          fi
        elif [[ "${arg^^}" == "--MOVE="* ]]; then

          # BEFORE SETTING - VALIDATE - IF SET TO ONE DIRECTORY EXISTING FILES
          # OR EARLIER PROCESSED FILES WITH SAME NAME WILL BE OVERWRITTEN
          move_directory=$(echo "$arg" | grep -o '[^=]*$')
          move_directory_set="set"
          # if move_directory does not end with a / then add it...
          if [[ ! "$move_directory" == */ ]] ; then
            # It does NOT end with a "/" ADD IT
            move_directory="$move_directory/"
          # else
          #   It does end with a "/"
          fi
          skip_next_arg="false"
        fi
        ;;
      "-L" | "--LOGFILE="* )
        if [[ "${arg^^}" == "-L" ]]; then
          # must have another arg... - CHECK MUST BE VALID filename
          # if -l option is last arg THEN  MISSING FILENAME OPTION
          if (( $arg_index == ($cmd_line_args_array_length - 1) )) ; then
            error_description="MISSING \"Logfile name\""
            tput setaf 1
            tput setab 7
            echo ""
            echo -e "$error_description Check usage:\n"
            echo "USAGE: (examples)"
            echo "$cmd_line_cmd <root directory> -l \"processed.log\""
            echo "OR"
            echo "$cmd_line_cmd <root directory> --logfile=\"encodeM4V.log\""
            echo ""
            echo "For full usage use the -h or --help switch."
            echo ""
            tput sgr0
            error_exit "${error_description}"
            # exit 1
          else

            # BEFORE SETTING - VALIDATE -??
            log_file="${cmd_line_args_array[(arg_index+1)]}"
            log_file_set="set"
            make_log_file="TRUE"
            skip_next_arg="true"
          fi
        elif [[ "${arg^^}" == "--LOGFILE="* ]]; then

          # SET
          log_file=$(echo "$arg" | grep -o '[^=]*$')
          log_file_set="set"
          make_log_file="TRUE"
          # CHECK IF VALID OR Not - ??
          #
          skip_next_arg="false"
        fi
        ;;
      "-D" | "--DETAILS")
				# Set show HandBrakeCLI details
				details="TRUE"
				details_set="set"
				;;
			"-Q" | "--QUIET")
				# Set no prompts
				quiet="TRUE"
				quiet_set="set"
				;;
			*) error_description="invalid option: $arg"
        tput setaf 1
        tput setab 7
        echo -e "$error_description\n"
			  echo "USAGE: $the_usage1"
				echo "$the_usage2"
        echo ""
        tput sgr0
        error_exit "${error_description}"
        # exit 1
			  ;;
		esac
	else
		# Re-Set SKIP ARGUMENT - IT WAS skipped now use next arg
		skip_next_arg="false"
	fi
done

# IF QUIET NOT REQUESTED - DISPLAY WELCOME
if [[ $quiet != "TRUE" ]] ; then
	tput setaf 1
	tput setab 7
	echo -e "\nWelcome to encode2m4v - the MP4 to M4V transcoder! \n"
  echo ""
	tput sgr0
fi

# START LOGFILE
if [[ "$make_log_file" == "TRUE" ]] ; then
  # SET AND PUT HEADER - JSON FORMAT
  if [[ "$output_directory" != "./" ]]; then
    output_log_file="$output_directory$log_file"
    # CHECK FOR OUTPUT DIRECTORY EXISTANCE OR CREATE IT
    if [ ! -d "$output_directory" ] ; then # && ! [ ! -h "$output_directory" ]
      mkdir -p "$output_directory" > /dev/null 2>&1
    fi
  else
    output_log_file="$transcode_directory$log_file"
  fi

  the_utc_offset=$(date +%z)
  the_start_date_and_time=$(date "+%d/%b/%Y:%H:%M:%S ")$the_utc_offset
  echo -e "{" > "$output_log_file"
  echo -e "  \"time\" : \"$the_start_date_and_time\"," >> "$output_log_file"
  echo -e "  \"the_app_name\" : \"$the_app_name\"," >> "$output_log_file"
  echo -e "  \"VersionMajor\" : $the_version_major," >> "$output_log_file"
  echo -e "  \"VersionMinor\" : $the_version_minor," >> "$output_log_file"
  echo -e "  \"VersionMicro\" : $the_version_micro," >> "$output_log_file"
fi

# PUT IF SUBTITLE EXTENSION NOT SET - THEN PROMPT WHETHER SUBTITLE file_ext
#
# Prompt with CASE stmt : Select Subtitle Extension (0 - No Subtitles, 1 - .srt, 2 - .en.srt, 3 - _en.srt, 4 - other)
#
if [[ "$subtitle_extension_set" == "not set" ]] ; then
  # echo "Select the subtitle extension (0 - No Subtitles, 1 - .srt, 2 - .en.srt, 3 - _en.srt, 4 - other)(.srt):"
  tput setaf 1
  tput setab 7
  echo "SUBTITLE EXTENSION MENU"
  echo "-----------------------"
PS3='Select the subtitle extension(.srt): '
  menu_options=("No Subtitles" ".srt" ".en.srt" "_en.srt" "other")
  num_menu_options=${#menu_options[@]}
  select opt in "${menu_options[@]}"
  do
    case $opt in
    	"No Subtitles")
      	add_subs="FALSE"
      	subtitle_extension=""
        echo -e " - SELECTED - 1 - No Subtitles"
        echo ""
        tput sgr0
        break
        ;;
    	".srt")
      	add_subs="TRUE"
      	subtitle_extension=".srt"
        subtitle_extension_set="set"
        echo -e " - SELECTED - 2 - .srt"
        echo ""
        tput sgr0
        break
        ;;
    	".en.srt")
      	add_subs="TRUE"
      	subtitle_extension=".en.srt"
        subtitle_extension_set="set"
        echo -e " - SELECTED - 3 - .en.srt"
        echo ""
        tput sgr0
        break
        ;;
    	"_en.srt")
      	add_subs="TRUE"
      	subtitle_extension="_en.srt"
        subtitle_extension_set="set"
        echo -e " - SELECTED - 4 - _en.srt"
        tput sgr0
        echo ""
        break
        ;;
    	"other")
      	add_subs="TRUE"
      	printf "\nEnter subtitle extension: "
      	IFS= read -r subtitle_extension
        # NEED TO VALIDATE SUBTITLE EXTENSION...
        if [[ ! -z ${subtitle_extension##*.srt} ]] && [[ ! -z ${subtitle_extension##*.SRT} ]] ; then
          # NOT AN .srt FILE - BAD EXTENSION
          error_description="BAD \"subtitle_extension\""
          echo -e "$error_description - must be SubRipper type and end in .srt - Check usage:\n"
          echo "USAGE: (examples)"
          echo "$cmd_line_cmd <root directory> -s \".srt\""
          echo "OR"
          echo "$cmd_line_cmd <root directory> --subtitle=\"_en.srt\""
          echo ""
          echo "For full usage use the -h or --help switch."
          echo ""
          tput sgr0
          error_exit "${error_description}"
          # exit 1
        else # EXTENSION SET
          echo -e "\n - SET - $subtitle_extension"
          echo ""
          tput sgr0
          subtitle_extension_set="set"
          add_subs_set="set"
        fi
        break
        ;;
    	*)
      	add_subs="TRUE"
      	subtitle_extension=".srt"
        subtitle_extension_set="set"
        echo -e " - SELECTED - 2 - .srt"
        echo ""
        tput sgr0
        break
        ;;
    	esac
  done
fi

if [[ "$up_convert_set" == "not set" ]] ; then
  tput setaf 1
  tput setab 7
  printf "Do you want all files upconverted to 1080? (no): "
	IFS= read -r do_up_convert
	case ${do_up_convert^^} in
	NO)
	up_convert="FALSE";;
	N)
	up_convert="FALSE";;
	YES)
	up_convert="TRUE";;
	Y)
	up_convert="TRUE";;
	*)
	up_convert="FALSE";;
	esac
  echo ""
  tput sgr0
fi

if [ -z "$1" ] ; then
	transcode_directory="./"
	transcode_directory_set="set"
# else
# 	transcode_directory="$1"
# Set Above...
fi

# SETTINGS INTO LOGFILE
if [[ "$make_log_file" == "TRUE" ]] ; then

  # LOG SELECTED OPTIONS - JSON FORMAT
  echo -e "  \"encode2m4v_options\" : {" >> "$output_log_file"
  echo -e "      \"transcode_directory\" : \"$transcode_directory\"," >> "$output_log_file"
  echo -e "      \"output_directory\" : \"$output_directory\"," >> "$output_log_file"
  echo -e "      \"make_directory_structure\" : \"$make_directory_structure\"," >> "$output_log_file"
  echo -e "      \"move_directory\" : \"$move_directory\"," >> "$output_log_file"
  echo -e "      \"input_file_extension\" : \"$input_file_extension\"," >> "$output_log_file"
  echo -e "      \"output_file_extension\" : \"$output_file_extension\"," >> "$output_log_file"
  echo -e "      \"add_subs\" : \"$add_subs\"," >> "$output_log_file"
  echo -e "      \"subtitle_extension\" : \"$subtitle_extension\"," >> "$output_log_file"
  echo -e "      \"HandBrakeCLI_transcoding_options\" : \"$HandBrakeCLI_transcoding_options\"," >> "$output_log_file"
  echo -e "      \"up_convert\" : \"$up_convert\"," >> "$output_log_file"
  echo -e "      \"preset_to_use\" : \"$preset_to_use\"," >> "$output_log_file"
  echo -e "      \"HandBrake_json_to_use\" : \"$HandBrake_json_to_use\"," >> "$output_log_file"
  echo -e "      \"continue\" : \"$continue\"," >> "$output_log_file"
  echo -e "      \"quiet\" : \"$quiet\"," >> "$output_log_file"
  echo -e "      \"make_log_file\" : \"$make_log_file\"," >> "$output_log_file"
  echo -e "      \"log_file\" : \"$log_file\"" >> "$output_log_file"
  echo -e "    }," >> "$output_log_file"
fi

# ERROR - IF in ext = out ext && transcode dir == output directory
if [ "$input_file_extension" = "$output_file_extension" ] && ([ "$transcode_directory" = "$output_directory" ] ||  "$output_directory" = "$move_directory" ] || [ "$output_directory" = "./" ]) ; then
  error_description="ERRER: Extensions same"
  tput setaf 1
  tput setab 7
  echo ""
  echo -e "ERROR: Output extension is the same as the input extension and the output directory is "
  echo -e "the same as the transcode directory or the move (move files to) directory. This would "
  echo -e "result in ovewriting the files to transcode."
  echo ""
  echo "You must change these options so they are not the same!"
  echo ""
  echo "For full usage use the -h or --help switch."
  echo ""
  tput sgr0
  # NEED TO CLOSE OUT LOG FILE CORRECTLY HERE
  error_exit "${error_description}"
  # exit 1
fi

# If Quiet mode is not set - display settings and continue prompt:
if [[ $quiet != "TRUE" ]] ; then
  tput setaf 1
  tput setab 7
  echo -e "$the_app_name SETTINGS SUMMARY"
  echo -e "------------------------------"
  echo ""
  echo -e "ROOT DIRECTORY: \"$transcode_directory\"\n"
  if [ "$output_directory" != "./" ] ; then
    echo -e "OUTPUT DIRECTORY: \"$output_directory\"\n"
    if [ "$make_directory_structure" == "TRUE" ] ; then
  		echo -e "SELECTED: RECREATE INPUT DIRECTORY STRUCTURE\n"
  	elif [ $output_directory_set == "set" ] ; then
  		echo -e "SELECTED: SAVE ALL FILES TO THE ROOT OF THE OUTPUT DIRECTORY\n"
  	fi
  else
    echo -e "OUTPUT DIRECTORY: <same as source>\n"
  fi
  if [[ "$move_directory_set" == "set" ]]; then
    echo -e "MOVE (PROCESSED FILES) DIRECTORY: \"$move_directory\"\n"
  fi

  echo -e "INPUT FILE EXTENSION: \"$input_file_extension\"\n"

  echo -e "OUTPUT FILE EXTENSION: \"$output_file_extension\"\n"

	if [ "$add_subs" == "TRUE" ] ; then
		echo -e "SELECTED: SUBTITLE FILE EXTENSION: \"$subtitle_extension\"\n"
    if [[ "$continue" == "TRUE" ]]; then
      echo -e "SELECTED: CONTINUE IF SUBTITLE FILE IS MISSING\n"
    fi
	else
		echo -e "SELECTED: NO SUBTITLES\n"
	fi

	if [ "$HandBrakeCLI_transcoding_options_set" == "set" ] ; then
		echo -e "SELECTED: HandBrakeCLI Transcoding options: \"$HandBrakeCLI_transcoding_options\"\n"
	fi

	echo -e "Up-convert to 1080: $up_convert\n"

  if [[ ! "$HandBrake_json_to_use_set" == "set" ]]; then
    echo -e "TRANSCODER PRESET: \"$preset_to_use\"\n"
  else
    echo -e "HandBrake .json setting file: \"$HandBrake_json_to_use\"\n"
  fi

  if [[ "$make_log_file" == "TRUE" ]] ; then
    echo -e "LOG FILE: \"$log_file\"\n"
  fi

  # WARNING - IF output directory not "./" and not -r --> overwritting transcoded files
  # may occur if they have the same file name.
  if [ "$output_directory" != "./" ] && [ "$make_directory_structure" != "TRUE" ] ; then
    echo ""
    echo -e "WARNING: Output to a single directory without -r option will cause "
    echo -e "files to be overwritten if they have the same filename."
    echo ""
    echo "You should change these options so this can not occur!"
    echo ""
    echo "For full usage use the -h or --help switch."
    echo ""
  fi

echo "HIT ENTER TO START (or <ctl>+c to cancel)"
  tput sgr0
	read do_it
  echo ""
fi

# MUST RENAME ANY FILES THAT CONTAIN <,> (comma) TEMPORARILY - IF ADDING SUBTITLES
#
# NEW -

if [ "$add_subs" == "TRUE" ] ; then
	# If NOT Quiet mode - then tell about renaming files:
	if [[ $quiet != "TRUE" ]] ; then
    tput setaf 1
    tput setab 7
    echo -e "TEMPORARILY Renaming any files or directories that contain commas (<,>)..."
    tput sgr0
	fi
    # SHOULD - ONLY FIND FILES WITH COMMAS...
    find "$transcode_directory"/* -type f \( -name '*.srt' -o -name "*$input_file_extension" \) -print0 |
      while IFS= read -r -d '' file_name; do
        # save starting directory
  			orig_dir=$(pwd)
  			filepathnodot="${file_name#.}"

  			justfilenamenopath="${file_name##*/}"
        # NEW FILENAME - REPLACE COMMAS WITH \,
        new_filename_no_path="${justfilenamenopath//,/\\,}"

  		  justpathnofile="${file_name%/*}"

  			cd "$justpathnofile"
        # USE mv TO RENAME FILE - NO RENAME COMMAND USED
        mv "$justfilenamenopath" "$new_filename_no_path" > /dev/null 2>&1 # -v
  	    # CD BACK TO ORIGINAL DIR
  	    cd "$orig_dir"
	    done
  find "$transcode_directory"/* \( -name '*,*' -o -name '*\\*' \) -type d  -print0 |
      while IFS= read -r -d '' dir_name; do
        orig_dir=$(pwd)
        dirpathnodot="${dir_name#.}"

        justdirnamenopath="${dir_name##*/}"
        # NEW DIRECTORY NAME - REPLACE COMMAS WITH \,
        new_dirname_no_path="${justdirnamenopath//,/\\,}"

        justpathnodir="${dir_name%/*}"
        cd "$justpathnodir"
        # USE mv TO RENAME DIRECTORY - NO RENAME COMMAND USED
        mv "$justdirnamenopath" "$new_dirname_no_path" > /dev/null 2>&1 # -v
        # CD BACK TO ORIGINAL DIR
        cd "$orig_dir"
      done
fi
# TRANSCODING FILE INFO INTO LOGFILE
if [[ "$make_log_file" == "TRUE" ]] ; then
  # LOG FILE BEING TRANSCODED - JSON FORMAT
  echo -e "  \"Encoded_Files_Details\" : [" >> "$output_log_file"
fi
# IF USING A .json FILE - ADD IT IN FRONT OF TRANSCODING OPTIONS AND SET PRESET TO ""
if [[ "$HandBrake_json_to_use_set" == "set" ]]; then
  HandBrake_json_preset_file_name="${HandBrake_json_to_use##*/}"
  HandBrake_json_preset_name="${HandBrake_json_preset_file_name%\.*}"
  HandBrakeCLI_transcoding_options="--preset-import-file \"$HandBrake_json_to_use\" -Z \"$HandBrake_json_preset_name\" $HandBrakeCLI_transcoding_options"
  preset_to_use=""
fi
# GET TOTAL NUMBER OF FILES TO PROCESS
files_count=$(bash -c "find '$transcode_directory'/* -type f -name '*$input_file_extension'" | wc -l | tr -s ' ')
number_of_files_to_encode=($files_count)
#
### TRANSCODING...
current_file_number=0
find "$transcode_directory"/* -type f -name "*$input_file_extension" |
	sort -V -k1 |
	cut -d$'\t' -f2 |
	tr '\n' '\0' |
    while IFS= read -r -d '' file_name; do
      # Increment current file number
      ((++current_file_number))
      long_f=$(echo "$file_name" | tr -s '/')
      long_f="${long_f//$/\\$}"  # escape any $ s to \$
      short_f="${file_name##*/}"
      out_f="${short_f%\.*}$output_file_extension"
      if [ "$output_directory" == "./" ] ; then
        out_f_l=$(echo "${file_name%\.*}$output_file_extension" | tr -s '/')
        out_f_l="${out_f_l//$/\\$}"  # escape any $ s to \$
      elif [ "$make_directory_structure" == "TRUE" ] ; then
        justpathnofile=${file_name%/*}
        #
        new_path_from_root="${justpathnofile#"$transcode_directory"}"
        directory_to_create=$(echo "$output_directory$new_path_from_root" | tr -s '/')
        directory_to_create="${directory_to_create//\\,/,}"  # remove any \, s
        directory_to_create="${directory_to_create//\\\\/\\}"  # remove any \\ s
        # MAKE NEW DIRECTORY
        mkdir -p "$directory_to_create" > /dev/null 2>&1
        # NEW
        out_f="${out_f//\\,/,}"  # remove any \, s
        out_f="${out_f//\\\\/\\}"  # remove any \\ s
        out_f_l=$(echo "$directory_to_create/$out_f" | tr -s '/')
        out_f_l="${out_f_l//$/\\$}"  # escape any $ s to \$
      else # Output to another out directory but do NOT create directory structure
        out_f="${out_f//\\,/,}"  # remove any \, s
        out_f="${out_f//\\\\/\\}"  # remove any \\ s
        out_f_l=$(echo "$output_directory$out_f" | tr -s '/')
        out_f_l="${out_f_l//$/\\$}"  # escape any $ s to \$
      fi
      if [[ "$add_subs" == "TRUE" ]]; then
        srt_f="${short_f%\.*}"$subtitle_extension
        srt_f_l=$(echo "${file_name%\.*}$subtitle_extension" | tr -s '/')
        # CHECK FOR SUBTITLE FILE EXISTANCE
        if [[ -f $srt_f_l ]]; then
          subtitle_file_found="TRUE"
        else
          subtitle_file_found="FALSE"
        fi
        srt_f_l="${srt_f_l//$/\\$}"  # escape any $ s to \$
      fi
      # TRANSCODING FILE INFO INTO LOGFILE
      if [[ "$make_log_file" == "TRUE" ]] ; then
        # LOG FILE BEING TRANSCODED - JSON FORMAT
        echo "    {" >> "$output_log_file"
        log_long_f="${long_f//\\,/,}"
        log_long_f="${log_long_f//\\\\/\\}"
        log_long_f="${log_long_f//\\\\/\\}"
        log_long_f="${log_long_f//\\$/$}"  # NEW FOR ESCAPED $ s (\$)
        log_long_f="${log_long_f//\\/\\\\}" # I DONT KNOW WHY THIS IS NOT NEEDED... the & puts what was found back in...
        echo "      \"long_f\" : \"${log_long_f}\"," >> "$output_log_file"
        log_out_f_l="${out_f_l//\\,/,}"
        log_out_f_l="${log_out_f_l//\\\\/\\}"
        log_out_f_l="${log_out_f_l//\\\\/\\}"
        log_out_f_l="${log_out_f_l//\\$/$}"  # NEW FOR ESCAPED $ s (\$)
        log_out_f_l="${log_out_f_l//\\/\\\\}"
        echo "      \"out_f_l\" : \"${log_out_f_l}\"," >> "$output_log_file"
        log_srt_f_l="${srt_f_l//\\,/,}"
        log_srt_f_l="${log_srt_f_l//\\\\/\\}"
        log_srt_f_l="${log_srt_f_l//\\\\/\\}"
        log_srt_f_l="${log_srt_f_l//\\$/$}"  # NEW FOR ESCAPED $ s (\$)
        log_srt_f_l="${log_srt_f_l//\\/\\\\}"
        echo "      \"srt_f_l\" : \"${log_srt_f_l}\"," >> "$output_log_file"
        echo "      \"subtitle_file_found\" : \"$subtitle_file_found\"," >> "$output_log_file"
        echo "      \"current_file_number\" : \"$current_file_number\"," >> "$output_log_file"
        printf "      \"number_of_files_to_encode\" : \"$number_of_files_to_encode\"" >> "$output_log_file"
      fi
      if [[ "$subtitle_file_found" == "FALSE" ]] && [[ "$continue" == "FALSE" ]]; then
        #MISSING SUBTITLE FILE AND continue IS SET TO STOP IF MISSING
        error_description="MISSING SUBTITLE FILE"
        echo ""
        tput setaf 1
  			tput setab 7
        echo -e "STOPPING THE ENCODING: Subtitle file is missing."
        echo -e "MISSING FILE: "
        echo -e "   $srt_f_l"
        echo -e ""
        tput sgr0
        printf \\n
        # CLOSING ENCODING SECTION OF LOGFILE
        if [[ "$make_log_file" == "TRUE" ]] ; then
          # CLOSE SECTION LOG FILE BEING TRANSCODED - JSON FORMAT
          echo -e "\n    }" >> "$output_log_file"
        fi
        error_exit "${error_description}"
        # exit 1
      elif [[ "$subtitle_file_found" == "FALSE" ]] && [[ "$continue" == "TRUE" ]]; then
         # SUBS NOT FOUND - SET TO SKIP ADDING - CONTINUE IS TRUE
        add_subs_skip="TRUE"
        # ADD COMMA AFTER subtitle_file_found IN LOGFILE
        if [[ "$make_log_file" == "TRUE" ]] ; then
          # CLOSE SECTION LOG FILE BEING TRANSCODED - JSON FORMAT
          printf ",\n" >> "$output_log_file"
        fi
      else
        # ADD COMMA AFTER subtitle_file_found IN LOGFILE
        if [[ "$make_log_file" == "TRUE" ]] ; then
          # CLOSE SECTION LOG FILE BEING TRANSCODED - JSON FORMAT
          printf ",\n" >> "$output_log_file"
        fi
      fi
  		# If NOT Quiet mode - then display what file is being encoded:
  		if [[ "$quiet" != "TRUE" ]] ; then
  			echo ""
        tput setaf 1
  			tput setab 7
        the_from_directory=$(echo "${file_name%/*}" | tr -s '/')
        the_from_directory=$(echo "${the_from_directory//\\,/,}" | tr -s '/')
        the_from_directory=$(echo "${the_from_directory//\\\\,/\\}" | tr -s '/')
        the_from_directory=$(echo "${the_from_directory//\/\//\/}" | tr -s '/')  # new for two / s
        if [[ "$the_from_directory" == "./" ]]; then
          the_from_directory="."
        fi
        echo -e "Encoding file number $current_file_number of $number_of_files_to_encode total files to encode:"
        echo ""
        echo "From directory: $the_from_directory/"
        echo ""
        the_short_f=$(echo "${short_f//\\,/,}" | tr -s '/')
        the_short_f=$(echo "${the_short_f//\\\\/\\}" | tr -s '/')
        the_out_f=$(echo "${out_f//\\,/,}" | tr -s '/')
        the_out_f=$(echo "${the_out_f//\\\\/\\}" | tr -s '/')
        the_srt_f=$(echo "${srt_f//\\,/,}" | tr -s '/')
        the_srt_f=$(echo "${the_srt_f//\\\\/\\}" | tr -s '/')
  			if [[ "$add_subs" == "TRUE" ]] && [[ "$subtitle_file_found" == "TRUE" ]] ; then
  				echo "ENCODING FILE - \"$the_short_f\" - TO \"$the_out_f\" - WITH SUBTITLE FILE \"$the_srt_f\""
        elif [[ "$add_subs" == "TRUE" ]] && [[ "$subtitle_file_found" == "FALSE" ]] && [[ "$continue" == "TRUE" ]] ; then
          echo "ENCODING FILE - \"$the_short_f\" - TO \"$the_out_f\" - WITHOUT MISSING SUBTITLE FILE \"$the_srt_f\""
  			else
  				echo "ENCODING FILE - \"$the_short_f\" - TO \"$the_out_f\""
  			fi
        echo ""
        if [ "$output_directory" == "./" ] ; then
          the_out_directory=$(echo "${file_name%/*}" | tr -s '/')
          the_out_directory=$(echo "${the_out_directory//\\,/,}" | tr -s '/')
          the_out_directory=$(echo "${the_out_directory//\\\\/\\}" | tr -s '/')
          the_out_directory=$(echo "${the_out_directory//\\\\/\\}" | tr -s '/')
          the_out_directory=$(echo "${the_out_directory//\/\//\/}" | tr -s '/') # new for two / s
          if [[ "$the_out_directory" == "./" ]]; then
            the_out_directory="."
          fi
          echo "To Output directory: $the_out_directory/"
        else
          the_out_directory=$(echo "${out_f_l%/*}" | tr -s '/')
          the_out_directory=$(echo "${the_out_directory//\\,/,}" | tr -s '/')
          the_out_directory=$(echo "${the_out_directory//\\\\/\\}" | tr -s '/')
          the_out_directory=$(echo "${the_out_directory//\\\\/\\}" | tr -s '/')
          echo "To Output directory: $the_out_directory/"
        fi
  			tput sgr0
  			printf \\n

        # IF SET TO SKIP (BECAUSE CONTINUE IS TRUE AND ...) THEN TEMP SET add_subs TO FALSE
        if [[ "$add_subs_skip" == "TRUE" ]]; then
          add_subs="FALSE"
        fi

        # set the preset or Not
        if [[ "$preset_to_use" != "" ]]; then
          the_preset="--preset \"$preset_to_use\" "
          log_the_preset="--preset '$preset_to_use' "
        else
          the_preset=""
        fi

  			if [ "$add_subs" == "TRUE" ] && [ "$up_convert" == "TRUE" ] ; then
          # IF SAVING LOG FILE
          if [[ "$make_log_file" == "TRUE" ]] ; then
            # Save ENCODE COMMAND to log file - JSON FORMAT
            the_encode_command="$HandBreakCLIProg $log_the_preset--input '${log_long_f}' --output '${log_out_f_l}' ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file '${log_srt_f_l}' ${HandBrakeCLI_srt_language} </dev/null"
            log_the_encode_command="${the_encode_command//\\\\\\\\/\\\\}" # 4 \s to 2 \s BACKSLASHES
            log_the_encode_command="${the_encode_command//\\\\/\\}" # MAKE ANY TWO BACKSLASHES INTO JUST ONE
            log_the_encode_command="${the_encode_command//\\\\/\\}" # MAKE ANY TWO BACKSLASHES INTO JUST ONE
            log_the_encode_command="${the_encode_command//\\/\\\\}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\,/\\\\,}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\$/$}" # REPLACE $ WITH SINGLE
            log_the_encode_command="${the_encode_command//\"/\'}" # REPLACE DOUBLE QUOTES WITH SINGLE
            echo "      \"encode2m4v_encode_command\" : \"${log_the_encode_command}\"" >> "$output_log_file"
            printf "    }" >> "$output_log_file"
          fi
          if [[ "$details" == "TRUE" ]]; then
            # TRANSCODE
            bash -c "$HandBreakCLIProg $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file \"${srt_f_l}\" ${HandBrakeCLI_srt_language} </dev/null"
          else # NO DETAILS (DEFAULT)
            echo -e "\nENCODING VIDEO FILE: $log_long_f"
            bash -c "$HandBreakCLIProg $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file \"${srt_f_l}\" ${HandBrakeCLI_srt_language} </dev/null > /dev/null 2>&1"
          fi

  			elif [ "$add_subs" == "TRUE" ] && [ "$up_convert" == "FALSE" ] ; then  # NO - UP-CONVERT
          # IF SAVING LOG FILE
          if [[ "$make_log_file" == "TRUE" ]] ; then
            # Save ENCODE COMMAND to log file - JSON FORMAT
            the_encode_command="$HandBreakCLIProg $log_the_preset--input '${log_long_f}' --output '${log_out_f_l}' ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file '${log_srt_f_l}' ${HandBrakeCLI_srt_language} </dev/null"
            log_the_encode_command="${the_encode_command//\\\\\\\\/\\\\}" # 4 \s to 2 \s BACKSLASHES
            log_the_encode_command="${the_encode_command//\\\\/\\}" # MAKE ANY TWO BACKSLASHES INTO JUST ONE
            log_the_encode_command="${the_encode_command//\\\\/\\}" # MAKE ANY TWO BACKSLASHES INTO JUST ONE
            log_the_encode_command="${the_encode_command//\\/\\\\}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\,/\\\\,}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\$/$}" # REPLACE \$ WITH SINGLE $
            log_the_encode_command="${the_encode_command//\"/\'}" # REPLACE DOUBLE QUOTES WITH SINGLE
            echo "      \"encode2m4v_encode_command\" : \"${log_the_encode_command}\"" >> "$output_log_file"
            printf "    }" >> "$output_log_file"
          fi
          if [[ "$details" == "TRUE" ]]; then
            # TRANSCODE
            bash -c "$HandBreakCLIProg $the_preset--input \"$long_f\" --output \"$out_f_l\" ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file \"$srt_f_l\" ${HandBrakeCLI_srt_language} </dev/null"
          else # NO DETAILS
            echo -e "\nENCODING VIDEO FILE: $log_long_f"
            bash -c "$HandBreakCLIProg $the_preset--input \"$long_f\" --output \"$out_f_l\" ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file \"$srt_f_l\" ${HandBrakeCLI_srt_language} </dev/null > /dev/null 2>&1"
          fi
  			elif [ "$add_subs" == "FALSE" ] && [ "$up_convert" == "TRUE" ] ; then  # NO - SUBS BUT YES UP-CONVERT
          # IF SAVING LOG FILE
          if [[ "$make_log_file" == "TRUE" ]] ; then
            # Save ENCODE COMMAND to log file - JSON FORMAT
            the_encode_command="$HandBreakCLIProg $log_the_preset--input '${log_long_f}' --output '${log_out_f_l}' ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option}  </dev/null"
            log_the_encode_command="${the_encode_command//\\,/\\\\,}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\$/$}" # REPLACE \$ WITH SINGLE $
            log_the_encode_command="${the_encode_command//\"/\'}" # REPLACE DOUBLE QUOTES WITH SINGLE
            echo "      \"encode2m4v_encode_command\" : \"${log_the_encode_command}\"" >> "$output_log_file"
            printf "    }" >> "$output_log_file"
          fi
          if [[ "$details" == "TRUE" ]]; then
            # TRANSCODE
            bash -c "$HandBreakCLIProg $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option}  </dev/null"
          else # NO DETAILS
            echo -e "\nENCODING VIDEO FILE: $log_long_f"
            bash -c "$HandBreakCLIProg $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option}  </dev/null > /dev/null 2>&1"
          fi

  			else  # NO SUBS & NO UP-CONVERT
          # IF SAVING LOG FILE
          if [[ "$make_log_file" == "TRUE" ]] ; then
            # Save ENCODE COMMAND to log file - JSON FORMAT
            the_encode_command="$HandBreakCLIProg $log_the_preset--input '${log_long_f}' --output '${log_out_f_l}' ${HandBrakeCLI_transcoding_options} </dev/null"
            log_the_encode_command="${the_encode_command//\\,/\\\\,}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\$/$}" # REPLACE \$ WITH SINGLE $
            log_the_encode_command="${the_encode_command//\"/\'}" # REPLACE DOUBLE QUOTES WITH SINGLE
            echo "      \"encode2m4v_encode_command\" : \"${log_the_encode_command}\"" >> "$output_log_file"
            printf "    }" >> "$output_log_file"
          fi
          if [[ "$details" == "TRUE" ]]; then
            # TRANSCODE
            bash -c "$HandBreakCLIProg $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} </dev/null"
          else  # NO DETAILS
            echo -e "\nENCODING VIDEO FILE: $log_long_f"
            bash -c "$HandBreakCLIProg $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} </dev/null > /dev/null 2>&1"
          fi

  			fi
  		else # Quiet
        # IF SET TO SKIP (BECAUSE CONTINUE IS TRUE AND ...) THEN TEMP SET add_subs TO FALSE
        if [[ "$add_subs_skip" == "TRUE" ]]; then
          add_subs="FALSE"
        fi

  			# encoding, but output to dev null... D
  			if [ "$add_subs" == "TRUE" ] && [ "$up_convert" == "TRUE" ] ; then
          # IF SAVING LOG FILE
          if [[ "$make_log_file" == "TRUE" ]] ; then
            # Save ENCODE COMMAND to log file - JSON FORMAT
            the_encode_command="$HandBreakCLIProg  --verbose=1 $log_the_preset--input '${log_long_f}' --output '${log_out_f_l}' ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file '${log_srt_f_l}' ${HandBrakeCLI_srt_language} </dev/null > /dev/null 2>&1"
            log_the_encode_command="${the_encode_command//\\\\\\\\/\\\\}" # 4 \s to 2 \s BACKSLASHES
            log_the_encode_command="${the_encode_command//\\\\/\\}" # MAKE ANY TWO BACKSLASHES INTO JUST ONE
            log_the_encode_command="${the_encode_command//\\\\/\\}" # MAKE ANY TWO BACKSLASHES INTO JUST ONE
            log_the_encode_command="${the_encode_command//\\/\\\\}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\,/\\\\,}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\$/$}" # REPLACE \$ WITH SINGLE $
            log_the_encode_command="${the_encode_command//\"/\'}" # REPLACE DOUBLE QUOTES WITH SINGLE
            echo "      \"encode2m4v_encode_command\" : \"${log_the_encode_command}\"" >> "$output_log_file"
            printf "    }" >> "$output_log_file"
          fi
          # TRANSCODE
          bash -c "$HandBreakCLIProg  --verbose=1 $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file \"${srt_f_l}\" ${HandBrakeCLI_srt_language} </dev/null > /dev/null 2>&1"

  			elif [ "$add_subs" == "TRUE" ] && [ "$up_convert" == "FALSE" ] ; then  # NO - UP-CONVERT
          # IF SAVING LOG FILE
          if [[ "$make_log_file" == "TRUE" ]] ; then
            # Save ENCODE COMMAND to log file - JSON FORMAT
            the_encode_command="$HandBreakCLIProg  --verbose=1 $log_the_preset--input '${log_long_f}' --output '${log_out_f_l}' ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file '${log_srt_f_l}' ${HandBrakeCLI_srt_language} </dev/null > /dev/null 2>&1"
            log_the_encode_command="${the_encode_command//\\\\\\\\/\\\\}" # 4 \s to 2 \s BACKSLASHES
            log_the_encode_command="${the_encode_command//\\\\/\\}" # MAKE ANY TWO BACKSLASHES INTO JUST ONE
            log_the_encode_command="${the_encode_command//\\\\/\\}" # MAKE ANY TWO BACKSLASHES INTO JUST ONE
            log_the_encode_command="${the_encode_command//\\/\\\\}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\,/\\\\,}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\$/$}" # REPLACE \$ WITH SINGLE $
            log_the_encode_command="${the_encode_command//\"/\'}" # REPLACE DOUBLE QUOTES WITH SINGLE
            echo "      \"encode2m4v_encode_command\" : \"${log_the_encode_command}\"" >> "$output_log_file"
            printf "    }" >> "$output_log_file"
          fi
          # TRANSCODE
          bash -c "$HandBreakCLIProg  --verbose=1 $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_transcoding_options_for_adding_subtitles} --srt-file \"${srt_f_l}\" ${HandBrakeCLI_srt_language} </dev/null > /dev/null 2>&1"

  			elif [ "$add_subs" == "FALSE" ] && [ "$up_convert" == "TRUE" ] ; then  # NO - SUBS BUT YES UP-CONVERT
          # IF SAVING LOG FILE
          if [[ "$make_log_file" == "TRUE" ]] ; then
            # Save ENCODE COMMAND to log file - JSON FORMAT
            the_encode_command="$HandBreakCLIProg  --verbose=1 $log_the_preset--input '${log_long_f}' --output '${log_out_f_l}' ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option} </dev/null > /dev/null 2>&1"
            log_the_encode_command="${the_encode_command//\\,/\\\\,}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\$/$}" # REPLACE \$ WITH SINGLE $
            log_the_encode_command="${the_encode_command//\"/\'}" # REPLACE DOUBLE QUOTES WITH SINGLE
            echo "      \"encode2m4v_encode_command\" : \"${log_the_encode_command}\"" >> "$output_log_file"
            printf "    }" >> "$output_log_file"
          fi
          # TRANSCODE
          bash -c "$HandBreakCLIProg  --verbose=1 $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} ${HandBrakeCLI_upconvert_option} </dev/null > /dev/null 2>&1"

  			else  # NO SUBS & NO UP-CONVERT
          # IF SAVING LOG FILE
          if [[ "$make_log_file" == "TRUE" ]] ; then
            # Save ENCODE COMMAND to log file - JSON FORMAT
            the_encode_command="$HandBreakCLIProg  --verbose=1 $log_the_preset--input '${log_long_f}' --output '${log_out_f_l}' ${HandBrakeCLI_transcoding_options} </dev/null > /dev/null 2>&1"
            log_the_encode_command="${the_encode_command//\\,/\\\\,}" # ESCAPE ANY BACKSLASHES
            log_the_encode_command="${the_encode_command//\\$/$}" # REPLACE \$ WITH SINGLE $
            log_the_encode_command="${the_encode_command//\"/\'}" # REPLACE DOUBLE QUOTES WITH SINGLE
            echo "      \"encode2m4v_encode_command\" : \"${log_the_encode_command}\"" >> "$output_log_file"
            printf "    }" >> "$output_log_file"
          fi
          #TRANSCODE
          bash -c "$HandBreakCLIProg  --verbose=1 $the_preset--input \"${long_f}\" --output \"${out_f_l}\" ${HandBrakeCLI_transcoding_options} </dev/null > /dev/null 2>&1"

  			fi
  		fi
      # LOG FILE - IF NOT LAST FILE PROCESSED THEN PUT COMMA - ELSE PUT NEWLINE
      #
      #  $current_file_number of $number_of_files_to_encode
      #
      if [[ "$make_log_file" == "TRUE" ]] ; then
        if [[ $current_file_number -lt $number_of_files_to_encode ]]; then
          printf ",\n" >> "$output_log_file"
        else
          printf "\n" >> "$output_log_file"
        fi
      fi

      if [[ "$add_subs_skip" == "TRUE" ]]; then # RESET TO TEST FOR NEXT SUBTITLE FILE
        add_subs="TRUE"
        add_subs_skip="FALSE"
      fi
      # MOVE INPUT FILES IF move_DIRECTORY IS SET
      if [[ "$move_directory_set" == "set" ]]; then
        if [ "$make_directory_structure" == "TRUE" ] ; then
          justpathnofile=${long_f%/*}
          new_path_from_root="${justpathnofile#"$transcode_directory"}"
          full_move_directory=$(echo "$move_directory$new_path_from_root" | tr -s '/')
          full_move_directory="${full_move_directory//\\,/,}"  # remove any \, s
          full_move_directory="${full_move_directory//\\$/$}"  # remove any \$ s
          full_move_directory="${full_move_directory//\\\\/\\}"  # remove any \\ s
          mkdir -p "$full_move_directory" > /dev/null 2>&1
          short_f="${short_f//\\,/,}"  # remove any \, s
          short_f="${short_f//\\$/$}"  # remove any \$ s
          short_f="${short_f//\\\\/\\}"  # remove any \\ s
          move_to_filename="$full_move_directory/$short_f"
          if [[ "$quiet" != "TRUE" ]] ; then
            echo -e "\nMOVING PROCESSED VIDEO FILE: $log_long_f"
          fi
          long_f="${long_f//\\$/$}"  # remove any \$ s
          mv "$long_f" "$move_to_filename"
          if [ "$add_subs" == "TRUE" ] && [ "$subtitle_file_found" == "TRUE" ] ; then
            move_srt_short_f="${srt_f_l##*/}"
            move_srt_short_f="${move_srt_short_f//\\,/,}"  # remove any \, s
            move_srt_short_f="${move_srt_short_f//\\$/$}"  # remove any \$ s
            move_srt_short_f="${move_srt_short_f//\\\\/\\}"  # remove any \\ s
            move_srt_to_filename="$full_move_directory/$move_srt_short_f"
            if [[ "$quiet" != "TRUE" ]] ; then
              echo -e "\nMOVING INCLUDED SUBTITLE FILE: $log_srt_f_l"
            fi
            srt_f_l="${srt_f_l//\\$/$}"  # remove any \$ s
            mv "$srt_f_l" "$move_srt_to_filename"
          fi
        else # MOVE to another move directory but do NOT create directory structure
          mkdir -p "$move_directory" > /dev/null 2>&1
          short_f="${short_f//\\,/,}"  # remove any \, s
          short_f="${short_f//\\$/$}"  # remove any \$ s
          short_f="${short_f//\\\\/\\}"  # remove any \\ s
          move_to_filename="$move_directory$short_f"
          if [[ "$quiet" != "TRUE" ]] ; then
            echo -e "\nMOVING PROCESSED VIDEO FILE: $log_long_f"
          fi
          long_f="${long_f//\\$/$}"  # remove any \$ s
          mv "$long_f" "$move_to_filename"
          if [ "$add_subs" == "TRUE" ] && [ "$subtitle_file_found" == "TRUE" ] ; then
            move_srt_short_f="${srt_f_l##*/}"
            move_srt_short_f="${move_srt_short_f//\\,/,}"  # remove any \, s
            move_srt_short_f="${move_srt_short_f//\\$/$}"  # remove any \$ sv
            move_srt_short_f="${move_srt_short_f//\\\\/\\}"  # remove any \\ s
            move_srt_to_filename="$move_directory$move_srt_short_f"
            if [[ "$quiet" != "TRUE" ]] ; then
              echo -e "\nMOVING INCLUDED SUBTITLE FILE: $log_srt_f_l"
            fi
            srt_f_l="${srt_f_l//\\$/$}"  # remove any \$ s
            mv "$srt_f_l" "$move_srt_to_filename"
          fi
        fi
      fi
    done

# Rename Folders BACK - ANY FILES THAT CONTAIN <\,> (backslash comma)
#
if [[ "$add_subs" == "TRUE" ]] ; then
	# If NOT Quiet mode - then tell about renaming files back...
	if [[ $quiet != "TRUE" ]] ; then
    tput setaf 1
    tput setab 7
		echo -e "\nRenaming any files or directories that contained commas (now \,) back..."
    tput sgr0
	fi
# Rename folders BACK if commas - WORKS MAC OS & LINUX
#
find "$transcode_directory"/* \( -name '*\\,*' -o -name '*\\\\' \) -type d  -print0 |
    while IFS= read -r -d '' dir_name; do
      # SAVE CURRENT DIRECTORY
      orig_dir=$(pwd)
      dirpathnodot="${dir_name#.}"

      justdirnamenopath="${dir_name##*/}"
      # NEW DIRECTORY NAME - REPLACE BACKSLASH COMMAS (\,) WITH COMMAS (,)
      new_dirname_no_path="${justdirnamenopath//\\,/,}"
      justdirnamenopath="${justdirnamenopath}"

      justpathnodir=${dir_name%/*}
      cd "$justpathnodir"
      # use mv to rename directory - NO RENAME COMMAND USED
      mv "$justdirnamenopath" "$new_dirname_no_path" > /dev/null 2>&1 # -v
      # CD BACK TO ORIGINAL DIR
      cd "$orig_dir"
    done
    # DONE "RE-RENAMED FOLDERS"

  # Rename files BACK
  find "$transcode_directory"/* -name '*\\,*' -type f \
  -exec bash -c 't="${0//\\,/,}"; mv "$0" "$t" > /dev/null 2>&1' {} \; # -v
  find "$transcode_directory"/* -name '*\\\\*' -type f \
  -exec bash -c 't="${0//\\\\/\\}"; mv "$0" "$t" > /dev/null 2>&1' {} \; # -v
  # DONE "RE-RENAMED FILES"
fi

# END LOGGING TO LOGFILE
if [[ "$make_log_file" == "TRUE" ]] ; then
  # FINAL END - JSON FORMAT
  echo -e "  ]" >> "$output_log_file"
  echo -e "}" >> "$output_log_file"
fi


##############
#  ALL DONE  #
##############
# If NOT Quiet mode - then tell DONE
if [[ $quiet != "TRUE" ]] ; then
	tput setaf 1; tput setab 7; echo -e "\nEncoding complete... Have a nice day!\n"; tput sgr0; echo ""; clean_up 0
else
	clean_up 0
fi
