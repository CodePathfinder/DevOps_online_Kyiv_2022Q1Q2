#!/bin/bash

SYNC_DIRECTORY=$1
BACKUP_DIRECTORY=$2

help_function () {
    echo -e "\nUSAGE: $0 SYNC_DIRECTORY BACKUP_DIRECTORY"
    echo -e "\t SYNC_DIRECTORY:  path to the syncing directory"
    echo -e "\t BACKUP_DIRECTORY: path to the directory where the copies of the files will be stored"
    echo -e "Both SYNC_DIRECTORY and BACKUP_DIRECTORY parameters are mandatory. Order of the parameteres matters\n"
}

# check that both parameters are provided
if [ ! $# = 2 ]
then 
    echo "PLASE ADD THE PARAMETERS"
    help_function
    exit 1
# check if SYNC_DIRECTORY exists 
elif [ ! -d $SYNC_DIRECTORY ]  
then 
    echo "SYNC_DIRECTORY path not found"
    help_function
    exit 2
# check if BACKUP_DIRECTORY exists 
elif [ ! -d $BACKUP_DIRECTORY ]
then
    echo -e "\nBACKUP DIRECTORY path not found"
    read -p "Create BACKUP DIRECTORY now: Y/n? " REPLY
    REPLY=$(echo ${REPLY} | tr [A-Z] [a-z] )
    if [[ ${REPLY} -eq "y" ]]
    then
        mkdir -p $BACKUP_DIRECTORY; EC=$?
        if [ $EC = 0 ]
        then
            ABS_PATH=$(cd $BACKUP_DIRECTORY; pwd) # get absolute path
            echo -e "\nBACKUP DIRECTORY $ABS_PATH is created\n"
        else
            echo "[ERROR]: Failure to create BACKUP DIRECTORY"
            exit 3
        fi
    else
        exit 4
    fi
fi

# save new configurations in configuration file 
echo -e "TIMEDATE=$(date +"%Y-%m-%d %H:%M:%S")\nSYNC_DIRECTORY=$(cd $SYNC_DIRECTORY; pwd)\nBACKUP_DIRECTORY=${ABS_PATH}" > $HOME/config.txt
