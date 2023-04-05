#VPC

variable "vpc_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = "vaya_vpc"
}
variable "Vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

#Internet gateway
variable "internet_gateway" {
  description = "Name of the internet gateway"
  type        = string
  default     = "Vaya_int_gateway"
}


#Public and private subnets
# First Subnets

variable "public_subnet-1_cidr_block" {
  description = "CIDR block for public Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "public_subnet-1_name" {
  description = "public subnet name"
  type        = string
  default     = "public"
}

variable "public_subnet_awz" {
  description = "public subnet availability zone"
  type        = string
  default     = "us-east-1a"
}


variable "private_subnet-1_cidr_block" {
  description = "CIDR block for private Subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet-1_name" {
  description = "private subnet name"
  type        = string
  default     = "private"
}

variable "private_subnet_awz" {
  description = "private subnet availability zone"
  type        = string
  default     = "us-east-1b"
}

# Second Subnets

variable "public_subnet-2_cidr_block" {
  description = "CIDR block for public Subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "public_subnet-2_name" {
  description = "public subnet name"
  type        = string
  default     = "public"
}

variable "public_subnet_awz" {
  description = "public subnet availability zone"
  type        = string
  default     = "us-east-1a"
}


variable "private_subnet-2_cidr_block" {
  description = "CIDR block for private Subnet"
  type        = string
  default     = "10.0.4.0/24"
}

variable "private_subnet-2_name" {
  description = "private subnet name"
  type        = string
  default     = "private"
}

variable "private_subnet_awz" {
  description = "private subnet availability zone"
  type        = string
  default     = "us-east-1b"
}