#!/bin/bash

TARGET_FOLDER=output

mkdir -p $TARGET_FOLDER
# -p: Create folder if needed, but no error if it already exists


gzip -c mr4b.1 > ${TARGET_FOLDER}/mr4b.1.gz
# -c: Do not alter input file, write compressed output to STDOUT


echo -e "\nMan page was created: "$(find output -type f)
echo
