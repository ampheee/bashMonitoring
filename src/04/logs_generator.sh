#!/bin/bash

FILES_COUNT=5

MAX_RECORDS_COUNT=900
MIN_RECORDS_COUNT=100

MAX_IP_OCTET=254
MIN_IP_OCTET=1

LOGS_PATH=./access_logs

# INFORMATION ABOUT CODES:
# 200 - STATUS_OK.              Response code means that the request was successful. 
# 201 - CREATED_SUCCESS         Response indicates that the request has succeeded and has led to the creation of a resource
# 400 - BAD_REQUEST.            Response shows that the server cannot or will not process the request due to something that is perceived to be a client error
# 403 - FORBIDDEN.              Response for those requests, who have not enough permissions.
# 404 - NOT_FOUND.              Response for non-exist endpoint request.
# 500 - INTERNAL_SERVICE_ERROR. Response, if problem came from server (troubles not on clients side).
# 501 - NOT_IMPLEMENTED.        Response shows that the server does not support the functionality required to fulfill the request.
# 502 - BAD_GATEWAY.            Response shows that the server, while acting as a gateway or proxy, received an invalid response
#   from an inbound server it accessed while attempting to fulfill the request.
# 503 - SERVICE_UNAVAILABLE.    Response code indicates that the server is not ready to handle the request.

RESPONSES=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
METHODS=("GET" "POST" "PUT" "PATCH" "DELETE")
BROWSERS=("Mozilla" "Google Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot" "Library and net tool")

HTTP_VER="HTTP/1.1"

ip_addr() {
  ip_address=""
  for (( k = 0; k < 3; k++))
  do
    ip_address="${ip_address}$(( $RANDOM%${MAX_IP_OCTET} + ${MIN_IP_OCTET}))."
  done
  ip_address="${ip_address}$(( $RANDOM%${MAX_IP_OCTET} + ${MIN_IP_OCTET}))"
  echo -n "${ip_address} - "
}

timestamp() {
  month=$(( $RANDOM%11 + 1 ))
  timestamp=$(LC_TIME=en_US.UTF-8 date -u -d "2023-${month}-${1} $((RANDOM % 24)):$((RANDOM % 60)):$((RANDOM % 60))" +"%d/%b/%Y:%H:%M:%S")
  echo -n  "${timestamp} "
}

url() {
  url="\"${METHODS[$(( $RANDOM%${#METHODS[@]} ))]}"
  url="${url} /eng/endpoint$(( $RANDOM%$1 )) ${HTTP_VER}\" "

  echo -n "${url}"
}

mkdir -p ${LOGS_PATH}
for ((i = 1; i <= ${FILES_COUNT}; i++))
do
  records_count=$(($RANDOM%${MAX_RECORDS_COUNT} + ${MIN_RECORDS_COUNT}))
  log=${LOGS_PATH}/log${i}.log
  touch ${log}
  echo -e "${i}.Generate logs in ${log} file"
  for ((j = 0; j < records_count; j++))
  do
    ip_addr "-" >> ${log}
    timestamp ${i} >> ${log}
    url ${records_count} >> ${log}
    echo -n "${RESPONSES[$(( $RANDOM%${#RESPONSES[@]}))]} " >> ${log}
    echo -e "\"${BROWSERS[$(( $RANDOM%${#BROWSERS[@]}))]}\"" >> ${log}
  done
  echo -e "Done. ${records_count} logs stored in ${log}"
done