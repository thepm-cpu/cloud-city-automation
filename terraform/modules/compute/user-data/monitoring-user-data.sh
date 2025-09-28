#!/bin/bash
# Basic setup for monitoring server - Ansible will install Prometheus/Grafana
apt-get update
apt-get install -y python3 python3-pip
echo "Monitoring server ready for Ansible configuration"