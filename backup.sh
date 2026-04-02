#!/bin/bash

DEST="$HOME/backups"
DATA=$(date +%Y-%m-%d)
NOME="backup_${DATA}"	
list=( * )

mkdir -p "$DEST/$NOME"

echo "Copia dei file in corso.."
cp -r "${list[@]}" "$DEST/$NOME"

cd "$DEST"

zip -r "${NOME}.zip" "$NOME"

rm -rf "$NOME"
