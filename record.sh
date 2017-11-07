#!/usr/bin/env bash

#start mpv stream and get pid

mpv --volume=0 http://193.105.67.24:8006 > cache 2>/dev/null &

arg="$1"
pid="$!"

ps -p "$pid" > /dev/null

pid_exist="$?"
echo ""
echo "active MPV instance with pid number $pid"
echo "Searching for song: $arg"
echo "In progress..."


while [[ $pid_exist -eq 0 ]]

do

cat cache | grep -a "$arg" > /dev/null

grep_return="$?"

if [ "$grep_return" = "0" ]
then
	echo "Song found! Recording to file $arg.mp3"
	 ffmpeg -y -i http://193.105.67.24:8006 -t 00:10:00 $arg.mp3 > /dev/null 2>&1
 	 exit 1	 
 fi
sleep 1

done
exit 1
