#!/bin/bash


USAGE=(
"Usage: $0 /opt/test 4 az 5 az.az 3kb" "Where:" "Parameter 1 is the absolute path."
    "\tParameter 2 is the number of subfolders."
    "\tParameter 3 is a list of English alphabet letters used in folder names (no more than 7 characters)."
    "\tParameter 4 is the number of files in each created folder."
    "\tParameter 5 - the list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension)."
    "\tParameter 6 - file size (in kilobytes, but not more than 100).")

# check for integer 
if ! [[ $2 =~ [[:digit:]] ]]; then  
    echo -e "Number of subfolders must be integer"
    exit 1
fi

if ! [[ $4 =~ [[:digit::]] ]]; then
    echo -e "Number of files to create must be insteger" 
    exit 1
fi

#digit="${nsize:0:-2}"

if [ $6 -gt 100 ]; then
    echo -e "Test for me"
    exit 1
fi

if [ $# -ne 6 ]; then
    printUsage
    exit 1
fi

# check free space
if [[ $free_space < $min_free_space ]]; then
    echo -e $free_space
    echo -e "Free Space around 1G. Stop"
    exit 1
fi