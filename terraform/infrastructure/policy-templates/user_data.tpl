#!/bin/sh
sudo mount -t nfs4 -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${efs_mount_dns}:/ /var/www/wordpress
aws ec2 create-tags --region us-east-1 --resources $(curl http://169.254.169.254/latest/meta-data/instance-id) --tags Key=Name,Value=$(curl http://169.254.169.254/latest/meta-data/local-hostname)-$(curl http://169.254.169.254/latest/meta-data/instance-type)

sudo sed -i 's/database_name_here/${rds_database}/g' /var/www/wordpress/wp-config.php
sudo sed -i 's/username_here/${rds_username}/g' /var/www/wordpress/wp-config.php
sudo sed -i 's/localhost/${rds_endpoint}/g' /var/www/wordpress/wp-config.php
sudo sed -i 's/password_here/${rds_password}/g' /var/www/wordpress/wp-config.php
sudo sed -i 's/cache_key_salt/localhost/g' /var/www/wordpress/wp-config.php
sudo sed -i 's/redis_localhost/${redis_endpoint}/g' /var/www/wordpress/wp-config.php
sudo sed -i 's/accessid/${access_id}/g' /var/www/wordpress/wp-config.php
sudo sed -i 's/accesssecret/${access_secret}/g' /var/www/wordpress/wp-config.php