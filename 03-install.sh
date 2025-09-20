#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
    then
        echo "ERROR:: Please run this scriprt with root user"
        exit 1
    else
    echo "You are running with root user"
fi
