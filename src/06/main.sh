#!/bin/bash -e

CHECK_SCRIPT=check.sh
REPORT_NAME=report.html

is_missed() {
    if ! [[ -f "$1" ]]; then
        echo "Error! $1 is missed. Exiting."
        exit 1
    fi
}

is_missed ${CHECK_SCRIPT}

chmod +x ${CHECK_SCRIPT}
./${CHECK_SCRIPT}

echo `LC_TIME="en_US.UTF-8" bash -c 'goaccess ../04/access_logs/log1.log --log-format=COMBINED -o '${REPORT_NAME}''`
open ./${REPORT_NAME}