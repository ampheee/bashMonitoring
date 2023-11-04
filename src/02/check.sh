#!/bin/bash

USAGE="Script to make junkyard from filesystem.\nUsage: ./main.sh az az.az 3Mb"

if [[ $# -ne 3 ]]; then
	echo "Error! Must be passed three parameters."
    echo -e ${USAGE}
	exit 1
fi


if ! [[ $1 =~ ^[a-zA-Z]{1,7}$ ]]; then 
	echo -e "Error! Must be passed only letters\nOr your input consists of more than 7 signs for folders name."
	echo -e ${USAGE}
    exit 1
fi

if ! [[ $2 =~ ^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$ ]]; then 
	echo -e "Error! Must be passed only letters\nOr your input consists of more than 7 signs in file name.\nOr You either entered something that is not letters\n\tor your input consists of more than 3 signs in file extension."
	echo -e ${USAGE}
    exit 1
fi

nsize=$3
if ! [[ $3 =~ ^[0-9]+Mb$ ]]; then
	if [[ $3 =~ ^[0-9]+$ ]]; then
		echo "Warning! You forgot to write \"Mb\". I am correting this"
		nsize+="Mb"
	else
	echo "Error! 3rd parameter should be the size of files."
	echo -e ${USAGE}
    exit 1
	fi
fi

digit="${nsize:0:-2}"
if ! (( digit <= 100 )); then
	echo -e "Error! 3rd parameter should be the size of files not more than 100."
	echo -e ${USAGE}
    exit 1
fi