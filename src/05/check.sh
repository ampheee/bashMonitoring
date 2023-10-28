#!/bin/bash -e

USAGE="This script for sorting logs from p.4\nUsage: ./main.sh [1-4]\n
    1.All entries sorted by response code\n
    2.All unique IPs occurring in records\n
    3.All requests with errors (response code is 4xx or 5xx)\n
    4.All unique IPs that occur among erroneous queries"

if [[ $# != 1 ]]; then
    echo -e "Error! Only 1 parametr must be passed!"
    echo -e ${USAGE}
    exit 1
fi

case $1 in
    [1-4] ) ;;
    * ) echo -e "Error! Parameter must be 1, 2, 3 or 4."; echo -e ${USAGE}; exit 1;;
esac