#!bin/bash


sample() {
    
    echo "This is sample function"
    echo "printing the value in sample function: "
}
stat() {
    
    echo  "This is stat function"
    sample $1,$2
}

stat 40 60