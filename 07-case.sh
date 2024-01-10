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



case $Option in
    Addition)
        echo "Addition of numbers: $($1+$1)"
        ;;
    Mulitiplication)
        echo "Mulitiplication of numbers :$($1*$2)"
        ;;
    *)

    echo -e "\e[31m Invalid Option \e[0m"
esac    