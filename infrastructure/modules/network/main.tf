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
  availability_zone =var.public_subnet_awz
  tags = {
  Name = var.public_subnet-1_name }
}

resource "aws_subnet" "private_subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet-1_cidr_block
  availability_zone =var.private_subnet_awz

  tags = {
    Name =var.private_subnet-1_name
  }
}

# Second Subnets

resource "aws_subnet" "public_subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.public_subnet-2_cidr_block
  availability_zone =var.public_subnet_awz
  tags = {
  Name = var.public_subnet-2_name }
}

resource "aws_subnet" "private_subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet-2_cidr_block
  availability_zone =var.private_subnet_awz

  tags = {
    Name =var.private_subnet-2_name
  }
}