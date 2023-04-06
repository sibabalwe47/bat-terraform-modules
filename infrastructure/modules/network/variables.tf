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


# variable "public_subnet-1a_name" {
#   description = "public subnet name"
#   type        = string
#   default     = "public"
# }



# variable "private_subnet-1a_name" {
#   description = "private subnet name"
#   type        = string
#   default     = "private"
# }

# Second Subnets

# variable "public_subnet-1b_name" {
#   description = "public subnet name"
#   type        = string
#   default     = "public"
# }

# variable "private_subnet-1b_name" {
#   description = "private subnet name"
#   type        = string
#   default     = "private"
# }

data "aws_availability_zones" "available" {}

locals {
  azs = data.aws_availability_zones.available.names
}

# variable "subnets_cidr_blocks" {

#   description = "cidr_blocks for subnets"
#   type        = list(string)
#   default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]

# }