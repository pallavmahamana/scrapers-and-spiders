# This script use jq to get a random shloka from gitasitis.json file and print its shloka,translation,(purport..)
# dependency(install): jq --> https://stedolan.github.io/jq
# set the path of gitasitis.json file accordingly in RAN and TEXT variable
# USAGE. quote - for random shloka
# USAGE, quote 1 - for random shloka and translation both
# USAGE, quote 2 - for random shloka, translation and purport
#!/bin/bash
#function quote(){                                           #<--- uncomment this and line(36)
RAN=`jq '.[0] | .[] | .[] | .TEXT' gitasitis.json | shuf | head -n 1`  # Pick a random TEXT
TEXT=`jq '.[0] | .[] | .[]' gitasitis.json | jq "select(.TEXT==$RAN)"` # Read a random TEXT from jsonfile

SHLOKA=`echo $TEXT | jq '.SHLOKA'`

if [ $# -eq 0 ]
then
	echo $(tput setaf 6)BG $RAN | tr -d \"
	echo $(tput setaf 3)$SHLOKA | tr -d \"
elif [ $1 -eq 1 ]
then
	TRANSLATION=`echo $TEXT | jq '.TRANSLATION'`
	echo $(tput setaf 6)BG $RAN | tr -d \"
	echo $(tput setaf 3)$SHLOKA | tr -d \"
	echo
	echo $(tput setaf 2)$TRANSLATION | tr -d \"
elif [ $1 -eq 2 ]
then
	TRANSLATION=`echo $TEXT | jq '.TRANSLATION'`
	PURPORT=`echo $TEXT | jq '.PURPORT'`
	echo $(tput setaf 6)BG $RAN | tr -d \"
	echo $(tput setaf 3)$SHLOKA | tr -d \"
	echo
	echo $(tput setaf 2)$TRANSLATION | tr -d \"
	echo
	echo $(tput setaf 172)$PURPORT | tr -d \"
fi
#}             <-- uncomment this and line(8) to make a function and add it to .bashrc or .zshrc to make it alias
