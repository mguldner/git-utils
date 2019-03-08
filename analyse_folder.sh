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

mkdir -p "Analyse"

find "$relativeFolderPath" -mindepth 1 -maxdepth 1 -type d -printf "%f\n" | while read folder; do
	subdirPath="$relativeFolderPath\\$folder"
	subdirCount=`find $subdirPath -maxdepth 1 -type d | wc -l`

	if [ $subdircount -eq 2 ]
	then
		echo "On analyse le final folder $folderPath\\$folder"
		./analyse_final_folder.sh -f "$folderPath\\$folder"
		echo "Fin de l'analyse du final folder $folderPath\\$folder"
	else
		echo "On analyse le folder $folderPath\\$folder"
		./analyse_folder.sh -f "$folderPath\\$folder"
		echo "Fin de l'analyse du folder $folderPath\\$folder"
	fi
	
done

echo "On analyse le contenu du final folder $folderPath"
./analyse_final_folder.sh -f "$folderPath"
echo "Fin de l'analyse du contenu du final folder $folderPath"