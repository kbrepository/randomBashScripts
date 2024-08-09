#!/bin/bash

# Define the log file path
LOG_FILE="/var/log/user_data_output.log"

# Update and install Docker, saving output and errors to the log file
{
    yum update -y
    amazon-linux-extras install docker -y
    service docker start
    systemctl enable docker
    usermod -a -G docker ec2-user

    ## Install docker compose 
    sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    docker-compose version
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
} &> "$LOG_FILE"


