#!/bin/bash

# This project is licensed under the terms of the GNU GENERAL PUBLIC LICENSE version 3.

echo -e "\nDepending on the number of direct and indirect folders below"
echo -e "the current folder, this operation might take several minutes.\n"


declare -a ALL_GIT_FOLDERS

ALL_GIT_FOLDERS=( $(find . -type d -name ".git" | sed 's/\.git//') )

NUMBER_FOLDERS_FOUND=${#ALL_GIT_FOLDERS[*]}

echo -e "\nNumber of Git repository folders found: "${NUMBER_FOLDERS_FOUND}"\n"
if [ $NUMBER_FOLDERS_FOUND -eq 0 ]
then
    echo -e "\nNo Git repository folder were found below the current folder, so nothing to do.\n"
    exit
fi

# Ensure that Repository List File exists
if [ ! -f "${REPO_LIST_FILE}" ]
then
    source $(dirname "$0")/mr4b_includes/mr4b_CreateRepoFile.sh
fi


OLD_DIR=$(pwd)

NUMBER_FOLDERS_REGISTERED=0

for GIT_FOLDER in "${ALL_GIT_FOLDERS[@]}"
do

  echo "Found Git repository folder: "$GIT_FOLDER

  cd ${OLD_DIR} > /dev/null
  cd $GIT_FOLDER

  CURRENT_FOLDER=$(pwd)

  grep "${CURRENT_FOLDER}" "${REPO_LIST_FILE}" > /dev/null
  if [ $? -eq 0 ]
  then
    echo -e "Skipping folder, because is already registered.\n"
  else
    echo ${CURRENT_FOLDER} >> "${REPO_LIST_FILE}"
    echo -e "Registered Git repository folder: "${CURRENT_FOLDER}"\n"
    let NUMBER_FOLDERS_REGISTERED+=1
  fi

done

cd ${OLD_DIR} > /dev/null

echo -e "\nNumber of Git repository folders registered: "${NUMBER_FOLDERS_REGISTERED}"\n"

exit
