# This script use jq to get a random shloka from gitasitis.json file and print its shloka,translation,(purport..)
# set the path of gitasitis.json file accordingly in RAN and TEXT variable
#!/bin/bash
RAN=`jq '.[0] | .[] | .[] | .TEXT' gitasitis.json | shuf | head -n 1`  # Pick a random TEXT
TEXT=`jq '.[0] | .[] | .[]' gitasitis.json | jq "select(.TEXT==$RAN)"` # Read a random TEXT from jsonfile

SHLOKA=`echo $TEXT | jq '.SHLOKA'`
TRANSLATION=`echo $TEXT | jq '.TRANSLATION'`

#uncomment below line to use purport too
#PURPORT=`echo $TEXT | jq '.PURPORT'`'

echo $(tput setaf 3)$SHLOKA | tr -d \"
echo $(tput setaf 2)$TRANSLATION | tr -d \"
#uncomment below line to echo purport too
#echo $(tput setaf 4)$PURPORT | tr -d \"
