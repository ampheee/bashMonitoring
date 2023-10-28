#!/bin/bash -e

CHECK_SCRIPT=check.sh
SORT_SCRIPT=sort_awk.sh


is_missed() {
    if ! [[ -f "$1" ]]; then
        echo "Error! $1 is missed. Exiting."
        exit 1
    fi
}

is_missed ${CHECK_SCRIPT}
is_missed ${SORT_SCRIPT}

chmod +x ${CHECK_SCRIPT} ${SORT_SCRIPT}

./${CHECK_SCRIPT} $@

./${SORT_SCRIPT} $1