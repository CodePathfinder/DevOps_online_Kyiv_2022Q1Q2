#!/bin/bash

# extract last command parameter expected to be LOG_FILE
LOG_FILE=$(echo $@ | awk '{print $NF}')
# if last parameter starts with '-': LOG_FILE=""
if [[ -z $(echo ${LOG_FILE##-*}) ]]; then LOG_FILE=""; fi

# FUNCTIONS DECLARATION
# help function
function gethelp {
    echo -e "\nUSAGE: $0 OPTION[S] LOGFILE"
    echo -e "\nOPTIONS (at least one option should be selected):"
    echo -e "\t-a : to check from which ip [a]ddress were the most requests;"
    echo -e "\t-r : to see how many [r]equests were there from each ip;"
    echo -e "\t-p : to analize what is the most requested [p]age;"
    echo -e "\t-n : to discover what [n]on-existent pages were clients referred to;"
    echo -e "\t-t : to find out what [t]ime did site get the most requests;"
    echo -e "\t-b : to investigate what search [b]ots have accessed the site;"
    echo -e "\nLOG_FILE format shall be consistent with Common Log Format or Combined Log Format."
    echo -e "\nTO GET HELP ENTER: $0 -h\n"
}

# checks from which ip address were the most requests
function address {
    awk '{print $1}' $LOG_FILE |sort|uniq -c|sort -nr|head -n 1|\
    awk '{print "\nMOST REQUESTS ("$1") CAME FROM IP ADDRESS: "$2}'
    # echo $max_req) CAME FROM IP ADDRESS: $max_req_ip"
}

# counts how many requests were there from each ip address
function requests {
    echo -e "\nREQUESTS STATISTICS PER IP ADDERESSES:\n"
    echo -e "   IP Address \t  | Requests"
    echo "------------------|----------"
    awk '{print $1}' $LOG_FILE |sort|uniq -c|sort -nr|\
    awk '{print $2"\t  |   "$1}'
}
# analizes what is the most requested page
function page {
    awk '{print $7}' $LOG_FILE | sort|uniq -c|sort -nr|head -n 1| \
    awk '{print "\nMOST REQUESTED PAGE: "$2" ("$1" TIMES)"}'
}

# discovers what non-existent pages were clients referred to
function non_existed {
    echo -e "\nNON_EXISTED PAGES REQUESTED BY CLIENTS (code 404):"
    NE_PAGES=$(awk '$9 ~ /404/{print $7}' $LOG_FILE |sort|uniq)
    echo -e "\n${NE_PAGES:-NO ENTRIES}" # NE_PAGES is empty prints NO ENTRIES
}

# finds out what time did site get the most requests
function time_pick {
    awk '{print $4}' $LOG_FILE|\
    awk 'BEGIN{FS=":"}{print $2":"$3}'| uniq -c|sort -nr|head -n1|\
    awk '{print "\nMOST REQUESTS ("$1") CAME AT "$2}'
}

# investigates what search bots have accessed the site
function bots {
    echo -e "\nLIST OF SEARCH BOTS:\n"
    awk '{for(i=12;i<=NF;i++) printf $i" "; print ""}' $LOG_FILE |\
    grep bot|sort|uniq
}

# CHECK INPUT PARAMETERS
if [[ $1 == "-h" ]] # Check for help request
then
	gethelp
elif [[ -z "$LOG_FILE" ]] # Check that LOG_FILE name is provided
then
	echo -e "\n[ERROR] LOGFILE NAME IS NOT PRIVIDED."
	echo "USAGE: $0 [-arpntb] LOGFILE"
    echo -e "TO GET HELP ENTER: $0 -h\n"
    exit 1
elif [[ ! -s "$LOG_FILE" ]] # Check that LOG_FILE exists and has a size greater than zero
then
    echo -e "\n[ERROR] FILE $LOG_FILE DOES NOT EXIST OR IS EMPTY."
    echo "USAGE: $0 [-arpntb] LOGFILE"
    echo -e "TO GET HELP ENTER: $0 -h\n"
    exit 2
elif [[ $(awk '$1 !~ /^([0-9]{1,3}\.){3}[0-9]{1,3}/ {print $1}' $LOG_FILE | wc -l) != 0 ]] # Check that LOG_FILE is properly formated 
then
    echo -e "\n[ERROR] INCONSISTENT LOG FILE FORMAT"
    echo -e "TO GET HELP ENTER: $0 -h\n"
    exit 3
# PROCESS LOG DATA DEPENDING ON SELECTED OPTION
else
    while getopts ":arpntb" option;
    do
        case $option in
        a)
            address ;;
        r)
            requests ;;
        p)
            page ;;
        n)
            non_existed ;;
        t)
            time_pick ;;
        b)
            bots ;;
        *)
            echo -e "\n[ERROR] INVALID OPTION -$OPTARG"; gethelp; exit 4 ;;
        esac
    done
    echo
fi
