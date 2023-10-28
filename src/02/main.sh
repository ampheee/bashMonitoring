#!/bin/bash

chmod +x check.sh

. ./check.sh

touch log.txt
log_path=$(pwd)

start=$(date +%T)
start_for_execution=$(date +%s) 
echo -e "\n$start - Start\n" >> $log_path/log.txt
chmod +x generate_files.sh generate_folders.sh
. ./generate_files.sh
. ./generate_folders.sh

end=$(date +%T)
end_sec=$(date +%s)
echo -e "\n$end - End" >> $log_path/log.txt
exe_sec=$(($end_sec - $start_sec))
exe_hours=$(($exe_sec / 3600))
exe_minutes=$(($exe_sec % 3600 / 60))
echo -e "\n$exe_hours:$exe_minutes:$exe_sec - Running time" >> $log_path/log.txt
echo -e "\n$start - Start\n\n$end - End\n\n$exe_hours:$exe_minutes:$exe - Running time"
