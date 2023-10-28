#!/bin/bash

date=$(date +"%d%m%y")
min_free_space=1073741824
free_space=$(df --output=avail / | tail -n 1)


function printUsage {
    for rule in "${usage[@]}";
    do
        echo -e $rule
    done
}



# printUsage