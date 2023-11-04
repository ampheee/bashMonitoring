#!/bin/bash

LOG_PATH="../02/log.txt"
CHECK_SCRIPT="check.sh"
BY_LOG_SCRIPT=rm_by_log.sh
BY_DATE_SCRIPT=rm_by_date.sh
BY_MASK_SCRIPT=rm_by_mask.sh

is_missed() {
    if ! [[ -f "$1" ]]; then
        echo "Error! $1 is missed. Exiting."
        exit 1
    fi
}

is_missed ${CHECK_SCRIPT}

. ./${CHECK_SCRIPT}

case $1 in
    1)  is_missed ${BY_LOG_SCRIPT}; is_missed ${LOG_PATH}; chmod +x ${BY_LOG_SCRIPT}; . ./${BY_LOG_SCRIPT};;
    2)  is_missed ${BY_DATE_SCRIPT}; is_missed ${LOG_PATH}; chmod +x ${BY_DATE_SCRIPT}; . ./${BY_DATE_SCRIPT};;
    3)  is missed ${BY_MASK_SCRIPT}; chmod +x ${BY_MASK_SCRIPT}; . ./${BY_MASK_SCRIPT};;
esac