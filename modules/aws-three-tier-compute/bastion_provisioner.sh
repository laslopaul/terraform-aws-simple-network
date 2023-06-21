#!/bin/bash

# Install Ansible
sudo apt update && \
sudo apt install -y python3-pip unzip && \
sudo pip install ansible boto3 && \

# Install AWS CLI and Session Manager plugin
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
unzip awscliv2.zip && \
sudo ./aws/install && \

curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" \
    -o "session-manager-plugin.deb" && \

sudo yes | dpkg -i session-manager-plugin.deb
