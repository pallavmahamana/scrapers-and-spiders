# This script use jq to get a random shloka from gitasitis.json file and print its shloka,translation,(purport..)
# dependency(install): jq --> https://stedolan.github.io/jq
# set the path of gitasitis.json file accordingly in RAN and TEXT variable
# USAGE. quote - for random shloka
# USAGE, quote 0 {TEXT_NUM} - for exact TEXT , eg. quote 0 2.47
# USAGE, quote 1 - for random shloka and translation both
# USAGE, quote 2 - for random shloka, translation and purport
#!/bin/bash
#function gita(){                                           #<--- uncomment this and line(50)
RAN=`jq '.[0] | .[] | .[] | .TEXT' gitasitis.json | shuf | head -n 1`  # Pick a random TEXT
TEXT=`jq '.[0] | .[] | .[]' gitasitis.json | jq "select(.TEXT==$RAN)"` # Read a random TEXT from jsonfile

SHLOKA=`echo  $TEXT | jq -r '.SHLOKA'`


if [ $# -eq 0 ]
then
	echo $(tput setaf 6)BG $RAN | tr -d \"
	echo $(tput setaf 3)$SHLOKA
elif [ $1 -eq 0 ]
then
	TEXT=`jq '.[0] | .[] | .[]' gitasitis.json | jq "select(.TEXT==\"${2}\")"`
	SHLOKA=`echo  $TEXT | jq -r '.SHLOKA'`
	TRANSLATION=`echo $TEXT | jq -r '.TRANSLATION'`
	PURPORT=`echo $TEXT | jq -r '.PURPORT'`
	echo $(tput setaf 6)BG $2 | tr -d \"
	echo $(tput setaf 3)$SHLOKA
	echo
	echo $(tput setaf 2)$TRANSLATION
	echo
	echo $(tput setaf 172)$PURPORT
elif [ $1 -eq 1 ]
then
	TRANSLATION=`echo $TEXT | jq -r '.TRANSLATION'`
	echo $(tput setaf 6)BG $RAN | tr -d \"
	echo $(tput setaf 3)$SHLOKA
	echo
	echo $(tput setaf 2)$TRANSLATION
elif [ $1 -eq 2 ]
then
	TRANSLATION=`echo $TEXT | jq -r '.TRANSLATION'`
	PURPORT=`echo $TEXT | jq -r '.PURPORT'`
	echo $(tput setaf 6)BG $RAN | tr -d \"
	echo $(tput setaf 3)$SHLOKA
	echo
	echo $(tput setaf 2)$TRANSLATION
	echo
	echo $(tput setaf 172)$PURPORT
fi
#}             <-- uncomment this and line(9) to make a function and add it to .bashrc or .zshrc to make it alias
