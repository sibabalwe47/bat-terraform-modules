resource "aws_vpc" "network" {
    cidr_block = var.vpc_cidr
}