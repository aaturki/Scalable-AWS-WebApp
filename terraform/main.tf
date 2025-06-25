{\rtf1\ansi\ansicpg1252\cocoartf2822
\cocoatextscaling0\cocoaplatform0{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww11520\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 # Configure the AWS Provider\
provider "aws" \{\
  region = var.aws_region\
\}\
\
# 1. Create the VPC\
resource "aws_vpc" "main" \{\
  cidr_block = "10.0.0.0/16"\
  tags = \{\
    Name = "Project-VPC"\
  \}\
\}\
\
# 2. Create Public Subnets for the Load Balancer\
resource "aws_subnet" "public_a" \{\
  vpc_id            = aws_vpc.main.id\
  cidr_block        = "10.0.1.0/24"\
  availability_zone = "$\{var.aws_region\}a"\
  map_public_ip_on_launch = true\
  tags = \{\
    Name = "Public-Subnet-A"\
  \}\
\}\
\
resource "aws_subnet" "public_b" \{\
  vpc_id            = aws_vpc.main.id\
  cidr_block        = "10.0.2.0/24"\
  availability_zone = "$\{var.aws_region\}b"\
  map_public_ip_on_launch = true\
  tags = \{\
    Name = "Public-Subnet-B"\
  \}\
\}\
\
# 3. Create Private Subnets for EC2 Instances\
resource "aws_subnet" "private_a" \{\
  vpc_id            = aws_vpc.main.id\
  cidr_block        = "10.0.101.0/24"\
  availability_zone = "$\{var.aws_region\}a"\
  tags = \{\
    Name = "Private-Subnet-A"\
  \}\
\}\
\
resource "aws_subnet" "private_b" \{\
  vpc_id            = aws_vpc.main.id\
  cidr_block        = "10.0.102.0/24"\
  availability_zone = "$\{var.aws_region\}b"\
  tags = \{\
    Name = "Private-Subnet-B"\
  \}\
\}\
\
# 4. Create Security Group for the Load Balancer\
resource "aws_security_group" "alb_sg" \{\
  name        = "alb-security-group"\
  description = "Allow HTTP traffic from anywhere"\
  vpc_id      = aws_vpc.main.id\
\
  ingress \{\
    from_port   = 80\
    to_port     = 80\
    protocol    = "tcp"\
    cidr_blocks = ["0.0.0.0/0"]\
  \}\
\
  egress \{\
    from_port   = 0\
    to_port     = 0\
    protocol    = "-1"\
    cidr_blocks = ["0.0.0.0/0"]\
  \}\
\}\
\
# 5. Create Security Group for the Web Servers\
resource "aws_security_group" "web_sg" \{\
  name        = "web-server-security-group"\
  description = "Allow HTTP traffic only from the ALB"\
  vpc_id      = aws_vpc.main.id\
\
  ingress \{\
    from_port       = 80\
    to_port         = 80\
    protocol        = "tcp"\
    security_groups = [aws_security_group.alb_sg.id] # IMPORTANT: Only allows traffic from our ALB\
  \}\
\
  egress \{\
    from_port   = 0\
    to_port     = 0\
    protocol    = "-1"\
    cidr_blocks = ["0.0.0.0/0"]\
  \}\
\}\
\
# NOTE: The code for ALB, Launch Template, and Auto Scaling Group would follow this.\
# This starter code creates a solid foundation.}