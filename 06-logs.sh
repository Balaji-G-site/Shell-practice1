#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER
echo "script start executed at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]
then
    echo -e "$R ERROR: Please run this script with root user $N" | tee -a $LOG_FILE
    exit 1
else
    echo "You are running with root access" | tee -a $LOG_FILE
fi

VALIDATE () {
    if [ $1 -eq 0 ]
    then
        echo -e "installing $2 is...$G SUCCESSFUL $N" | tee -a $LOG_FILE
    else
        echo -e "installing $2 is...$R FAILURE $N" | tee -a $LOG_FILE
        exit 1
    fi
}

dnf list installed mysql
if [ $? -ne 0 ]
then
    echo "mysql is not installed...going to install" | tee -a $LOG_FILE
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "mysql"
else
    echo -e "nothing to do mysql...$Y already installed $N" | tee -a $LOG_FILE
fi

dnf list installed nginx
if [ $? -ne 0 ]
then 
    echo "nginx is not installed...going to install" | tee -a $LOG_FILE
    dnf install nginx -y &>>LOG_FILE
    VALIDATE $? "nginx"
else
    echo -e "nothing to nginx...$Y already installed $N" | tee -a $LOG_FILE
fi

dnf list installed python3
if [ $? -ne 0 ]
then
    echo "python3 is not installed...going to install" | tee -a $LOG_FILE
    dnf install python3 -y &>>$LOG_FILE
    VALIDATE $? "python3"
else
    echo -e "nothing to do python3...$Y already installed $N" | tee -a $LOG_FILE
fi