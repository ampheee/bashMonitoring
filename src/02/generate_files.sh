#!/bin/bash

NAME=$(echo "$2" | cut -d '.' -f 1)
EXTENSION=$(echo "$2" | cut -d '.' -f 2)
FILESIZE=$(echo "$3" | sed 's/Mb/M/')
LENGTH_NAME=${#NAME}
ITERATIONS=1
GENERATE_FOLDERS_SCRIPT=generate_folders.sh

function fless_than_five {
    fbase=""
    if [[ $LENGTH_NAME -eq 1 ]]; then
        fbase="$NAME$NAME$NAME$NAME$NAME"
    else
        for (( j = 0; j < LENGTH_NAME; j++ )); do
                fsign="${NAME:j:1}"
                fbase="$fbase$fsign$fsign$fsign"
        done
    fi
}

function files_generation {
    FILES=$(shuf -i 1-10 -n 1)
    if [[ $LENGTH_NAME -lt 5 ]]; then
        fless_than_five
    else
        fbase=$NAME
    fi
    fname="${fbase}"
    for (( i = 1; i <= ${FILES}; i++ )); do
        filename=""
        available_space=0
        if (( ITERATIONS % 2 == 0 )); then
            fchar="${fname:0:1}"
            fname="${fchar}${fname}"
        else
            fname=$(echo "$fname" | awk 'BEGIN{FS=""; OFS=""} {$(NF+1)=$NF} 1')
        fi
        filename+="$(echo $fname)"
        filename+="_"
        filename+=$(date +"%d%m%y")
        filename+="." 
        filename+="$EXTENSION"
        available_space=$(df -h -m / | awk '{print $4}' | awk 'NR==2' | sed 's/G//')
        if (( $available_space < 1024)); then
            break
        fi
        fallocate -l "$FILESIZE" "$filename" 2>/dev/null
        file_path=$(pwd)
        echo -e "$(date +"%Y-%m-%d %R") - $file_path/$filename - $FILESIZE" >> ${LOG_PATH}
        ((ITERATIONS++))
    done
}