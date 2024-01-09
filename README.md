# shell-scripting
Repo for shell scripting

This repo is created to practice linux basics 
* This is created to pratice Linux bash
* Automate the configuration  

This is to demonstrate PAT
* This is to show the demo 

Bash Scripting Agenda
 Follwoing are the shell scripting topics which we discuss as a part of our project

1. SheBang Notation and Comments
2. Printing
3. Variables
    - Local Variables.
    - Environment Variables.
    - Command Substitution.
4. Inputs
    - Special Variables
    - Prompts
5. Functions
6. Redirectors & Quotes & Exit status 
7. Conditions
8. Loops
9. Basis of SED Command
10. Commands

Output :


    1) Standard Output ( > or 1> )
    2) Standard Error ( 2> or 2>> ) 
    3) Both Standard Output & Error ( &> or &>> )

Redirectors:
  >   : Standard Output to a file : ( This will override the existing content on the file : > = 1> )
>>  : Standard Output to a file : ( But, this will not override, just appends on the top of the file )

2>  : Standard Error to a file  

&>  : Redirects both standard output and standard error
&>> : Redirects both standard output and standard error, but appends on the top of the exiting content.

<   : This is to read something from a file and do an action


Exit Status : Every command that you execute will return some status code and based on that code we can decide whether the command is success / failure /partially completed and the command to see the exit code of the previous command is $?


In Linux, exit codes range from 0 to 255.

0      : Exit Code means, command completed successfully
1-255  : Either partially completed or failed 


Conditions:1. Simple If
2. If Else 
3. Else If

Simple If
    if [ expression ]; then
        command1
        command2
        command3
    fi 
    
If expression is true then it executes the commands
NOTE: If the expression is false, then it will not perform any thing
   
  