#!/bin/bash
# ==============================================================================
# Description
# -----------
#   2. Mediante comandos de bash, vuelca el contenido de file1.txt a file2.txt y mueve file2.txt a la carpeta empty.**
#   El resultado de los comandos ejecutados sobre la jerarquía anterior deben dar el siguiente resultado.
#   ```
#   foo/
#   ├─ dummy/
#   │  ├─ file1.txt
#   ├─ empty/
#     ├─ file2.txt
#   ```
#   
#   Donde `file1.txt` y `file2.txt` deben contener el siguiente texto:
#   ```
#   Me encanta la bash!!
#   ```
# ==============================================================================
# Variables
# -----------
FIRST_FILE="./foo/dummy/file1.txt"
SECOND_FILE="./foo/dummy/file2.txt"
NEW_FOLDER="./foo/empty/"
# ==============================================================================
# Functions
# -----------
move_content_file(){
  cp $1 $2    
}
move_file(){
  mv $1 $2    
}
#
# ==============================================================================
# Flow
# -----------
move_content_file $FIRST_FILE $SECOND_FILE
move_file $SECOND_FILE $NEW_FOLDER
