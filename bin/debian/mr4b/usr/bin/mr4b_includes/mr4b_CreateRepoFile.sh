#!/bin/bash

# This script is to be called when repo list file is to be created.
#
# This project is licensed under the terms of the GNU GENERAL PUBLIC LICENSE version 3.


if [ -f "${REPO_LIST_FILE}" ]
then
    echo -e "\nINTERNAL WARNING: Create of repo list file was called, but file is already existing.\n"
else
    echo    "# Each non-empty line which is not commented out like this line must contain the full path"  > "${REPO_LIST_FILE}"
    echo    "# to a registered repository folder."                                                       >> "${REPO_LIST_FILE}"
    echo -e "# This repository list file was created at "$(date)".\n"                                    >> "${REPO_LIST_FILE}"

    echo -e "\nRepository List File was created:\n"${REPO_LIST_FILE}"\n"
fi
