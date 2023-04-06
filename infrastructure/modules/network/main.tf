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
# First Subnets 

resource "aws_subnet" "public_subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet-1_cidr_block
  availability_zone = var.availability_zone[0] #for us-east-1a
  tags = {
  Name = var.public_subnet-1_name }
}

resource "aws_subnet" "private_subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet-1_cidr_block

  availability_zone = var.availability_zone[1] #for us-east-1b

  tags = {
    Name = var.private_subnet-1_name
  }
}

# Second Subnets

resource "aws_subnet" "public_subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet-2_cidr_block
  availability_zone = var.public_subnet_awz
  tags = {
  Name = var.public_subnet-2_name }
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet-2_cidr_block
  availability_zone = var.private_subnet_awz

  tags = {
    Name = var.private_subnet-2_name
  }
}

# create vpc flow logs

resource "aws_flow_log" "loggs" {
  iam_role_arn    = aws_iam_role.flowlog.arn
  log_destination = aws_cloudwatch_log_group.alerts.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.vpc.id
}

resource "aws_cloudwatch_log_group" "alerts" {
  name = var.aws_cloudwatch_log
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["vpc-flow-logs.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "flowlog" {
  name               = var.aws_iam_role_flow_log
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "flowlog" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "flowlog" {
  name   = "flowlog"
  role   = aws_iam_role.flowlog.id
  policy = data.aws_iam_policy_document.flowlog.json
}

#Network ACL

resource "aws_network_acl" "vaya_network_acl" {
  vpc_id = aws_vpc.vpc.id

  egress {
    protocol   = "-1"           #Allows all protocols (TCP, UDP, ICMP)
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"    #Allowing All IP Addresses
    from_port  = 0              #From All Port Ranges
    to_port    = 0
  }

  ingress {
    protocol   = "-1"           #Allows all protocols (TCP, UDP, ICMP)
    rule_no    = 200
    action     = "allow"
    cidr_block = "0.0.0.0/0"    #Allowing All IP Addresses
    from_port  = 0              #From All Port Ranges
    to_port    = 0
  }
    tags = {
      
    Name = "vaya_NACL"

    }
  
}
