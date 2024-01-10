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
    
    echo "\e[32m Invalid option Pls enter the valid option \e[0m"    

esac
