#!/bin/bash

echo " This is bash scripting "
echo  -e "line1\nline2"
echo -e "line3\n\tline4"

# color
echo -e "\e[35m nice color magenta \e[0m"
echo -e "\e[36m printing cyan \e[0m"
echo -e "\e[36;45m printing font colr as cyan and background color as magenta \e[0m"
echo -e "\e[43;32m I am printing Green Color with YELLOW as Background \e[0m"
echo -e "\e[43 printing background color \e[0"

# 