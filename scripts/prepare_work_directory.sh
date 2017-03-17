#!/bin/bash

username = `whoami`

create_workdir()
{
	print "****** create git work directory and download automation git resource ******"
	mkdir -p "/Users/$username/.ssh/"
	sudo chmod 700 /Users/$username/.ssh/
	# download automation git resource
	cd "/Users/$username/" && git clone "vvsvds"

}


copy_credentials_to_dest()
{
	print "****** copy credential files to dest directory on your workstation ******"
	cp -fa /Users/$username/automation-deploy/credentials/knife.pem /Users/$username/.ssh/
	print "****** checking your connection to hosted chef server on api.chef.io:443 ******"
	knife ssl check
}

