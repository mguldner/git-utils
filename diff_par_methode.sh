#!/bin/bash

# Parsing des options
while getopts f:l: option
do
case "${option}"
in
f) fileName=${OPTARG};;
l) logFileName=${OPTARG};;
esac
done

IFS=''
nomMethode="${logFileName:7:-4}"
regex_diff="^diff --git"
regex_beginOfMethod="$nomMethode\(.*\) {"
regex_endOfMethod1="^\+  }|^   }|^-  }"
regex_modification1="^\+ |^\- "
interesting=false
analyse=false
modification=false
numberOfDiffs=0

while read line; do
  if [[ $line =~ $regex_diff ]]
  then
	#echo "diff git"
	interesting=true
	
	if [[ "$modification" = true ]]
	then
	  numberOfDiffs=$((numberOfDiffs+1))
	  modification=false
	fi
  fi

  if [[ "$interesting" = true ]]
  then
	if [[ $line =~ $regex_beginOfMethod ]]
	then
	  analyse=true
	  #echo "BEGIN OF ANALYSED METHOD"
	fi

	if [[ "$analyse" = true ]]
    then
	  #echo "$line"
	  if [[ $line =~ $regex_modification1 ]]
	  then
	    #echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!MODIFICATION ON METHOD !!!!"
	    modification=true
	  fi
  
      if [[ $line =~ $regex_endOfMethod1 ]]
      then
        #echo "END OF ANALYSED METHOD"
        interesting=false
	    analyse=false
      fi
	fi
  fi
done <$logFileName

#echo "number of diffs : $numberOfDiffs"
echo "$nomMethode;$numberOfDiffs" >> "../nombreDiffs_$fileName.csv"
echo "$fileName;$nomMethode;$numberOfDiffs" >> "../../nombreDiffTotal.csv"