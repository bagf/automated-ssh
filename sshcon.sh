#!/bin/bash
# Setting for the new UTF-8 terminal support in Lion
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

PS3='Select a SSH server: '
cd ~/
options=("Server 1" "Server 2" "Quit")
export R_PORT="22"
select opt in "${options[@]}"
do
    case $opt in
        "Server 1")
            echo $opt
            export R_HOST="ssh.myserver.com"
	    export R_USER="user"
	    export R_PORT="9995"
	    ;;
	"Server 2")
            echo $opt
            export R_HOST="10.8.0.118"
            export R_USER="user"
            ;;
    	"Quit")
            break
            ;;
        *) echo invalid option;;
    esac
    if [ -z "$VAR" ] 
	then
		stty -echo
            	read -p "password: " R_PASS
            	stty echo
            	printf '\n'
            	export R_PASS
    fi
    ./conactions.sh 
    unset R_HOST
    unset R_USER
    unset R_PASS
done
