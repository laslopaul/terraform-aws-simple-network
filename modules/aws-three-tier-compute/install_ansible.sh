#!/bin/bash

sudo apt update && \
sudo apt install -y python3-pip && \
sudo pip install ansible boto3

# Copy Ansible playbook files
cd /home/ubuntu
git clone --depth 1 --branch stage6 --no-checkout https://github.com/laslopaul/terraform-aws-three-tier-arch.git
cd terraform-aws*
git sparse-checkout set ansible
git checkout stage6
