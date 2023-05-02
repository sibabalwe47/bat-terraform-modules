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

# resource "aws_vpc_endpoint" "ec2_endpoint" {
#   vpc_id              = aws_vpc.vpc.id
#   service_name        = "com.amazonaws.us-east-1.ec2"
#   vpc_endpoint_type   = "Interface"
#   security_group_ids  = [aws_security_group.ec2.id]
#   subnet_ids          = [aws_subnet.private_subnet.id, aws_subnet.public_subnet.id]
#   private_dns_enabled = true

#   tags = {
#     Name = "${var.vpc_name}-ec2-endpoint-${random_id.backend_id.dec}"
#   }
# }