#!bin/bash

a=10
b=30


sample() {
    echo "Welcome to shell/bash scripting"
    
}
stat() {
    
    echo  "This is stat function"
    echo $a
    echo "$b"
    sample "$3" "$4"
       
}

stat