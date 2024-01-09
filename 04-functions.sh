#!bin/bash

a=10
b=30
$3
sample() {
    echo "Welcome to shell/bash scripting"
}
stat() {
    echo $a
    echo ${b}
    echo "$3"
    sample    
}


stat