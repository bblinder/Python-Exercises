#!/bin/bash

##########
# FLV converter
# Converts single files or entire directory of FLV files to MP4s with H.264 video and AAC audio.
# Assumes you have a build of FFmpeg -- static, git, etc -- living in your $PATH (it looks for `/usr/local# /bin` or `/usr/bin` by default).
##########

current_directory=$(pwd)

single_convert(){
	echo "Drag and Drop file HERE : "
	
	while read I; do
		ffmpeg -i "${I}" -c:v libx264 -c:a libvo_aacenc -crf 20 -r 30 \
			"${I/%.*/.mp4}" > /dev/null & 2>/dev/null
	done
	exit 0
}

# Using FLVs in this case (I have a lot of old videos...)

batch_convert(){
	for fname in *.flv; do
		ffmpeg -i "$fname" -c:v libx264 -c:a libvo_aacenc -crf 20 -r 30 "${fname%.*}.mp4"
	done
}

ffmpeg_check(){
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

		read response
		if [[ $response == "y" ]] ; then
			ffmpeg_check
			batch_convert
		
		elif [[ $response == "n" ]] ; then
			exit 0
		fi
	fi
}

echo "*******************"
echo "Video Codec : libx264"
echo "Audio Codec : libvo_aacenc"
echo "*******************"
echo "Type (1) to convert a single file."
echo "Type (2) to convert a batch."

read input

case "$input" in
	1)
		ffmpeg_check
		single_convert
		;;
	2)
		echo "Please drag (or fill in the file path of) the folder here, and press ENTER."
		read file_path 
		cp $current_directory/Converter $file_path
		cd $file_path 
		ffmpeg_check
		check_MP4
		batch_convert
		rm $file_path/Converter
		;;
	*)
		echo "Please type (1) or (2)"
		exit 1
		;;
esac

