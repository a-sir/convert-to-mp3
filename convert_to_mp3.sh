#!/bin/bash

# script to convert media files in directory or single file to mp3 format.
# See README.md
# alexander.sirenko@gmail.com

check_result() {
    if [ "${1}" -eq 0 ]; then
	echo "Done."
    else
	echo "FAILED."
	exit 1
    fi
}

export -f check_result

convert_file() {
    local OUTPUT_KBPS="${1}"
    shift

    local file="${@}"
    local dst=$(echo "$file" | sed 's/\.[^\.]*$/.mp3/')
    echo "convert ${file} to ${dst} bitrate ${OUTPUT_KBPS}"

    vlc -I dummy "${file}" --sout="#transcode{acodec=mp3,vcodec=dummy,ab=${OUTPUT_KBPS}}:standard{access=file,mux=raw,dst=\"${dst}\"}" vlc://quit
    check_result $?

    ls -lht "${file}" "${dst}"
}

export -f convert_file

if [ $# -eq 2 ]; then
    convert_file "${2}" "${1}"
    check_result $?
elif [ $# -eq 3 ]; then

    dir="${1}"
    ext="${2}"
    kbps="${3}"

    count=$(($(grep -c ^processor /proc/cpuinfo) - 1))
    echo "Use ${count} threads."

    find "${dir}" -type f \( -name "*.${ext}" \) | awk -v kbps="${kbps}" '{print "convert_file "kbps" "$0}' | parallel -j "${count}"
else
    echo "Use as: ./convert_to_mp3.sh <path to directory> <extention to be converted> <output bitrate kbps>"
    exit 1
fi
