#!/bin/bash

num_docs=0
num_pdf=0
num_data=0
num_img=0
num_ppt=0
num_other=0

CIANO='\033[0;36m'
VIOLA='\033[0;35m'
ROSSO='\033[0;31m'
VERDE='\033[0;32m'
BLU='\033[0;34m'
RESET='\033[0m'

base="$HOME/archivio"


if [ ! -d $base ]; then
	mkdir $base
fi

echo ""
for file in *; do
	if [ -d "$file" ] || [ "$file" == "cleaner.sh" ]; then
		continue
	fi

	case "$file" in
		*.jpg|*.jpeg|*.png)
			nome="immagini"
			((num_img++))
			;;
		*.pdf)
			nome="pdf"
			((num_pdf++))
			;;
		*.docx|*.doc|*.odt|*.txt|*.rtf)
			nome="documenti"
			((num_docs++))
			;;
		*.xls|*.xlsx|*.csv)
			nome="dati"
			((num_data++))
			;;
		*.ppt|*.pptx)
			nome="presentazioni"
			((num_ppt++))
			;;
		*)
			nome="altro"
			((num_other++))
			;;
	esac

	if [ ! -d "$base/$nome" ]; then
		mkdir "$base/$nome"
	fi
	
	if [ -f "$base/$nome/$file" ]; then
		ext=$(echo "$file" | rev | cut -d . -f1 | rev)
		name=${file%.*}
		new_file="${name}_copia.${ext}"
		mv "$file" "$new_file"
		mv "$new_file" "$base/$nome"
	else
		mv "$file" "$base/$nome"
	fi

	echo -e "Spostato ${CIANO}$file${RESET} -> $nome" 
	sleep 1
done


num_tot=$((num_docs + num_ppt + num_pdf + num_data + num_img + num_other))
echo ""
echo -e "\e[1mProcesso terminato, file spostati: ${CIANO}$num_tot file\e[0m${RESET}"
echo -e "${ROSSO}$num_img${RESET} Immagini -> immagini"
echo -e "${BLU}$num_docs${RESET} Documenti di Testo -> documenti"
echo -e "${VERDE}$num_data${RESET} Fogli di calcolo -> dati"
echo -e "${VIOLA}$num_ppt${RESET} Presentazioni -> presentazioni"
echo "$num_other Altri file -> altro"
echo ""
