#!/bin/bash

##########
# FLV converter
# Converts single files or entire directory of FLV files to MP4s with H.264 video and AAC audio.
# Can alternatively convert to MP3 files.
# Assumes you have a build of FFmpeg -- static, git, etc -- living in your $PATH (it looks for `/usr/local# /bin` or `/usr/bin` by default).
##########

current_directory=$(pwd)

single_convert(){
	echo "Drag and Drop file HERE : "
	
	while read -r I; do
		ffmpeg -i "${I}" -c:v libx264 -c:a libfdk_aac -crf 20 -aspect 16:9 -r 30 \
			"${I/%.*/.mp4}" > /dev/null & 2>/dev/null
	done
	exit 0
}

# Using FLVs in this case (I have a lot of old flash videos...)

batch_convert(){
	for fname in *.flv; do
		ffmpeg -i "$fname" -c:v libx264 -c:a libfdk_aac -crf 20 -aspect 16:9 -r 30 "${fname%.*}.mp4"
	done
}

mp3_single(){
	while read -r I ; do
		ffmpeg -i "${I}" -c:a libmp3lame -b:a 320k "${I/%.*/.mp3}"
	done
}

mp3_batch(){
	for fname in *.flv ; do
		ffmpeg -i "$fname" -c:a libmp3lame -b:a 320k "${fname%.*}.mp3"
	done
}

check_ffmpeg(){
	if [[ ! ( -f /usr/bin/ffmpeg || -f /usr/local/bin/ffmpeg ) ]] ; then
		echo "FFmpeg not installed!"
		echo "Please install it at: https://ffmpeg.org/download.html"
		exit 1
	fi
}

check_MP4(){
	if [[ -e "${fname%.*}.mp4" ]] ; then
		echo "'${fname%.*}.mp4' already exists!"
		echo "Do you want to overwrite it? [y/n]"

		read -r response
		if [[ $response == "y" ]] ; then
			check_ffmpeg
			batch_convert
		
		elif [[ $response == "n" ]] ; then
			exit 0
		fi
	fi
}

echo "*******************"
echo "Video Codec : H.264 (libx264)"
echo "Audio Codec : AAC (libfdk_aac)"
echo "Audio Codec (for MP3s) : libmp3lame"
echo "*******************"
echo "Type (1) to convert a single file to MP4"
echo "Type (2) to convert a batch to MP4"
echo
echo "Type (3) to convert a single file to MP3"
echo "Type (4) to convert a batch to MP3"
read -r input

case "$input" in
	1)
		check_ffmpeg
		single_convert
		;;
	2)
		echo "Please drag (or fill in the file path of) the folder here, and press ENTER."
		read -r file_path 
		cp $current_directory/Transcoder.sh $file_path
		cd $file_path 
		check_ffmpeg
		check_MP4
		batch_convert
		rm $file_path/Transcoder.sh
		;;
	3)
		echo "Drag and Drop file HERE: "
		check_ffmpeg
		mp3_single
		;;
	4)
		echo "Please drag (or fill in the file path of) the folder here, and press ENTER."
		read -r file_path
		cp $current_directory/Transcoder.sh $file_path
		cd $file_path
		check_ffmpeg
		mp3_batch
		rm $file_path/Transcoder.sh
		;;

	*)
		echo "Please select options {1-4}"
		exit 1
		;;
esac

