#!/bin/bash

# Valeur par défaut de la date
dateMin="2014-1-1"

# Parsing des options
while getopts n:j:t:d option
do
case "${option}"
in
n) nomFichier=${OPTARG};;
t) cheminClass=${OPTARG};;
j) cheminJava=${OPTARG};;
d) dateMin=${OPTARG};;
esac
done

nomDossierAnalyse="Analyse_classe_$nomFichier"

mkdir "Analyse\\$nomDossierAnalyse"

# Récupération des méthodes de la classe
javap $cheminClass > "Analyse\\$nomDossierAnalyse/listeMethodes_$nomFichier.log"

# Récupération des noms de ces méthodes uniquement
grep -o '[a-zA-Z0-9]*(' "Analyse\\$nomDossierAnalyse/listeMethodes_$nomFichier.log" | while read -r line ; do 
	line=${line::-1}
	echo "$line" >> "Analyse\\$nomDossierAnalyse/listeMethodesSeules_$nomFichier.log"
done 

mkdir "Analyse\\$nomDossierAnalyse/diffs"

# Récupération des modifications effectuées sur ces méthodes
while read methodName; do
  git log --after=$dateMin -L :$methodName:$cheminJava > "Analyse\\$nomDossierAnalyse/diffs/diff_$nomFichier_$methodName.log"
done <"Analyse\\$nomDossierAnalyse/listeMethodesSeules_$nomFichier.log"

cd "Analyse\\$nomDossierAnalyse/diffs"

# Compte de ces modifications
for diff in ./*.log; do
	numberOfDiffs=$(grep -o 'diff --git' "$diff" | wc -l)
	nomMethode="${diff:7:-4}"
	echo "$nomMethode;$numberOfDiffs" >> "../nombreDiffs_$nomFichier.csv"
	echo "$nomFichier;$nomMethode;$numberOfDiffs" >> "../../nombreDiffTotal.csv"
done
