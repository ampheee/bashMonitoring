#!/bin/bash


USAGE=(
"Usage: $0 /opt/test 4 az 5 az.az 3kb"
	"\tParameter 1 is the absolute path."
    "\tParameter 2 is the number of subfolders."
    "\tParameter 3 is a list of English alphabet letters used in folder names (no more than 7 characters)."
    "\tParameter 4 is the number of files in each created folder."
    "\tParameter 5 - the list of English alphabet letters used in the file name and extension (no more than 7 characters for the name, no more than 3 characters for the extension)."
    "\tParameter 6 - file size (in kilobytes, but not more than 100).")

printUsage() {
	for rule in "${USAGE[@]}"; do
		echo -e "${rule}"
	done
}

if [[ $# -ne 6 ]]; then
	echo "Error! Must be passed six parameters."
	printUsage
	exit 1
fi

if [[ ! -d  $1 ]]; then
	echo "Error! 1st parameter must be a directory."
	echo -e ${USAGE}
	exit 1
fi

if ! [[ $2 =~ [[:digit:]] ]]; then
	echo -e "Error! 2nd parameter must be a number of subfolders."
	exit 1
fi

if ! [[ $3 =~ ^[a-zA-Z]{1,7}$ ]]; then 
	echo -e "Error! You either entered something that is not letters\n\tOr your input consists of more than 7 signs for folders name."
	printUsage
	exit 1
fi

if ! [[ $4 =~ [[:digit:]] ]]; then
	echo -e "Error! 4th parameter must be a number of files.\nPlease enter numbers."
	printUsage
	exit 1
fi

if ! [[ $5 =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then 
	echo -e "Error! You either entered something that is not letters\n\tor your input consists of more than 7 signs in file name.\nOr You either entered something that is not letters\n\tor your input consists of more than 3 signs in file extension."
	printUsage
	exit 1
fi

nsize=$6
if ! [[ $6 =~ ^[0-9]+kb$ ]]; then
	if [[ $6 =~ ^[0-9]+$ ]]; then
		echo "Warning! You forgot to write \"kb\", correcting.)"
		nsize+="kb"
		echo "Corrected."
	else
	echo -e "Error! 6th parameter must be the size of files."
	printUsage
	exit 1
	fi
fi

digit="${nsize:0:-2}"
if ! (( digit <= 100 )); then
	echo -e "Error! 6th parameter must be the size of files not more than 100."
	printUsage
	exit 1
fi