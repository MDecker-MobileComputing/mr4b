#!/bin/bash


declare -a ALL_GIT_FOLDERS

ALL_GIT_FOLDERS=( $(find . -type d -name ".git") )


echo -e "\nNumber of Git repository folders found: "${#MEIN_ARRAY[*]}"\n"

OLD_DIR=$(pwd)

for GIT_FOLDER in "${ALL_GIT_FOLDERS[@]}" 
do
  echo "Found Git repository folder: "$GIT_FOLDER
  
  cd ${OLD_DIR} > /dev/null
  cd $GIT_FOLDER
  cd ..
  source $(dirname "$0")/modules/mr4b_RegisterRepo.sh
done

cd ${OLD_DIR} > /dev/null

exit
