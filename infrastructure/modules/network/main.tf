#1. VPC

resource "aws_vpc" "vpc" {
  cidr_block           = var.Vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name = var.vpc_name

  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.internet_gateway
  }
}

# private Subnets created

resource "aws_subnet" "private_subnets" {

  count = 4

  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.Vpc_cidr_block, 8, length(local.azs) + count.index) #generate unique CIDR blocks for subnets-different index based on index count
  #(...length(local.azs)+ count.index )to prevent cdir_block conflict

  availability_zone = local.azs[count.index]

  tags = {
    Name = "private_subnet-${count.index + 0}" #private subnet 1 and 2 names
  }
}


#public Subnets created
resource "aws_subnet" "public_subnets" {

  count = 2

  vpc_id = aws_vpc.vpc.id

  cidr_block = cidrsubnet(var.Vpc_cidr_block, 8, count.index) #generate unique CIDR blocks for subnets-different index based on index count
  availability_zone = local.azs[count.index]

  tags = {
    Name = "public_subnet-${count.index + 0}" #public subnet 1 and public subnet 2
  }
}

#Network ACL

resource "aws_network_acl" "vaya_network_acl" {
  vpc_id = aws_vpc.vpc.id

  egress {
    protocol   = "-1" #Allows all protocols (TCP, UDP, ICMP)
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0" #Allowing All IP Addresses
    from_port  = 0           #From All Port Ranges
    to_port    = 0
  }

  ingress {
    protocol   = "-1" #Allows all protocols (TCP, UDP, ICMP)
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0" #Allowing All IP Addresses
    from_port  = 0           #From All Port Ranges
    to_port    = 0
  }
  tags = {

    Name = "vaya_NACL"

  }

}

# create vpc flow logs

resource "aws_flow_log" "flowlogs" {
  log_destination      = aws_s3_bucket.s3_bucket.arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc.id
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "my_s3_bucket"

  tags = {
    Name = var.the_s3_bucket
  }
}

resource "aws_route_table" "vaya_route" {
  vpc_id = aws_vpc.vpc.id
  tags = {

    Name = var.route_table
  }

}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.vaya_route.id
  destination_cidr_block = var.route_table_cidr
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "route_assoc" {
  gateway_id     = aws_internet_gateway.gw.id
  route_table_id = aws_route_table.vaya_route.id
}

# Security group

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    # ipv6_cidr_blocks = [aws_vpc.vpc.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = var.security_group
  }
}

#Auto-Scaling Group Launch Template

resource "aws_launch_template" "asg_launch_template" {
  name_prefix   = "asg_launch_template"
  image_id      = "ami-0bde1eb2c18cb2abe"
  instance_type = "t2.micro"
  key_name      = "VW_Widows_key"
}

#Auto-Scaling Group

resource "aws_autoscaling_group" "asg" {
  
  availability_zones = ["us-east-1a","us-east-1b"]
   

  desired_capacity   = 1
  max_size           = 5
  min_size           = 1
  health_check_type  = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.asg_launch_template.id
    name    = "asg_launch_template"
    version = "$Latest"
  }
}

#Security group for the Application Load Balancer
resource "aws_security_group" "alb_security_group" {
  name        = "alb security group"
  description = "enable http/https access on port 80/443"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    description      = "http access"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "https access"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "alb-sg"
  }
}

