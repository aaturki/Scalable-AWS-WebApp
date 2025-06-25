{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 #!/bin/bash\
yum update -y\
yum install -y httpd\
systemctl start httpd\
systemctl enable httpd\
EC2_AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)\
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)\
echo "<h1>Success! Your Web App is running on Instance: $INSTANCE_ID in Availability Zone: $EC2_AZ</h1>" > /var/www/html/index.html}