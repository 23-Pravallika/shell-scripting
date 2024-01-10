#!/bin/bash


<<COMMENT
  We can use the for loop with the range syntax and indicate the first and last element.
   
   Syntax: for varabile in {START..END}

COMMENT

for var in {1..6}
    do
        echo "{START..END}"
    done

<<COMMENT
COMMENT

a=1
b=10
for i in {$a..$b}   #loop 1
do
    echo "$i"
done