#!/bin/bash
source /etc/os-release 

if [[ $ID == "ubuntu" ]]; then
    sudo python3 -m pip uninstall ansible ansible-core -y
    sudo apt remove --autoremove --purge python3-pip git -y
elif [[ $ID == "amzn" ]]; then
    sudo python3 -m pip uninstall ansible ansible-core -y
    sudo yum remove python3-pip telnet git -y
fi