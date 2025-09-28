#!/usr/bin/env python3
# AWS EC2 dynamic inventory script
import os
import sys
import boto3
import json

class EC2Inventory:
    def __init__(self):
        self.inventory = {
            'app_servers': {
                'hosts': [],
                'vars': {
                    'ansible_user': 'ubuntu',
                    'ansible_ssh_private_key_file': '~/.ssh/devops-key.pem'
                }
            },
            'monitoring_servers': {
                'hosts': [],
                'vars': {
                    'ansible_user': 'ubuntu', 
                    'ansible_ssh_private_key_file': '~/.ssh/devops-key.pem'
                }
            },
            '_meta': {
                'hostvars': {}
            }
        }
        
    def get_instances(self):
        ec2 = boto3.resource('ec2', region_name='eu-north-1')
        
        filters = [{
            'Name': 'tag:Project',
            'Values': ['cloud-city-automation']
        }]
        
        for instance in ec2.instances.filter(Filters=filters):
            if instance.state['Name'] != 'running':
                continue
                
            if instance.public_ip_address:
                tags = {tag['Key']: tag['Value'] for tag in instance.tags or []}
                
                if tags.get('Role') == 'app':
                    self.inventory['app_servers']['hosts'].append(instance.public_ip_address)
                    self.inventory['_meta']['hostvars'][instance.public_ip_address] = {
                        'ansible_user': 'ubuntu',
                        'instance_id': instance.id,
                        'tags': tags
                    }
                elif tags.get('Role') == 'monitoring':
                    self.inventory['monitoring_servers']['hosts'].append(instance.public_ip_address)
                    self.inventory['_meta']['hostvars'][instance.public_ip_address] = {
                        'ansible_user': 'ubuntu',
                        'instance_id': instance.id,
                        'tags': tags
                    }

if __name__ == '__main__':
    inventory = EC2Inventory()
    inventory.get_instances()
    print(json.dumps(inventory.inventory, indent=2))