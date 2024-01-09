#!/bin/bash

# Special variables

#Special Characters :  $0 to $9 , $* , $# , #@ , $$

echo $0    # Prints Script Name 
echo $1    # Takes the first value from the command line 
echo $2    # Takes the second value from the command line 
echo $3    # Takes the second value from the command line
# bash scriptName.sh 100 200 300......900  -->here 100 will goes to $1, 200 goes to $2, 300 goes to $3 
    #ikewise we can supply upto 9 that means $1 to $9- we supply like this when we are not sure of the values and whenever we want to supply the values from command line we use $1.......$9

echo $*    # $* is going to print the used variables  
echo $@    # $@ is going to print the used variables  
echo $$    # $$ is going to print the PID of the current proces 
echo $#    # $# is going to pring the number of arguments
echo $?    # $? is going to print the exit code of the last command.

# $* or $@ both of the prints the used variables in the scirpt