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

#create subnets 

# private Subnets created

resource "aws_subnet" "private_subnets" {

  count = 2 #create 2 private subnets

  /*
    Use:

    count                   = length(local.azs) 

    Why:

    You are currently limiting the infrastructure to 2 subnets. You want to make it dynamic, so please replace
    the hardcoded value with the length of the azs

   */

  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.Vpc_cidr_block, 8, length(local.azs) + count.index) #generate unique CIDR blocks for subnets-different index based on index count
  #(...length(local.azs)+ count.index )to prevent cdir_block conflict

  availability_zone = local.azs[1]  #availability zone for the subnet

    /*
    Use:

    availability_zone = local.azs[count.index]

    Why:

    Because of the hardcoded value of 1, all your subnets are currently in the same AZ.

   */

  tags = {
    Name = "private_subnet-${count.index + 0}"  #private subnet 1 and 2 names
  }
}


#public Subnets created
resource "aws_subnet" "public_subnets" {

  count = 2 #create 2 public subnets

  vpc_id = aws_vpc.vpc.id

  cidr_block        = cidrsubnet(var.Vpc_cidr_block, 8, count.index) #generate unique CIDR blocks for subnets-different index based on index count
  availability_zone = local.azs[0]                                   #availability zone for the subnet

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
    Name        =var.the_s3_bucket
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
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.vpc.cidr_block]
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
