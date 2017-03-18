#!/bin/bash

set -e

create_ssh_dir()
{
	echo "****** create .ssh directory for putting your knife.pem file generated in AWS ******"
	echo "****** Your home directory is: " $HOME
	mkdir -p "$HOME/.ssh/"
	sudo chmod 700 $HOME/.ssh/
}

create_aws_config()
{
	mkdir -p $HOME/.aws
	cp -fa $HOME/automation-deploy/.aws/config $HOME/.aws/
}

create_ssh_dir
create_aws_config
