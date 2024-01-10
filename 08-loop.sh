#!/bin/bash


echo "values from i loop :"
for i in {1..5}
do 
   echo "$i"
done

echo "values from j loop :"
for j in 1 2 3
do
    echo "$j"
done

for k in 1,2,3
do
    echo "values from k loop :" 
    echo "$k"
done
