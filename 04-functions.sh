#!bin/bash

a=10
b=30


sample() {
    echo "Welcome to shell/bash scripting"
    echo ${a}
    echo $b
}
stat() {
    
    echo  "This is stat function"
    #sample
       
}

sample "$3" "$4"
stat