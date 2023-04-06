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

# availability zones
data "aws_availability_zones" "available" {}

locals {
  azs = data.aws_availability_zones.available.names
}

variable "route_table_cidr" {
  type    = string
  default = "0.0.0.0/0"

  description = "cdirblock for route table"
}

variable "route_table" {
  type    = string
  default = "vaya.route"

  description = "route table name tag"
}

variable "security_group" {
  type    = string
  default = "allow_tls"

  description = "security_group name tag"
}
