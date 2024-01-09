#!bin/bash

a=10
b=30


sample() {
    echo "Welcome to shell/bash scripting"
    
}
stat() {
    
    sample "$3" "$4"
    echo  "This is stat function"
    echo $a
    echo "$b"
    
       
}

stat