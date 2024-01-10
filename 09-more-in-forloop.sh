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

    We cannot use for loop range with variables (as shown below)

COMMENT

a=1
b=10
for i in {$a..$b}   #loop 1
do
    echo "$i"
done

<<COMMENT

    Using range with increment or decrement factor (as shown below)
    Syntax:
            for variable in {START..END..FACTOR}
COMMENT

echo "Using range with increment factor"
for j in {1..6..2}
do
    echo "$j"
done


echo "Using range with decrement factor"
for i in {6..1..2} 
do
    echo "$i"
done

