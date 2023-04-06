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

  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.Vpc_cidr_block, 8, length(local.azs) + count.index) #generate unique CIDR blocks for subnets-different index based on index count
  #(...length(local.azs)+ count.index )to prevent cdir_block conflict

  availability_zone = local.azs[1]  #availability zone for the subnet

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


# create vpc flow logs

# resource "aws_flow_log" "loggs" {
#   iam_role_arn    = aws_iam_role.flowlog.arn
#   log_destination = aws_cloudwatch_log_group.alerts.arn
#   traffic_type    = "ALL"
#   vpc_id          = aws_vpc.vpc.id
# }

# resource "aws_cloudwatch_log_group" "alerts" {
#   name = var.aws_cloudwatch_log
# }

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["vpc-flow-logs.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "flowlog" {
#   name               = var.aws_iam_role_flow_log
#   assume_role_policy = data.aws_iam_policy_document.assume_role.json
# }

# data "aws_iam_policy_document" "flowlog" {
#   statement {
#     effect = "Allow"

#     actions = [
#       "logs:CreateLogGroup",
#       "logs:CreateLogStream",
#       "logs:PutLogEvents",
#       "logs:DescribeLogGroups",
#       "logs:DescribeLogStreams",
#     ]

#     resources = ["*"]
#   }
# }

# resource "aws_iam_role_policy" "flowlog" {
#   name   = "flowlog"
#   role   = aws_iam_role.flowlog.id
#   policy = data.aws_iam_policy_document.flowlog.json
# }

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
