#!/bin/bash

USAGE="\nThis script helps you to clean you system.\nUsage: ./main.sh [1-3]"

if [[ $# -ne 1 ]]; then
	echo "Error! Must be passed only one parameter."
	echo -e ${USAGE}
    exit 1
fi

if ! [[ $1 =~ [[:digit:]] ]]; then
	echo -e "Error! Parameter should be a number."
	echo -e ${USAGE}
    exit 1
fi

if ! [[ $1 -eq 1 || $1 -eq 2 || $1 -eq 3 ]]; then
	echo -e "Error! Parameter should be equal 1, 2 or 3."
	echo -e ${USAGE}
    exit 1
fi