# encode2m4v

#### NAME
      encode2m4v  - Transcodes video files using HandBrakeCLI

#### VERSION
      Version 0.9.7

#### SUMMARY
  Encodes .mp4 files to .m4v files recursing directories to find all .mp4 files
  with the ability to include subtitles into the encoded file and/or upconvert
  the output to 1080. Other options are possible using command line arguments.

#### FEATURES
  
  If run without switches: 
 
  - searches in current directory and subdirectories for all video files with a .mp4 extension.
 - will prompt for a subtitle extension to add or no subtitle.
 - will prompt whether or not to upconvert to 1080.
 - will start transcoding all found video files to .m4v files using the HandBrakeCLI "HQ 1080p30 Surround" preset.
 - will place these transcoded files in the same directory as the source (input) video file.
 - will not move or remove any files.
 - will not display the HandBrakeCLI encoding details.

Command line switches - provide ability to:

  - specifiy a "transcode directory/" to start search for video files and subtitle files.

  - specify input video file extension to search for (.mp4, .mov, .mkv, ...) or all video files (".*")- (-i / --inext)

  - specify output transcoded video file extension (.mp4 , .m4v, .mkv ...) - (-e / --ext)

  - specify subtitle file extension (?.srt / "none") - (-s / --subtitle=)
  
  - specify whether to stop encoding (-b / --break) if a subtitle file is not found or continue (-c / --continue)

  - specify a HandBrake preset (-p / --preset=)

  - specify specific HandBrake transcoding options (-t / --transopt)

  - use a HandBrake .json settings file (-j / --json=)

  - upconvert the video to 1080 (-u / --upconvert) or not (-n / --noupconvert)
  
  - specify an upconvert level (720, 1080, 2160, 4320) (-x / --xlevel)

  - output the transcoded file(s) to a specified directory (-o / --output=)

  - re-create the input directory structure when output to a different directory (-r / --recreatedirs)

  - move input video and subtitle files once they have been transcoded (-m / --move=)
  
  - delete input file(s) after they have beed transcoded (-k / -kill)

  - show details of HandBrakeCLI encoding or not (-d / --details)

  - display a "manpage" like information (-g / --guide)
#### SYNOPSIS
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
           -x/--xlevel
           -c/--continue
           -b/--break
           -o/--output=
           -r/--recreatedirs
           -m/--move=
           -a/--all
           -k/--kill
           -l/--logfile=
           -d/--details
           -q/--quiet


#### HELP
      encode2m4v -h  or  --help


#### REQUIREMENTS
	handbrakeCLI.exe  - installed in same directory, /Applications/HandBrakeCLI (Mac OS) or in PATH, or as flatpak (Linux)

#### DETAILS
------------
##### DESCRIPTION  
             Transcodes files and recurses folders in current directory "." (or
             "root directory/".) Finds all .mp4 (or "--inext") files and transcodes
             them into an .m4v (or "--ext") file using the "HQ 1080p30 Surround"
             (or --preset) HandBrakeCLI preset. Originally meant to be copied to the
             directory to start the recursive search (root) and run from there, it
             also has command line switches (arguments) which can be passed in to set
             the "root" folder and other switches to set processing options.

##### PROMPTS  
             1) Prompts for the subtitle extension (??.srt) or "none" (0) to add
             2) Prompts whether or not to upconvert to resolution 1920 x 1080

##### DEFAULTS  
             Default HandBrakeCLI preset: HQ 1080p30 Surround

             Default  HandBrakeCLI Transcoding options:
                   --vfr --crop 0:0:0:0 --auto-anamorphic --keep-display-aspect
             Default HandBrakeCLI transcoding options for adding subtitles:
                   --subtitle-lang-list eng,spa --native-language eng

##### OPTIONS
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
                Transcoding options to use when calling HandBrakeCLI (Enclose in quotes "<options>")

            -u, --upconvert
                Upconvert all encoded files. Not necessary if using -x / --xlevel.

            -n, --noupconvert
                Do NOT upconvert all encoded vided files. Must be specified or prompts will occur.
                
            -x, --xlevel=
                Set upconvert level (720, 1080, 2160, 4320).

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
            
            -k, --kill
                Delete (kill) all source files once they have been re-encoded. Takes prescedence over -m / --move.

            -l, --logfile=
                Logfile filename to use to log information to a .json format log file. (Enclose in quotes "logfile.json")
                Saved in root of output directory.

            -d, --details
                Details of the HandBrakeCLI transcoding will be shown.

            -q, --quiet
                Work in quiet mode. Display no outputs or prompts unless necessary.

##### WARNINGS  
             If the output file exists (or is the same name as the input file
             and in the same directory) THE FILE WILL BE OVERWRITTEN (defaultj /
             THIS IS PARTICULARY DANGEROUS IF OUTPUTTING TO A FILE EXTENSION
             WHICH IS THE SAME AS THE INPUT EXTENSION. This is only possible
             if using command line options - SO BE CAREFUL!

##### SEE ALSO
###### encode2m4v Documentation: 
###### [https://docs.encode2m4v.sh](https://docs.encode2m4v.sh)

###### encode2m4v Wiki: 
###### [https://github.com/encode2m4v/encode2m4v/wiki](https://github.com/encode2m4v/encode2m4v/wiki)

##### BUGS INCLUDED
            ... (yes...)

##### AUTHOR
             Written by M T ... (encode2m4v  at  gmail.com)

##### REPORTING BUGS
###### See our issues on GitHub:
###### [https://github.com/encode2m4v/encode2m4v/issues](https://github.com/encode2m4v/encode2m4v/issues)

##### COPYRIGHT
             Copyright  ?? 2023 M T  License GPLv3+: GNU GPL version 3 or later.

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
