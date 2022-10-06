#!/bin/bash

BASENAME=$( basename -- "$0" )
DIRNAME=$( dirname -- "$0" )

echo "------------------------"
echo " Dynamic OSX Wallpaper"
echo "------------------------"

# Find XML in folder
xmlfile=$(find . -type f -name "*.xml" -print -quit)
xmlfile=$(readlink -f "$xmlfile")
echo $xmlfile

# Check if xml found
[[ -z $xmlfile ]] && {
  # Not found
  printf "No XML file found..." >&2
}

# Replace with correct path in xml
newfile=""
REGEX='.*?<.*?>(\/.*?)<.*?'
while IFS= read -r line
do
  if [[ $line =~ $REGEX ]]; then
    name=$(basename "${BASH_REMATCH[1]}")
    realname=$(readlink -f "$name")
    newline="${line/"${BASH_REMATCH[1]}"/"${realname}"}"
    line="$newline"
  fi  
  # Add line to newfile
    newfile="$newfile
$line"

done < "$xmlfile"

# Save file
echo "$newfile" > $xmlfile

# Set background
gsettings set org.gnome.desktop.background picture-uri "file://$xmlfile"

echo "Background changed successfully"
