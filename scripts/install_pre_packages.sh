#!/bin/bash

# get work username and group name
#username = `whoami`
#groupname = `id -Gn $username | awk '{print $1}'`

# install rvm for a multi-user
#install_rvm()
#{
#	print "****** install rvm start ******"
#	curl -sSL https://get.rvm.io | sudo bash -s stable
#	print "****** install rvm finish ******"
#	# change /usr/local/rvm to to your work user permission
#	sudo chown -R $username:$groupname /usr/local/rvm
#	source /etc/profile
#}

install_homebrew()
{
	print "install homebrew start ******"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	print "install homebrew finish ******"
}

install_ruby()
{
	print "****** install ruby 2.2 and above start ******"
	brew install ruby-build
	brew install rbenv
	rbenv install 2.4.0
	rbenv global 2.4.0
#	#upgrade ruby to 2.2.6
#	rvm requirements
#	rvm install 2.2.6
#	rvm use 2.2.6 --default
	print "****** install ruby 2.2 and above finish ******"
	print "****** your current ruby version is \n ******"
	ruby -v
	gem -v
}

install_knife-ec2()
{
	print "****** install knife-ec2 plugin start ******"
	sudo gem install knife-ec2
	print "****** install knife-ec2 plugin finish *****"
}

install_chef()
{
	print "******* install chef start ******"
	curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable
	print "******* install chef finish ******"
	print "****** your current chef version is \n ******"
	chef --version
}

install_git()
{
        print "******* install git start ******"
	brew install git
        print "******* install git finish ******"
        print "****** your current chef version is \n ******"
        git --version
}


