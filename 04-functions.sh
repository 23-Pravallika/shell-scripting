#!bin/bash

a=10
b=30


sample() {
    echo "Welcome to shell/bash scripting"
    echo $1
}
stat() {
    
    echo  "This is stat function"
   # echo $a
   # echo "$b"
    #sample
       sample "$1" "$2"
}

sample 30
stat 40 60