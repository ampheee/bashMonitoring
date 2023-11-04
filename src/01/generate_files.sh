#!/bin/bash

NAME=$(echo "$5" | cut -d '.' -f 1)
EXTENSION=$(echo "$5" | cut -d '.' -f 2)
FILESIZE=$(echo "$3" | sed 's/kb/K/')
LENGTH_NAME=${#NAME}
MAX_FILES=$4
ITERATIONS=1
INITIAL_PATH=$(pwd)
LOG_PATH=${INITIAL_PATH}/log.txt

function fless_than_four {
    start=""
    if [[ ${LENGTH_NAME} -eq 1 ]]; then
        start="${NAME}${NAME}${NAME}${NAME}"
    else
        for (( j = 0; j < LENGTH_NAME; j++ )); do
                fsign="${NAME:j:1}"
                start="${start}${fsign}${fsign}"
        done
    fi
}

function files_generation {
    files=0
    if [[ ${LENGTH_NAME} -lt 4 ]]; then
        fless_than_four
    else
        start=${NAME}
    fi
    fname="${start}"
    while (( files < MAX_FILES )); do
        filename=""
        if (( ITERATIONS % 2 == 0 )); then
            fchar="${fname:0:1}"
            fname="${fchar}${fname}"
        else
            fname=$(echo "${fname}" | awk 'BEGIN{FS=""; OFS=""} {$(NF+1)=$NF} 1')
        fi
        filename+="$(echo ${fname})"
        filename+="_"
        filename+=$(date +"%d%m%y")
        filename+="." 
        filename+="${EXTENSION}"
        fallocate -l "${FILESIZE}" "${filename}" 2> /dev/null
        file_path=$(pwd)
        echo -e "$(date +"%Y-%m-%d") - ${FILESIZE} - ${file_path}/${filename}" >> ${LOG_PATH}
        ((ITERATIONS++))
        ((files++))
    done
}