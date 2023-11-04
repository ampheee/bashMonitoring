#!/bin/bash

while IFS= read -r line; do
    path=$(echo "$line" | awk -F " - " '{print $2}')
    if [[ -d ${path} ]]; then
        rm -rf "${path}"
        echo "${path} deleted"
    fi
done < "${LOG_PATH}"