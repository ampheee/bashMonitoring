#!/bin/bash

PATH=$1
MAX_FOLDERS=$2
LETTERS=$3
LENGTH=${#LETTERS}
FOLDERS=0
ITERATION=1
REQUIRED_SPACE=$((1000*1000)) 

INITIAL_PATH=$(pwd)
LOG_PATH=${INITIAL_PATH}/log.txt
cd "$PATH"

function less_than_four {
    if [[ $LENGTH -eq 1 ]]; then
        base="$LETTERS$LETTERS$LETTERS$LETTERS"
    else
        for (( j = 0; j < LENGTH; j++ )); do
                sign="${LETTERS:j:1}"
                base="$base$sign$sign"
        done
    fi
}

    
if [[ $LENGTH -lt 4 ]]; then
    less_than_four
else
    base=$LETTERS
fi
name="${base}"

while (( FOLDERS <= MAX_FOLDERS )); do
    available_space=0
    folder_name=""
    if (( ITERATION % 2 == 0 )); then
        char="${name:0:1}"
        name="${char}${name}"
    else
    name=$(echo "${name}" | awk 'BEGIN{FS=""; OFS=""} {$(NF+1)=$NF} 1')
    fi
    folder_name+="$(echo ${name})"
    folder_name+="_"
    folder_name+=$(date +"%d%m%y")
    mkdir ${folder_name}
    folder_path=$(pwd)
    echo -e "$(date +"%Y-%m-%d") -     - $folder_path/$folder_name" >> $LOG_PATH
    available_space=$(df -k / | awk '{print $4}' | awk 'NR==2')
    if [[ ${available_space} -lt ${REQUIRED_SPACE} ]]; then
        echo "About 1GB of free space left in the file system. Process stopped."
        break
    fi 
    cd ${folder_name}
    files_generation
    cd - > /dev/null
    ((ITERATION++))
    ((FOLDERS++))
    if (( FOLDERS >= MAX_FOLDERS )); then
        break
    fi
done