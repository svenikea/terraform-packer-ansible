#!/bin/sh
sudo mkdir -p /var/www/wordpress
sudo mount -t nfs4 -o nfsvers=4.1 ${efs_mount_dns}:/ /var/www/wordpress
if find /var/www/wordpress -mindepth 1 -maxdepth 1 | read; then
   echo "dir not empty"
else
   cp -r /wordpress/* /var/www/wordpress
   sudo sed -i 's/database_name_here/${rds_database}/g' /var/www/wordpress/wp-config.php
   sudo sed -i 's/username_here/${rds_username}/g' /var/www/wordpress/wp-config.php
   sudo sed -i 's/db_endpoint/${rds_endpoint}/g' /var/www/wordpress/wp-config.php
   sudo sed -i 's/password_here/${rds_password}/g' /var/www/wordpress/wp-config.php
   sudo sed -i 's/cache_key_salt/localhost/g' /var/www/wordpress/wp-config.php
   sudo sed -i 's/redis_endpoint/${redis_endpoint}/g' /var/www/wordpress/wp-config.php
   sudo sed -i 's/site_url/${site_url}/g' /var/www/wordpress/wp-config.php
   sudo chown www-data:www-data -R /var/www/wordpress/wp-content/
   sudo chown www-data:www-data /var/www/wordpress/
fi
aws ec2 create-tags --region us-east-1 --resources $(curl http://169.254.169.254/latest/meta-data/instance-id) --tags Key=Name,Value=$(curl http://169.254.169.254/latest/meta-data/local-hostname)-$(curl http://169.254.169.254/latest/meta-data/instance-type)
