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

# n=$(who | grep wc -l)
TODAYDATE=$(date +%F)
# echo -e "Number of users sessions in the system are $n"
echo $TODAYDATE