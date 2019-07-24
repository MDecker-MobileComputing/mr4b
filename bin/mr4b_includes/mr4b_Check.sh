#!/bin/bash

# The purpose of this script is it to check some aspects of the environment relevant for mr4b.
#
# This project is licensed under the terms of the GNU GENERAL PUBLIC LICENSE version 3.

echo

which git 2> /dev/null
if [ $? -ne 0 ]
then
    echo -e "No Git client found!\n"
else
    echo -e "\nVersion of Git: "$(git --version | cut -d " " -f3)"\n"
fi

exit
