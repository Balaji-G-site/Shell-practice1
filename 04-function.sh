#!/bin/bash

USERID=$(id -u)

if $USERID [ -ne 0 ]
then
    echo " ERROR::Please run this script with root user"
    exit 1
else
    echo " You are running with root user"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo "installing $2 is...SUCCESSFUL"
    else
        echo "installing $2 is...FAILURE"
        exit 1
    fi
}

dnf list installed mysql
if [ $? -ne 0]
then
    echo "Mysql is not installed...going to install"
    dnf install mysql
    VALIDATE $? "Mysql"
else
    echo "Mysql is already installed...nothing to do"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then 
    echo "nginx is not installed...going to install"
    dnf install nginx
    VALIDATE $? "nginx"
else
    echo "nginx is already installed...nothing to do"
fi

dnf list installed python3
if [ $? -ne 0 ]
then 
    echo "Python3 not installed...going to install"
    dnf install python3
    VALIDATE $? "python3"
else
    echo " Python3 is already installed...nothing to do"
fi


