#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR:: Please run this script with root user $N"
    exit 1
else
    echo "You are running with root user"
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "installing $2 is...$G SUCCESSFUL $N"
    else
        echo -e "installing $2 is...$R FAILURE $N"
        exit 1
    fi
}

dnf list installed mysql
if [ $? -ne o ]
then
    echo "mysql is not installed...going to insatll"
    dnf install mysql -y
    VALIDATE $? "mysql"
else
    echo -e "Nothing to do mysql... $Y already installed $N"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then
    echo "nginx is not installed going to install"
    dnf install nginx -y
    VALIDATE $? "nginx"
else
    echo -e "Nothing to do nginx... $Y already installed $N"
fi

dnf list installed python3
if [ $? -ne 0 ]
then 
    echo "python3 is not installed, going to install"
    dnf install python3 -y
    VALIDATE $? "python3"
else
    echo -e "Nothing to do python3... $Y already installed $N"
fi