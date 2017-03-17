# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

# parameters for chef
current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "gracegao"
client_key               "#{current_dir}/gracegao.pem"
chef_server_url          "https://api.chef.io/organizations/melbourne"
cookbook_path            ["#{current_dir}/../cookbooks"]


# parameters for knife with aws
knife[:aws_access_key_id]	= "AKIAIAETGQW3YSERX3PA"
knife[:aws_secret_access_key]	= "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"
knife[:region] 			= "ap-southeast-2"
knife[:availability_zone]	= "ap-southeast-2a"
knife[:image]			= "ami-1c47407f"
knife[:flavor]			= "t2.micro"
knife[:identity_file] 		= "/Users/grace/.ssh/knife.pem"
