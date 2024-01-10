#!/bin/bash

funct() {
    echo "I am a messaged called from sample function"
}

fu() {
    echo "TodayDate $(date +%D)"
    echo -e "\e[32m Load Average On The system is : $(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}') \e[0m"
    echo -e "\t Total no.of session : $(who | wc -l)"
    funct
}

fu