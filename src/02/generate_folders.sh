#!/bin/bash

MAX_FOLDERS=100
ALL_FOLDERS=$(find / -type d 2> /dev/null -not -path "*/bin/*" -not -path "*/sbin/*" -not -path "*/sys/*") 
RAND_FOLDERS=$(echo "$ALL_FOLDERS" | shuf -n "$MAX_FOLDERS")
LETTERS=$1
LENGTH=${#LETTERS}
FOLDERS=0
ITERATION=1
INITIAL_PATH=$(pwd)
LOG_PATH=${INITIAL_PATH}/log.txt
GENERATE_FILES_SCRIPT=generate_files.sh
. ${GENERATE_FILES_SCRIPT}
function less_than_five {
    if [[ $LENGTH -eq 1 ]]; then
        base="$LETTERS$LETTERS$LETTERS$LETTERS$LETTERS"
    else
        for (( j = 0; j < LENGTH; j++ )); do
                sign="${LETTERS:j:1}"
                base="$base$sign$sign$sign"
        done
    fi
}

if [[ $length -lt 5 ]]; then
    less_than_five
else
    base=$LETTERS
fi

. ${GENERATE_FILES_SCRIPT}

name="${base}"
available_space=$(df -h -m / | awk '{print $4}' | awk 'NR==2' | sed 's/G//')

while (( ${available_space} > 1024 )); do
    for folder in ${RAND_FOLDERS}; do
        if [ -w "${folder}" ]; then
            cd ${folder}
            available_space=0
            folder_name=""
            if (( ITERATION % 2 == 0 )); then
                char="${name:0:1}"
                name="${char}${name}"
            else
                name=$(echo "$name" | awk 'BEGIN{FS=""; OFS=""} {$(NF+1)=$NF} 1')
            fi
            folder_name+="$(echo $name)"
            folder_name+="_"
            folder_name+=$(date +"%d%m%y")
            available_space=$(df -h -m / | awk '{print $4}' | awk 'NR==2' | sed 's/G//')
            if (( ${available_space} < 1024)); then
                break
            fi
            mkdir $folder_name 2>/dev/null
            folder_path=$(pwd)
            echo -e "$(date +"%Y-%m-%d %R") - ${folder_path}/${folder_name}" >> ${LOG_PATH}
            cd $folder_name 2>/dev/null
            files_generation
            cd - > /dev/null
            cd "${INITIAL_PATH}"
            ((ITERATION++))
        fi
    done <<< "${RAND_FOLDERS}"   
    available_space=$(df -h -m / | awk '{print $4}' | awk 'NR==2' | sed 's/G//')
done
echo "About 1GB of free space left in the file system. Process stopped."