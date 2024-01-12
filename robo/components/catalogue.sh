#!/bin/bash

ID=$(id -u)
LOGFILE="/tmp/catalogue.logs"

if [ $ID -ne 0 ] ; then
    echo -e "\e[31m You should execute this script as root user or with a sudo as prefix \e[0m"
    exit 
