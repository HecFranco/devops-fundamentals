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
# ==============================================================================
# Flow
# -----------
mkdir -p $ROOT_FOLDER/{dummy,empty}
#
echo "Me encanta la bash!!" > $ROOT_FOLDER/dummy/file1.txt
touch $ROOT_FOLDER/dummy/file2.txt