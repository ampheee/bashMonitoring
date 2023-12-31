#!/bin/bash

USAGE="This script generates log-files into access_log folder in combined format"
LOGS_PATH=./access_logs


if [ $# -ne 0 ]; then
	echo -e "Error! The script must have to no parametres passed!\n${USAGE}"
	exit 1
fi

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

chmod +x logs_generator.sh
./logs_generator.sh

