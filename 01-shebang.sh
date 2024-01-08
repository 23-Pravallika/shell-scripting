#!/bin/bash

echo " This is bash scripting "
echo  -e "line1\nline2"
echo -e "line3\n\tline4"

# color
echo -e "\e[35m nice color magenta \e[0m"
echo -e "\e[36m printing cyan \e[0m"
echo -e "\e[36;45m printing font colr as cyan and background color as magenta \e[0m"
echo -e "\e[43;32m I am printing Green Color with YELLOW as Background \e[0m"
echo -e "\e[44;35m printing color \e[0m"

# variable in bash/sheel scripting
a=10
b=20
c=30

echo $a
echo ${b}
echo "$c"
echo "I am pritning the value of d $d" 

n=$(who | wc -l)
TODAYDATE=$(date +%F)
echo "Number of users sessions in the system are :$n"
echo $TODAYDATE
PID=$(lsblk)
echo -e "\n $PID"

# Special variables
echo $0    # Prints Script Name 
echo $1    # Takes the first value from the command line 
echo $2    # Takes the second value from the command line 

echo $*    # $* is going to print the used variables  
echo $@    # $@ is going to print the used variables  
echo $$    # $$ is going to print the PID of the current proces 
echo $#    # $# is going to pring the number of arguments
echo $?    # $? is going to print the exit code of the last command.

# $* or $@ both of the prints the used variables in the scirpt
