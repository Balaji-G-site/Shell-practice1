#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
    then
        echo "ERROR:: Please run this scriprt with root user"
        exit 1
    else
    echo "You are running with root user"
fi

dnf list installed mysql

if [ $? -ne 0 ]
    then
        echo "Mysql is going to...install"
        
        dnf install Mysql
        if [ $? -eq 0 ]
        then
            echo "Mysql installing...Successful"
        else
            echo "Mysql installing...Failure"
            exit 1
        fi
    else
        echo "Mysql is already installed...nothing to do"
    fi
