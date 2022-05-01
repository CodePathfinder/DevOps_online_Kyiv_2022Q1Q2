#! /bin/bash
# This script is run by crontab with an established frequency (one minute)
# The script loads paths to the syncing directory and the backup directory from the configutation file
# It identifies the uniq list of files located in both the syncing directory and backup directory and itereates over this list: 
# - if file in the list is in the syncing directory only, it is added to the backup directory
# - if file in the list is in the backup directory only, it is removed from the backup directory
# - if file in the list is in both directories, it is copied/updated if file in syncing directory is newer than the eponymous file in the backup directory
# In case of successful adding, updating or deleting files in the backup directory, respective records are added to the logfile kept by default in user's home directory

# import variables from the configuration file config.txt
source $HOME/config.txt 2>/dev/null

LOGFILE=$HOME/logfile.txt

# initialize counters
((UPDATE_COUNT=0))
((ADD_COUNT=0))
((DEL_COUNT=0))

# check that the syncing directory and the backup directory exists in filesystem
if [[ ! -d $SYNC_DIRECTORY || ! -d $BACKUP_DIRECTORY ]]
then 
    echo "[ERROR]: FAILED TO FOUND PATH TO SYNC_DIRECTORY AND/OR BACKUP_DIRECTORY"
    echo "RUN ./config.sh to set configurations"
	exit 1
fi

echo -e "\nSYNC_DIRECTORY=${SYNC_DIRECTORY}"
echo "BACKUP_DIRECTORY=${BACKUP_DIRECTORY}"
echo -e "\n[INFO]: SYNCRONIZATION STARTED ...\n"

# get list of files located at the syncing directory
SYNC_FILES=$(ls $SYNC_DIRECTORY)
BACKUP_FILES=$(ls $BACKUP_DIRECTORY)

# get the shortlist of files which are not located in both directories
declare -a UNIQ_FILES=$(echo -e "$SYNC_FILES"\\n"$BACKUP_FILES" | sort | uniq) #| awk '$1==1 {print $2}')

# iterate over the DIF_FILES to differenciate between the new files and old files
for i in ${UNIQ_FILES[@]}
do
	if [[ $(echo "${SYNC_FILES}" | grep -w ${i}) ]] # file is found in the syncing directory
	then 
		if [[ $(echo "${BACKUP_FILES}" | grep -w ${i}) ]] # file is found in the backup directory
		then 
			diff "$SYNC_DIRECTORY/$i" "$BACKUP_DIRECTORY/$i" > /dev/null; CODE=$?
			if [[ $CODE > "0" ]] # true if there are differencies in two files
			then	
			    # copy file to the backup directory provided the source file is newer than the destination file
				cp -u $SYNC_DIRECTORY/$i $BACKUP_DIRECTORY/$i; EC=$?
				if [[ $EC > "0" ]] # error with copying file to the backup directory
				then
					echo -e "[ERROR]: failure to add file ${i} to ${BACKUP_DIRECTORY}"
				else               
					# check if the differencies eliminated (file is updated with its newer version)
					diff "$SYNC_DIRECTORY/$i" "$BACKUP_DIRECTORY/$i" > /dev/null; CODE=$?
					if [ $CODE = 0 ] # if updated successfully, add record to the logfile
					then
						echo -e "$(date +"%Y-%m-%d %H:%M:%S") ${i} updated in ${BACKUP_DIRECTORY}" >> $LOGFILE
						((UPDATE_COUNT++))
					fi
				fi
			fi
		else	# file is found in the backup directory; add new file thereto
			cp "$SYNC_DIRECTORY/$i" $BACKUP_DIRECTORY; EC=$?
			if [ $EC = 0 ] # if added successfully, add record to the logfile
			then		
				echo -e "$(date +"%Y-%m-%d %H:%M:%S") ${i} added to ${BACKUP_DIRECTORY}" >> $LOGFILE
				((ADD_COUNT++))
			else
				echo -e "[ERROR]: failure to add file ${i} to ${BACKUP_DIRECTORY}"
			fi
		fi
	else     # file is not found in the syncing directory (old file), delete it from the backup directory
		rm -f "$BACKUP_DIRECTORY/$i"; EC=$?          
		if [ $EC = 0 ] # if deleted successfully, add record to the logfile
		then     
			echo -e "$(date +"%Y-%m-%d %H:%M:%S") ${i} removed from ${BACKUP_DIRECTORY}" >> $LOGFILE
			((DEL_COUNT++))
		else
			echo -e "[ERROR]: failure to remove file ${i} from ${BACKUP_DIRECTORY}"
		fi
	fi
done

echo -e "[INFO]: SYNCRONIZATION COMPLETED\n"
echo -e "$ADD_COUNT files added, $UPDATE_COUNT files updated, $DEL_COUNT files deleted.\n"
echo -e "TO REVIEW LOGFILE ENTER: cat $HOME/logfile.txt\n"
