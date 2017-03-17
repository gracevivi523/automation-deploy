# automation-deploy
automation-deploy for rea interview

Main idea for the automation deployment:
	- Use knife-ec2 plugin to automatically launch an EC2 instance embeded an Amazon AMI Linux image.
	- Use chef to make automated-deploy the provided application, here, I used api.chef.io as my hosted chef server, so it saves the trouble making chef server.
	- I already uploaded chef cookbook in chef server, in the cookbook, I did the following things which you can also review in my git repo after you download later.
		o install git, in order to checkout the git code of simple-sinatra-app
		o git checkout simple-sinatra-app
		o set iptables rules, redirect traffic from port 80 to port 3000
		o start sinatra service, listening on port 3000. (there is a small issue that I can't start it on port 80 because port is reserved under 1000,so I just use iptables to redirect to port 8o)

My working environment:
	- macOS Sierra (version 10.12.3)

Some important notes before you run the scripts:
	- Preferred review workstation: macOS
	- Make sure your workstation have access to the Internet.
	- Please subsititute your own working username for $username used in the following steps.for example, mine is "/Users/grace"
	- I already get the following things done for authentification for chef server and AWS, so you dont have to do anything for authetificaiton for chef server or AWS.
		o user.gem was created for connecting to chef server.
		o a new user named 'knife' was created in AWS and knife.pem stored.
		o knife.rb has been created for you to connect to hosted chef server.
		o aws access and secret access key has been created and stored.
	
For now, you will be able to follow on the following steps to start your amazing journey.

1. Installation

 1).	Please install git on your workstation firstly, move on to 2) if you already have one.
 2).	Make sure your working account has sudo permission. Please add it to /etc/sudoers if not, don't use root as your working account which is not safe;
 3).	Go to your working directory, $HOME, let's say /Users/grace;
 4).	Checkout my git source by using the following command:
	
	$ git clone https://github.com/gracevivi523/automation-deploy.git

	Now, you should see your working directory like this
	$ $HOME/automation-deploy

 5).	Run the following shell script to install pre packages:
	
	$ cd /Users/$username/automation-deploy
	$ sh install_pre_packages.sh
	
	This installation may take a while, and this script will install packages below:
		- homebrew, rbenv, ruby-build, ruby, knife-ec2, chef

2. Prepare work directory and credentials for aws and chef server

 1).	Run the following shell script to copy credentials to dest on your workstation

	$ cd /Users/$username/automation-deploy/scripts/
	$ sh prepare_work_directory.sh
	
3. Create EC2 instance and deploy the provided application 'simple-sinatra-app'
 1).	Run create_ec2_instance.sh
	$ cd /User/$username/automation-deploy/scripts/
	$ sh create_ec2_instance.sh

For now, you'll be able to visit it "http://ip" in your browser, here, replace ip with public ipV4 of created ec2 instance, you can find the public ipv4 on the output when you run this deployment.

Feel free to contact me if you run into any issues.
