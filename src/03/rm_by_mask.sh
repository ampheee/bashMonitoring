#!/bin/bash

echo -e "Write the mask of files you want to delete in the \033[31m_DDMMYY\033[0m format."
read mask
find / -type d -name "*$mask*" -print0 2>/dev/null|
while IFS= read -r -d '' dir; do
    rm -r "$dir"
    echo "${dir} deleted"
done 