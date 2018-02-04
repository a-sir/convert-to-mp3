# convert_to_mp3.sh
Converts media files in directory or single file to mp3 format.
Script uses MIN(number_of_files, (number_of_cores - 1)) threads for conversion, each file is converted by a single thread.

## Requires:
1. vlc (for convertion) and
2. parallel (to use multiple cores).

## 1. Single file conversion:
./convert_to_mp3.sh <file to be converted> <output bitrate kbps>

For example: ./convert_to_mp3.sh ~/Downloads/podcast.m4b 128
will convert the requested file to 128kbps mp3 format and put resulting file into same directory.

## 2. Batch conversion:
./convert_to_mp3.sh <path to directory> <extention to be converted>

For example: ./convert_to_mp3.sh ~/my\ audiobook m4b 256
will convert all *.m4b files inside "~/my audiobook" director to 256kbps mp3 format and put resulting files into same directory.
