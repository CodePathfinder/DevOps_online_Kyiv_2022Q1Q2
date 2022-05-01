#!/bin/bash

# FUNCTIONS DECLARATION
help_function () {
    echo -e "\nUSAGE: $0 [PARAMETER]"
    echo -e "\nPARAMETERS:\n"
    echo -e "\t--all : to display the IP addresses and symbolic names of all hosts in the current subnet(s)"
    echo -e "\t--target : to display a list of open system TCP ports\n"
}

# checks available subnet(s) and display the IP addresses and symbolic names for each one
subnet () {

    SUBNETS=$(ip -4 neigh | awk '{print $1}' | awk -F'.' '{print $1"."$2"."$3".*"}' | sort | uniq)

    for IP in "${SUBNETS[@]}"
    do
        echo -e "\nIP addresses and symbolic names of hosts for subnet $IP:\n"
        nmap -sP ${IP} | awk 'NF==6 {printf("%-18s=>  %s\n", $6, $5)}'
    done
    echo
}

# displays the list of open system TCP ports
tcp_ports () {
    echo -e "\nList of open system TCP ports:\n"
    netstat -tlpn 2> /dev/null | awk '$6 ~ /LISTEN/{print $4}' |\
    awk -F':' '{print $NF}' | sort | uniq | \
    awk '{print "TCP port "$1" is open"}'
    echo
}

if [ "$#" -gt "1" ]; then
    echo -e "\nThis script accepts only one parameter."
    help_function
    exit 1

elif [ "$1" == "--all" ]; then
    subnet

elif [ "$1" == "--target" ]; then
    tcp_ports

else
    help_function
fi
