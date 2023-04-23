
/*
 *  Public route table
 */
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.vpc_name}-public-rt-${random_id.backend_id.dec}"
  }
}

resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}


/*
 *  Private route table
 */
resource "aws_default_route_table" "mtc_private_rt" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id

  tags = {
    Name = "${var.vpc_name}-vpc-rt-${random_id.backend_id.dec}"
  }
}
