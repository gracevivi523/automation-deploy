#/usr/bin/env bash
set -e

username=`whoami`
groupname=`id -Gn $username | awk '{print $1}'`

# install rvm and ruby for a multi-user
install_rvm_ruby()
{
	echo "****** install rvm start ******"
	curl -sSL https://get.rvm.io | sudo bash -s stable
	# change /usr/local/rvm to to your work user permission
	sudo chown -R $username:$groupname /usr/local/rvm
	# add your username into rvm group
	sudo dseditgroup -o edit -a $username -t user rvm
	test -f /etc/profile.d/rvm.sh && source /etc/profile.d/rvm.sh

        # Load RVM into a shell session *as a function*
        # Loading RVM *as a function* is mandatory
        # so that we can use 'rvm use <specific version>'
        if [[ -s "/$HOME/.rvm/scripts/rvm" ]] ; then
                # First try to load from a user install
                source "$HOME/.rvm/scripts/rvm"
                echo "using user install $HOME/.rvm/scripts/rvm"
        elif [[ -s "/usr/local/rvm/scripts/rvm" ]] ; then
                # Then try to load from a root install
                source "/usr/local/rvm/scripts/rvm"
                echo "using root install /usr/local/rvm/scripts/rvm"
        else
                echo "ERROR: An RVM installation was not found.\n"
                exit 1
        fi
	echo "****** install rvm finish ******\n\n\n"

	echo "****** install ruby 2.2.6 and above start ******"
#	#upgrade ruby to 2.2.6
#	rvm requirements
	rvm=`which rvm`
	$rvm install 2.2.6
	$rvm use 2.2.6 --default
	echo "****** your current ruby version is ******"
	ruby=`which -a ruby  | grep "rvm"`
	$ruby -v
	gem=`which -a gem | grep rvm`
	$gem -v
	echo "****** install ruby 2.2 and above finish ******\n\n\n"
}

install_homebrew_ruby()
{
	echo "****** install homebrew start ******"
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	echo "****** install homebrew finish ******\n\n\n"
	echo "****** install ruby 2.2.6 start ******"
	brew install ruby-build
	brew install rbenv
	rbenv install 2.4.0
	rbenv global 2.4.0
	echo "eval "$(rbenv init -)" >> /etc/profile
	source /etc/profile
	echo "****** install ruby 2.2.6 finish ******"
	echo "****** your current ruby version is:"
	ruby -v
	gem -v
}

install_knife_ec2()
{
	echo "****** install knife-ec2 plugin start ******"
	sudo gem install knife-ec2
	echo "****** install knife-ec2 plugin finish *****\n\n\n"
}

install_chef()
{
	echo "******* install chef start ******"
	curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable
	echo "******* install chef finish ******"
	echo "****** your current chef version is******"
	chef --version
}

#install_rvm_ruby
install_homebrew_ruby
install_chef
install_knife_ec2
