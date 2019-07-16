#!/bin/bash


declare -a ALL_GIT_FOLDERS

ALL_GIT_FOLDERS=( $(find . -type d -name ".git" | sed 's/\.git//') )


echo -e "\nNumber of Git repository folders found: "${#MEIN_ARRAY[*]}"\n"

OLD_DIR=$(pwd)

for GIT_FOLDER in "${ALL_GIT_FOLDERS[@]}" 
do
  
  echo "Found Git repository folder: "$GIT_FOLDER
  
  cd ${OLD_DIR} > /dev/null
  cd $GIT_FOLDER
  
  grep "${GIT_FOLDER}" "${REPO_LIST_FILE}"
  if [ $? -eq 0 ]
  then
    echo "Skipping folder, because is already registered."
  else
    pwd >> "${REPO_LIST_FILE}"
  fi
  
  #source $(dirname "$0")/modules/mr4b_RegisterRepo.sh
done

cd ${OLD_DIR} > /dev/null

exit
