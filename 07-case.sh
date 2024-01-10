#!/bin/bash

Action=$1
Option=$2

case $Action in
  Add)
   echo "Adding"
   ;;
  Mul)
   echo "Mulitiplication"
   ;;
  div)
  echo "Division" 
  ;;
  
  *)
    
    echo  -e "\e[31m Invalid option Pls enter the valid option \e[0m"    

esac

a=2
b=3

case $Option in
    Addition)
        echo "Addition of numbers: $($a+$b)"
        ;;
    Mulitiplication)
        echo "Mulitiplication of numbers :$($a*$b)"
        ;;
    *)

    echo -e "\e[31m Invalid Option \e[0m"
esac    