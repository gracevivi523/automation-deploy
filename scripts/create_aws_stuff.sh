#!/bin/bash

set -e

# create security-group
group_id=`aws ec2 create-security-group --group-name rea-code-sg --description "security group for application in EC2"`
echo "****** created security group is: ${group_id}"

# set inbound traffic 
aws ec2 authorize-security-group-ingress --group-id ${group_id} --protocol tcp --port 22 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id ${group_id} --protocol tcp --port 80 --cidr 0.0.0.0/0
echo "****** http and ssh traffic set in inbound of ${group_id} ******"

# create key pair
[[ -e $HOME/.ssh/rea_code_key.pem ]] && rm -f $HOME/.ssh/rea_code_key.pem
aws ec2 create-key-pair --key-name rea_code_key --query 'KeyMaterial' --output text > $HOME/.ssh/rea_code_key.pem
sudo chmod 400 $HOME/.ssh/rea_code_key.pem
echo "****** key pair was created and save to $HOME/.ssh/rea_code_key.pem ******"
