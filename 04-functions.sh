#!bin/bash

a=10
b=30
$1
sample() {
    echo "Welcome to shell/bash scripting"
}
stat() {
    echo $a
    echo ${b}
    echo "$1"
    sample    
}


stat