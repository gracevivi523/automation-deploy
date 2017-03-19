#/usr/bin/env bash

#set -e

install_homebrew_ruby()
{
	echo "****** install homebrew start ******"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	echo "****** install homebrew finish ******\n\n\n"
	ruby=`which -a ruby | head -n1`
	ruby_version=`$ruby -v | grep "ruby 2.2"`
	if [[ $? -ne 0 ]] ; then
		
		echo "****** There is no ruby 2.2. installed, now start to install ruby 2.2.6 ******"
		brew install ruby-build
		brew install rbenv
		rbenv install 2.2.6
		rbenv global 2.2.6
		echo 'eval "$(rbenv init -)"' | sudo tee -a /etc/profile > /dev/null
		. /etc/profile
		echo "****** ruby 2.2.6 installed ******\n\n\n"
	else
		echo "****** ${ruby_version} has already existed on this machine ******"
	fi
}

install_awscli()
{
	brew install python
        brew install awscli
}

install_knife_ec2()
{
	echo "****** your current ruby version is:" `$ruby -v`;
	echo "\n\n\n****** install knife-ec2 plugin start ******"
	sudo gem install knife-ec2
	echo "****** install knife-ec2 plugin finish *****\n\n\n"
}

install_chef()
{
	echo "****** install chef start ******"
	curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable
	echo "****** install chef finish ******"
	echo "****** your current chef version is ******"
	chef --version
}

install_homebrew_ruby
install_awscli
install_chef
install_knife_ec2
