#!/bin/bash
# ==============================================================================
# Description
# -----------
#   1. Crea mediante comandos de bash la siguiente jerarquía de ficheros y directorios.**
#   ```
#   foo/
#   ├─ dummy/
#   │  ├─ file1.txt
#   │  ├─ file2.txt
#   ├─ empty/
#   ```
#   Donde `file1.txt` debe contener el siguiente texto:
#   ```
#   Me encanta la bash!!
#   ```
#   Y `file2.txt` debe permanecer vacío.
# ==============================================================================
# Variables
# -----------
ROOT_FOLDER="./foo"
SUBFOLDERS=("./dummy" "./empty")
# ==============================================================================
# Functions
# -----------
create_folder(){
  if [ -d "$1" ]; then
    # Take action if $DIR exists. #
    echo "Folder ${1} exist"
  else  
    echo "Create Folder ${1}"  
    mkdir $1
  fi      
}
#
create_root_folder(){
  create_folder $ROOT_FOLDER
}
#
create_subfolders(){
  arr=("$@")
  echo "array: " $arr
  for i in "${arr[@]}";
    do
      : 
      # do whatever on $i
      echo "$i"
      create_folder $i
    done
}
# ==============================================================================
# Flow
# -----------
create_root_folder
cd $ROOT_FOLDER
echo "show current folder" && pwd
create_subfolders "${SUBFOLDERS[@]}"
#
cd $SUBFOLDERS
echo "Me encanta la bash!!" > file1.txt
touch file2.txt