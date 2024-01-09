#!bin/bash

a=10
b=30

sample() {
    echo "Welcome to shell/bash scripting"
}
stat() {
    
    echo "$1"
    echo  $a
    echo  ${b}
    sample    
}

stat
stat