#!/bin/bash

javaPath=".\app\src\main\java"

# Parsing des options
while getopts f: option
do
case "${option}"
in
f) folderPath=${OPTARG};;
esac
done

relativeFolderPath="$javaPath\\$folderPath"

mkdir "Analyse"

find "$relativeFolderPath" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | while read folder; do
	echo "On analyse le folder $folderPath\\$folder"
	./analyse_final_folder.sh -f "$folderPath\\$folder"
	echo "Fin de l'analyse du folder $folderPath\\$folder"
done

echo "On analyse le contenu du folder $folderPath"
./analyse_final_folder.sh -f "$folderPath"
echo "Fin de l'analyse du contenu du folder $folderPath"
