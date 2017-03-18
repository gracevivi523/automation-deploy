utomation-deploy for rea pre-task interview
===================================

Main idea for the automation deployment:
----------------------------------- 
		- Use awscli to create security group, traffic inbound/outbound rules, key pair on AWS console.
		- Use knife-ec2 plugin to automatically launch an EC2 instance with Amazon AMI Linux image.
		- Use chef to make automated-deploy the provided application, here, I use api.chef.io as my hosted chef server, so it saves the trouble and time of making chef server of my own.
		- I already uploaded chef cookbook on chef server, in the cookbook, I do the following things which you can also review in my git repo after you download later.
			o install git, in order to checkout the git code of simple-sinatra-app
			o git checkout simple-sinatra-app
			o set iptables rules, redirect request traffic from port 80 to port 3000
			o start sinatra service, listening on port 3000. (there is a small issue that I can't start this service on port 80 because port is reserved under 1000,so I just use iptables to redirect to port 80)

My working environment:
----------------------------------- 
		- macOS Sierra (version 10.12.3)
		- ruby 2.2.6
		- python 2.7.10
		- chefdk 1.2.22
		- Homebrew 1.1.11
		- knife-ec2 (0.15.0)	
		- aws-cli/1.11.63

Some importants things you need to be done before running scripts：
-----------------------------------
		- Preferred review workstation: macOS
		- Make sure your workstation have access to the Internet.
		- Create an IAM user under your AWS account
			* Go to https://console.aws.amazon.com/iam/home?#/home
			* Click 'Users' in left navigation pane
			* Click button 'Add user' and set user name as "rea"
			* Select both "Access type", leave others as default, click 'Next Permissions', and then click 'Next Review'
			* Click button 'Create user'
			* Save your 'Access key ID' and 'Secret access key' carefully, we'll use these two values later in step 2 below, we shall use them to mamage our Amazon EC2 instance with knife EC2.
			* Add inline policy for user 'rea', select 'Custom Policy', then click 'Select', input 'Policy Name' as "rea-policy", 'Policy Document' should be below,this could allow us to do opreations within EC2. Just copy and paste.
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:*"
            ],
            "Resource": "*"
        }
    ]
}

For now, you will be able to follow on the following steps to start your amazing journey.

1. Pre packages installation

 1).	Please fristly install git on your workstation, move on to 2) if you already have one.
 2).	Make sure your working account has sudo permission. Please add it to /etc/sudoers if not, don't use root as your working account which can be risky;
 3).	Go to your working directory, $HOME, let's say /Users/grace;
 4).	Checkout my git source by using the following command:
	
	$ git clone https://github.com/gracevivi523/automation-deploy.git

	Now, you should see your working directory like this

	$ $HOME/automation-deploy

 5).	Run the following shell script to install pre packages(homebrew, awscli, rbenv, ruby-build, ruby, knife-ec2, chef), this may take a while, depends on your cpu.
	
	$ cd $HOME/automation-deploy/scripts/
	$ sh install_pre_packages.sh
	
2. Set aws access keys and prepare directory

 1).	Export aws access keys to your current session, replace "xxxx" with your generated IAM access keys above.

	$ export AWS_ACCESS_KEY_ID=xxxx
	$ export AWS_SECRET_ACCESS_KEY=xxxx

 2).	Create .ssh directory and copy aws/config to your $HOME/.aws/config

	$ cd $HOME/automation-deploy/scripts/
	$ sh prepare_directory.sh

 3).	Create AWS stuff, security group, key pair.
	
        $ cd $HOME/automation-deploy/scripts/
        $ sh create_aws_stuff.sh

3. Create EC2 instance and deploy the provided application 'simple-sinatra-app'

 1).	Run create_ec2_ins_deploy.sh

	$ cd $HOME/automation-deploy/scripts/
	$ sh create_ec2_ins_deploy.sh

After above, when you see log INFO below, you'll be able to visit it via "http://ip" in your browser, just replace ip with public ipV4 of your newly created ec2 instance, you can find the public ipv4 on the final output when you run this deployment.

	$ [2017-03-18 16:58:42] INFO  WEBrick 1.3.1
	$ [2017-03-18 16:58:42] INFO  ruby 2.3.1 (2016-04-26) [x86_64-linux]
	$ [2017-03-18 16:58:42] INFO  WEBrick::HTTPServer#start: pid=3196 port=3000

Feel free to contact me if you run into any issues.
