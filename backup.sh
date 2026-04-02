#!/bin/bash

DEST="$HOME/backups"
DATA=$(date +%Y-%m-%d)
NOME="backup_${DATA}"	
list=( * )
count=1
ORIGINALE=$NOME

while [ -d "$DEST/$NOME" ] || [ -f "$DEST/$NOME.zip" ]; do
	temp="${ORIGINALE}_copia${count}"
	NOME=$temp
	((count++))			
done

mkdir -p "$DEST/$NOME"	

echo "Copia dei file in corso.."
cp -r "${list[@]}" "$DEST/$NOME"

cd "$DEST"

zip -r "${NOME}.zip" "$NOME"

rm -rf "$NOME"

ls -1tr "$DEST"/*.zip | head -n -2 | xargs -r rm -f
