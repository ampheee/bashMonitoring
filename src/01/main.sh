#!/bin/bash

CHECK_SCRIPT=check.sh
GENERATE_FILES_SCRIPT=generate_files.sh
GENERATE_FOLDERS_SCRIPT=generate_folders.sh
INITIAL_PATH=$(pwd)
LOG_PATH=${INITIAL_PATH}/log.txt

is_missed() {
    if ! [[ -f "$1" ]]; then
        echo "Error! $1 is missed. Exiting."
        exit 1
    fi
}


is_missed ${CHECK_SCRIPT}
is_missed ${GENERATE_FILES_SCRIPT}
is_missed ${GENERATE_FOLDERS_SCRIPT}

if [ -d ${LOGS_PATH} ]; then
  read -p "Are you want to rewrite previous logs ? [Y/N]: " yn
  tmp_input=$(echo $yn | tr '[:upper:]' '[:lower:]')
  if [[ "$tmp_input" =~ ^(y|yes)$ ]]; then
    rm -rf access_logs
    echo -e "Previos logs deleted successfully!\nGenerating new logs"
  elif ! [[ "$tmp_input" =~ ^(n|no)$ ]] && ! [[ "$tmp_input" =~ ^(y|yes)$ ]]; then
    echo "Error!"
    echo "Invalid input. Exiting."
    exit 1
  fi
fi

chmod +x ${GENERATE_FILES_SCRIPT} ${GENERATE_FOLDERS_SCRIPT}

. ./${CHECK_SCRIPT}
. ./${GENERATE_FILES_SCRIPT}
. ./${GENERATE_FOLDERS_SCRIPT}