#!/bin/bash
PS3='Select a option: '
cd ~/
options=("SSH Session" "Server Update" "Push LP Module" "Pull LP Module" "SCP Upload File" "Quit")
select opt in "${options[@]}"
do
    case $opt in
	"SSH Session")
	    echo $opt
	    ./sshsession.ex
	    ;;
        "Server Update")
            echo $opt
            ./upgradeserver.ex
	    ;;
        "Push LP Module")
            echo $opt
            ./pushlpmodule.ex
            ;;
        "Pull LP Module")
            echo $opt
	    ./pulllpmodule.ex
            ;;
	"SCP Upload File")
            echo $opt
            ./scpfileup.ex
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
