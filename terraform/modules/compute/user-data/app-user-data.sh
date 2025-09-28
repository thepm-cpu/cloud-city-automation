#!/bin/bash
# Basic setup for app server - Ansible will do the real configuration
apt-get update
apt-get install -y python3 python3-pip
echo "App server ready for Ansible configuration"
