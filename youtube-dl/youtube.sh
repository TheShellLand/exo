#!/bin/bash


if [ "$1" == "" ]; then
	touch downloadList.txt
	while read url; do 
		youtube-dl "$url" -x --audio-format mp3 -i
		youtube-dl "$url" -i
		echo "$url" >> finishedList.txt
	done < downloadList.txt

else
	youtube-dl "$1" -x --audio-format mp3 -k -i
fi
