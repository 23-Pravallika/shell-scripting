#!/bin/bash

Action=$1

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

Option=$2

case $Option in
    Addition)
        echo "Addition of numbers"
        ;;
    Mulitiplication)
        echo "Mulitiplication of numbers"
        ;;
    *)

    echo -e "\e[31m Invalid Option \e[0m"
esac    