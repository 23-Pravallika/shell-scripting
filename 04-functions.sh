#!bin/bash

a=10
b=30


sample() {
    echo "Welcome to shell/bash scripting"
    echo "Hello, $1 and $2"
}
stat() {
    
    echo  $1
    #sample
       
}

sample "$1" "$2"