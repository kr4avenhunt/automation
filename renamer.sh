#!/bin/bash

count=0

CIANO='\033[0;36m'
VIOLA='\033[0;35m'
ROSSO='\033[0;31m'
VERDE='\033[0;32m'
BLU='\033[0;34m'
RESET='\033[0m'

echo ""

for file in *; do
	if [ -d "$file" ] || [ "$file" == "renamer.sh" ]; then
		continue
	fi	

	ext=${file##*.}
	new_name="file${count}.${ext}"
	
	((count++))

	if [ -f $new_name ]; then
		new_name="file${count}_copia.${ext}"
	fi

	echo -e "Rinominato ${CIANO}$file${RESET} -> $new_name"
	
	if [ ! $file == $new_name ]; then
		mv $file $new_name
	fi	

	sleep 1

done

echo ""
echo -e "\e[1mProcesso terminato, file rinominati: ${CIANO}$count file\e[0m${RESET}"
echo ""

