
/*
 *  Public subnets
 */
resource "aws_subnet" "public_subnet" {
  count                   = 4
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.Vpc_cidr_block, 8, count.index)
  map_public_ip_on_launch = true
  availability_zone       = local.azs[count.index]
  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}


/*
 *  Private subnets
 */
resource "aws_subnet" "private_subnet" {
  count                   = 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.Vpc_cidr_block, 8, length(local.azs) + count.index)
  map_public_ip_on_launch = false
  availability_zone       = local.azs[count.index]
  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}" #private subnet 1 and 2 names
  }
}

/*
 *  Public subnets associations
 */
resource "aws_route_table_association" "public_subnets_association" {
  count          = 4
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_route_table.id
}


/*
 *  DB subnet group
 */
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.vpc_name}-db-group-${random_id.backend_id.dec}"
  subnet_ids = [for subnet in aws_subnet.private_subnet : subnet.id]

  tags = {
    "Name" = "${var.vpc_name}-db-group-${random_id.backend_id.dec}"
    source = "TERRAFORM"
  }
}
