#!/bin/bash

echo -e "Write the date of files you want to start to delete in the \033[31mYYYY-MM-DD HH:MM\033[0m format."
read start_time

echo -e "Write the date of files you want to end to delete in the \033[31mYYYY-MM-DD HH:MM\033[0m format."
read end_time

start=$(date -d "$start_time" +%s)
end=$(date -d "$end_time" +%s)

while read -r line; do
    time=$(echo "$line" | awk -F ' - ' '{print $1}')
    dir=$(echo "$line" | awk -F ' - ' '{print $2}')

    dir_time=$(date -d "$time" +%s)

    if [[ $dir_time -ge $start && $dir_time -le $end ]]; then
        if [[ -d $dir ]]; then
            rm -r "$dir"
            echo "${dir} deleted"
        fi
    fi

done < "$LOG_PATH"