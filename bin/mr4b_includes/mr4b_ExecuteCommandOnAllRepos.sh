#!/bin/bash

# This script execute the git command in $1 on all registered repos.
#
# This project is licensed under the terms of the GNU GENERAL PUBLIC LICENSE version 3.


if [ $# -eq 0 ]
then
    echo -e "\nINTERNAL ERROR: No Git command passed. Aborting program."
    exit
fi

readonly GIT_COMMAND=$1
readonly GIT_ARGUMENT=$2 # might be empty

readonly STOPWATCH_START=$(date +%s) # Store number of seconds since 1st January 2019

echo "GIT_COMMAND="$GIT_COMMAND

# Whitelisting supported Git commands
if [ $GIT_COMMAND != "pull" -a  $GIT_COMMAND != "fetch" -a $GIT_COMMAND != "merge" -a $GIT_COMMAND != "status" -a $GIT_COMMAND != "gc" -a $GIT_COMMAND != "config" ]
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


# For Git commands which perform networks requests a sleep time is to be enforced between the
# command executions to prevent too much load on the Git server.
SLEEP_TIME_SECONDS=0
if [ $GIT_COMMAND == "pull" -o $GIT_COMMAND == "fetch" ]
then
    SLEEP_TIME_SECONDS=10
    echo -e "\nGit command requires network operations, therefore wait time of "${SLEEP_TIME_SECONDS}" seconds"
    echo -e "between command executions.\n"
fi



# ### Execute the git command in all the relevant repository folders ###

FOLDER_BEFORE_WORK=$(pwd)

COUNTER=1
for REPO_FOLDER in "${REPO_FOLDERS_ARRAY[@]}"
do
  echo -e "\nProcessing repository folder "${REPO_FOLDER}" ("${COUNTER}" of "${NUMBER_REPO_FOLDERS}"):"
  cd $REPO_FOLDER
  git $GIT_COMMAND $GIT_ARGUMENT
  echo

  if [ $SLEEP_TIME_SECONDS -gt 0 -a $COUNTER -lt $NUMBER_REPO_FOLDERS ]
  then
    echo -e "Waiting for "${SLEEP_TIME_SECONDS}" seconds ...\n"
    sleep $SLEEP_TIME_SECONDS
  fi

  let COUNTER+=1
done

cd "${FOLDER_BEFORE_WORK}"


readonly STOPWATCH_STOP=$(date +%s)
RUNTIME_SECONDS=$(( $STOPWATCH_STOP - $STOPWATCH_START ))
if [ $RUNTIME_SECONDS -gt 59 ]
then
    RUNTIME_MINUTES=$(( $RUNTIME_SECONDS / 60 ))
    RUNTIME_REMAINDER_SECONDS=$(( $RUNTIME_SECONDS - 60*$RUNTIME_MINUTES ))

    if [ $RUNTIME_MINUTES -eq 1 ]
    then
        echo -e "\nTotal runtime: 1 minute and "${RUNTIME_REMAINDER_SECONDS}" seconds\n"
    else
        echo -e "\nTotal runtime: "${RUNTIME_MINUTES}" minutes and "${RUNTIME_REMAINDER_SECONDS}" seconds\n"
    fi
else
    echo -e "\nTotal runtime: "${RUNTIME_SECONDS}" seconds"
fi
