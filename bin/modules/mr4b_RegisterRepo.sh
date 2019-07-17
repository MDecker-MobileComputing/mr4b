#!/bin/bash

# This script is called to add the current directory to the list of registered repository folders.

CURRENT_DIR=$(pwd)

if [ ! -f "${REPO_LIST_FILE}" ]
then
    echo    "# Each non-empty line which is not commented out like this line must contain full path to a folder with a registered repo."  > "${REPO_LIST_FILE}"
    echo -e "# This repo list file was created at "$(date)".\n"                                                                          >> "${REPO_LIST_FILE}"

    echo -e "\nRepository List File "${REPO_LIST_FILE}" was created.\n"
else
    grep "${CURRENT_DIR}" "${REPO_LIST_FILE}" > /dev/null 2> /dev/null
    if [ $? -eq 0 ]
    then
        echo -e "\nCurrent folder is already registered.\n"
        exit
    fi
fi


# Check if $CURRENT_DIR is the root folder of a Git repository
if [ ! -d ".git" ]
then
    echo -e "\nRegistration failed: Current folder is not the root folder of a Git repository.\n"
    exit
fi


# When we come to this point, then $CURRENT_DIR has to be appended to the repository list file
echo $CURRENT_DIR >> "${REPO_LIST_FILE}"
echo -e "\nThe following entry was added to the repository list file:\n"${CURRENT_DIR}"\n"
