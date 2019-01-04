#!/bin/bash

javaPath=".\app\src\main\java"
targetPath=".\app\target\classes"

# Parsing des options
while getopts f: option
do
case "${option}"
in
f) folderPath=${OPTARG};;
esac
done

javaFolderPath="$javaPath\\$folderPath"
targetFolderPath="$targetPath\\$folderPath"

find "$javaFolderPath" -mindepth 1 -maxdepth 1 -name "*.java" -printf "%f\n" | while read file; do
	fileName=${file::-5}
	echo "On analyse le final folder $javaFolderPath, classe $fileName"
	./analyse_classe.sh -n "$fileName" -t "$targetFolderPath\\$fileName.class" -j "$javaFolderPath\\$fileName.java"
	echo "Fin de l'analyse du final folder $javaFolderPath, classe $fileName"
done
