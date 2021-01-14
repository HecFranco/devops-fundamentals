#!/bin/bash
# ==============================================================================
# Description
# -----------
#   4. Opcional - Crea un script de bash que descargue el conetenido de una página web a un fichero.
#   Una vez descargado el fichero, que busque en el mismo una palabra dada (esta se pasará por parametro) y muestre por pantalla el número de linea donde aparece.
# ==============================================================================
# Variables
# -----------
URL=$1
FILE="./web.html"
WORD=$2
# ==============================================================================
# Functions
# -----------
download_url_content(){
  curl $1 -o $2  
}
#
# ==============================================================================
# Flow
# -----------
download_url_content $URL $FILE
grep -n $WORD $FILE | cut -d : -f 1