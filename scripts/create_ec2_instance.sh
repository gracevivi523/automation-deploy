#!/bin/bash

knife ec2 server create -r 'deploy-simple-sinatra-app' -S knife --ssh-user ec2-user
