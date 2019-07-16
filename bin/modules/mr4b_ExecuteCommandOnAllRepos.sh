#!/bin/bash

# This script execute the git command in $1 on all registered repos.

if [ $# -ne 1 ]
then
    echo -e "\nINTERNAL ERROR: No git command passed. Aborting program."
    exit
fi

if [ ! -f "${REPO_LIST_FILE}" ]
then
    echo -e "\nNo Git-Repos are registered, so nothing to do.\n"
    exit
fi


GIT_COMMAND=$1

if [ $GIT_COMMAND == "pull" ]
then
    echo "Sollte jetzt Git-Repos pullen ..."
    exit
fi

if [ $GIT_COMMAND == "fetch" ]
then
    echo "Sollte jetzt Git-Repos fetchen ..."
    exit
fi


if [ $GIT_COMMAND == "status" ]
then
    echo "Sollte jetzt Status von allen Git-Repos abrufen ..."
    exit
fi


echo -e "\nINTERAL ERROR: Call for unsupported Git command '"${GIT_COMMAND}"'.\n"
exit
