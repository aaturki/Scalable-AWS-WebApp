#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EC2_AZ=$(curl -s [http://169.254.169.254/latest/meta-data/placement/availability-zone](http://169.254.169.254/latest/meta-data/placement/availability-zone))
INSTANCE_ID=$(curl -s [http://169.254.169.254/latest/meta-data/instance-id](http://169.254.169.254/latest/meta-data/instance-id))
echo "<h1>Success! Your Web App is running on Instance: $INSTANCE_ID in Availability Zone: $EC2_AZ</h1>" > /var/www/html/index.html
