#!/bin/bash

echo " This is bash scripting "
echo  -e "line1\nline2"
echo -e "line3\n\tline4"

# color
echo -e "\e[35m nice color magenta \e[0m"
echo -e "\e[36m printing cyan \e[0m"
echo -e "\e[36m;45m printing font colr-cyan and background color-magenta \e[0m"
