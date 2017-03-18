#
# Cookbook:: deploy-simple-sinatra-app
# Recipe:: default
#
# Copyright:: 2017, The Authors,Grace Gao, All Rights Reserved.

# install dependent packages git
yum_package 'git' do
	action :install
end

# checkout git code from github.com under /home/ec2-user
git "/home/ec2-user/simple-sinatra-app/" do
	repository 'https://github.com/rea-cruitment/simple-sinatra-app.git'
	revision 'master'
	action :sync
	user 'ec2-user'
	group 'ec2-user'
end

# redirect port 80 to port 3000
bash 'iptables port redirect' do
        user 'ec2-user'
        code <<-EOH
                sudo /sbin/service iptables stop
                sudo /sbin/service iptables start
                sudo iptables -t nat -A OUTPUT -o lo -p tcp --dport 80 -j REDIRECT --to-port 3000
                sudo iptables -A PREROUTING -t nat -p tcp --dport 80 -j REDIRECT --to-port 3000
		sudo /sbin/service iptables save
                EOH
end

# install bundle and start the service
bash 'start service' do
	user 'ec2-user'
	cwd '/home/ec2-user/simple-sinatra-app/'
	code <<-EOH
		gem install bundle
		bundle install
		bundle exec rackup -p 3000 -o 0.0.0.0
		EOH
end
