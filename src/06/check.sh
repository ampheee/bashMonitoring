#!/bin/bash

USAGE="GoAccess-dashboard script.\nOpens dashbord for logs generated in p.4"

LOGS_PATH=../04/access_logs

is_missed() {
    if ! [[ -f "$1" ]]; then
        echo "Error! $1 is missed. Exiting."
        echo -e ${USAGE}
        exit 1
    fi
}

if ! [ -d ${LOGS_PATH} ]; then
    echo -e "Error! Directory ${LOGS_PATH} is missed. Exiting."
    echo -e ${USAGE}
    exit 1

fi

for (( i=1; i<=5;i++));
do
    is_missed ${LOGS_PATH}/log${i}.log
done