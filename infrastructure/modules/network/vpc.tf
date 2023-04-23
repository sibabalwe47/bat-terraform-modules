/*
 *  Random ID generator
 */
resource "random_id" "backend_id" {
  byte_length = 5
}


/*
 *  Virtual private cloud
 */
resource "aws_vpc" "vpc" {
  cidr_block           = var.Vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "${var.vpc_name}-network-${random_id.backend_id.dec}"
  }
}
