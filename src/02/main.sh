#!/bin/bash

CHECK_SCRIPT=check.sh
GENERATE_FILES=generate_files.sh
GENERATE_FOLDERS=generate_folders.sh

is_missed() {
    if ! [[ -f "$1" ]]; then
        echo "Error! $1 is missed. Exiting."
        exit 1
    fi
}

is_missed ${CHECK_SCRIPT}
is_missed ${GENERATE_FILES}
is_missed ${GENERATE_FOLDERS}

chmod +x ${CHECK_SCRIPT} ${GENERATE_FILES} ${GENERATE_FOLDERS}

./${CHECK_SCRIPT}

touch log.txt
log_path=$(pwd)

start=$(date +%T)
start_for_execution=$(date +%s) 
echo -e "\n$start - Start\n" >> $log_path/log.txt
. ./${GENERATE_FILES}
. ./${GENERATE_FOLDERS}

end=$(date +%T)
end_sec=$(date +%s)
echo -e "\n$end - End" >> $log_path/log.txt
exe_sec=$(($end_sec - $start_sec))
exe_hours=$(($exe_sec / 3600))
exe_minutes=$(($exe_sec % 3600 / 60))
echo -e "\n$exe_hours:$exe_minutes:$exe_sec - Running time" >> $log_path/log.txt
echo -e "\n$start - Start\n\n$end - End\n\n$exe_hours:$exe_minutes:$exe - Running time"
