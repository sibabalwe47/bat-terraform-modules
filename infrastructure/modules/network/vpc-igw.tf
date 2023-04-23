/*
 *  Internet gateway
 */

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.vpc_name}-igw-${random_id.backend_id.dec}"
  }
}
