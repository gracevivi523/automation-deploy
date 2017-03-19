#!/bin/bash

echo "****** start to initial an EC2 Intance with knife-ec2 ******"
echo "****** deploy provided application (simple-sinatra-app) from chef server ******"
knife ec2 server create -r 'deploy-simple-sinatra-app' -S rea_code_key --ssh-user ec2-user
