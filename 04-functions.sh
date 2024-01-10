#!bin/bash


sample() {
    
    echo "This is ssample function"
    echo " printing the value in sample function: $1"
}
stat() {
    
    echo  "This is stat function"
    sample $1 $2
}

sample 30
stat 40 60