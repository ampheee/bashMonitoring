#!/bin/bash -e

case $1 in
    1 ) echo -e "Getting all entries sorted by response code";;
    2 ) echo -e "Getting all unique IPs occurring in records";;
    3 ) echo -e "Getting all requests with errors (response code is 4xx or 5xx";;
    4 ) echo -e "Getting unique IPs that occur among erroneous queries";;
esac


echo -e Sorted!