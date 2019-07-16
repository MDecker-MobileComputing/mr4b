#!/bin/bash

# This script execute the git command in $1 on all registered repos.


if [ $# -ne 1 ]
then
    echo -e "\nINTERNAL ERROR: No git command passed. Aborting program."
    exit
fi

readonly GIT_COMMAND=$1


# Whitelisting supported Git commands
if [ ! $GIT_COMMAND == "pull" -a ! $GIT_COMMAND == "fetch" -a ! $GIT_COMMAND == "status" ]     
then
    echo -e "\nUnsupported command '"${GIT_COMMAND}"' -- aborting program.\n"
    exit
fi

readonly MESSAGE_NO_REPO_FOLDERS="\nNo Git repository folders are registered, so nothing to do.\n"

if [ ! -f "${REPO_LIST_FILE}" ]
then
    echo -e $MESSAGE_NO_REPO_FOLDERS
    exit
fi


# ### Build array of registered folders (i.e. evaluate repo list file) ###

declare -a REPO_FOLDERS_ARRAY

exec 3<&0 0< "${REPO_LIST_FILE}"
while read CURRENT_LINE
do
  # TODO: Trim CURRENT_LINE before further processing, e.g. https://stackoverflow.com/questions/369758/
  
  # Is CURRENT_LINE empty?
  CURRENT_LINE_LENGTH=${#CURRENT_LINE}
  if [ $CURRENT_LINE_LENGTH -ne 0 ]
  then  
      # Is CURRENT_LINE a comment line?
      FIRST_CHAR=${CURRENT_LINE:0:1}
      
      if [ "${FIRST_CHAR}" != "#" ]
      then
        REPO_FOLDERS_ARRAY+=("$CURRENT_LINE")
      fi    
  fi
    
done

NUMBER_REPO_FOLDERS=${#REPO_FOLDERS_ARRAY[*]}
echo -e "\nNumber of repository folders: "${NUMBER_REPO_FOLDERS}"\n"
if [ $NUMBER_REPO_FOLDERS -eq 0 ]
then
    echo -e $MESSAGE_NO_REPO_FOLDERS
    exit
fi



# ### Execute the git command in all the relevant repo folder ###

FOLDER_BEFORE_WORK=$(pwd)

COUNTER=1
for REPO_FOLDER in "${REPO_FOLDERS_ARRAY[@]}" 
do
  echo -e "\n\nProcessing repo folder "${REPO_FOLDER}" ("${COUNTER}" of "${NUMBER_REPO_FOLDERS}"):\n"
  cd $REPO_FOLDER
  git $GIT_COMMAND
  let COUNTER+=1
done

cd "${FOLDER_BEFORE_WORK}"
