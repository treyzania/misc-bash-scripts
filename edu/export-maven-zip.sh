#!/bin/bash

PREFIX='assignment'
INC_FILES='include-files.txt'

if [ ! -f $INC_FILES ]; then
	echo 'error: no include-files.txt list'
fi

INCLUDE_DIRS=$(cat $INC_FILES)

# Figure out the versioning information
COMMIT=$(git rev-parse --short HEAD)
MOD_SUFFIX=
if [ -n "$(git status --untracked-files --porcelain)" ]; then
	MOD_SUFFIX='-dirty'
fi

# The actual name of the fle
NAME="$PREFIX-$COMMIT$MOD_SUFFIX.zip"

# Cleanup
rm -f $PREFIX*.zip

# Actually do things.
echo -e "\e[1mCompiling...\e[0m"
mvn clean package | grep -e '--- '
cp target/*.jar .
echo -e "\e[1mPackaging...\e[0m"
zip -r $NAME $INCLUDE_FILES > /dev/null
zipinfo $NAME | tail -n 1

# Cleanup
rm ./*.jar

