#!/bin/bash

Action=$1

case $Action in
  Add)
   echo "Adding"
   ;;
  Mul)
   echo "Mulitiplication"
   ;;
  Other)
  echo "Invalid options" 
  ;;
esac
