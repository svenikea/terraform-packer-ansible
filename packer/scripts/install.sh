#!/bin/bash
source /etc/os-release 

if [[ $ID == "amzn" ]]; then
    sudo yum update -y
    sudo yum install python3-pip telnet git -y
    sudo python3 -m pip install ansible ansible-core
    git clone https://github.com/svenikea/Ansible-LEMP-Stack.git
elif [[ $ID == "ubuntu" ]]; then
    sudo apt update
    sudo apt upgrade -y
    sudo apt install apt-utils -y
    sudo apt install python3-pip git -y
    sudo python3 -m pip install ansible ansible-core
fi
