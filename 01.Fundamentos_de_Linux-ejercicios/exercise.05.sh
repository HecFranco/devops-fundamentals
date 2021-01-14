#!/bin/bash
# ==============================================================================
# Description
# -----------
#   3. Crear un script de bash que agrupe los pasos de los ejercicios anteriores y además permita establecer el texto de file1.txt alimentándose como parámetro al invocarlo.**
#   Si se le pasa un texto vacío al invocar el script, el texto de los ficheros, el texto por defecto será:
# ==============================================================================
# Variables
# -----------
SUBFOLDERS=("./foo/dummy" "./foo/empty")
FILES=("file1.txt" "file2.txt")
FIRST_FILE=${SUBFOLDERS[0]}/${FILES[0]}
SECOND_FILE=${SUBFOLDERS[0]}/${FILES[1]}
# ==============================================================================
# Functions
# -----------
create_folder(){
  if [ -d "$1" ]; then
    # Take action if $DIR exists. #
    echo "Folder ${1} exist"
  else  
    echo "Create Folder ${1}"  
    mkdir -p $1
  fi      
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
move_content_file(){
  cp $1 $2    
}
move_file(){
  mv $1 $2    
}
# ==============================================================================
# Flow
# -----------
create_subfolders "${SUBFOLDERS[@]}"
#
echo "Me encanta la bash!!" > $FIRST_FILE
touch $SECOND_FILE
move_content_file $FIRST_FILE $SECOND_FILE
move_file $SECOND_FILE "${SUBFOLDERS[1]}"
