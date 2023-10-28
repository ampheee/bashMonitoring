#!/bin/bash -e

LOGS_PATH=../04/access_logs
TEMP_LOG="./temp.log"

is_missed() {
    if ! [[ -f "$1" ]]; then
        echo "Error! $1 is missed. Exiting."
        exit 1
    fi
}

sort_1() {
    for (( i=1; i<=5; i++))
    do
        log=${LOGS_PATH}/log${i}.log
        is_missed ${log}
        cat ${log} >> ${TEMP_LOG}
    done
    awk '{print $0}' ${TEMP_LOG} | sort -n -k 7
    rm -rf ${TEMP_LOG}
}

sort_2() {
    for (( i=1; i<=5; i++))
    do
        log=${LOGS_PATH}/log${i}.log
        is_missed ${log}
        cat ${log} >> ${TEMP_LOG}
    done
    awk '{print $1}' ${TEMP_LOG} | sort -nu
    rm -rf ${TEMP_LOG}
}

sort_3() {
    for (( i=1; i<=5; i++))
    do
        log=${LOGS_PATH}/log${i}.log
        is_missed ${log}
        cat ${log} >> ${TEMP_LOG}
    done
    awk '{
            if ($7 >= 400) {
                print $0
            }
        }' ${TEMP_LOG} | sort -n -k 7
    rm -rf ${TEMP_LOG}
}

sort_4() {
    for (( i=1; i<=5; i++))
    do
        log=${LOGS_PATH}/log${i}.log
        is_missed ${log}
        cat ${log} >> ${TEMP_LOG}
    done
    awk '{
        if ($7 >= 400) {
            print $1
        }
    }' ${TEMP_LOG} | sort -nu
    rm -rf ${TEMP_LOG}
}

case $1 in
    1 ) echo -e "Getting all entries sorted by response code"; sort_1;;
    2 ) echo -e "Getting all unique IPs occurring in records"; sort_2;;
    3 ) echo -e "Getting all requests with errors (response code is 4xx or 5xx"; sort_3;;
    4 ) echo -e "Getting unique IPs that occur among erroneous queries"; sort_4;;
esac


echo -e "Getted!"