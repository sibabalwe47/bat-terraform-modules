
/*
 *  Subnet security group
 */
resource "aws_security_group" "subnet_security_group" {
  name        = "${var.vpc_name}-sg-${random_id.backend_id.dec}"
  description = "Security group for public instances"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description = "HTTP access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-sg-${random_id.backend_id.dec}"
  }
}

/*
 *  ALB security group
 */
resource "aws_security_group" "alb_security_group" {
  name        = "alb security group"
  description = "Enable http/https access on port 80/443"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.vpc_name}-alb-sg-${random_id.backend_id.dec}"
  }

}

#Database Security Group

resource "aws_security_group" "database_security_group" {
  name             = "DB security group"
  description      = "Enable ec2 instances access to port 1433 (MSSQL)"
  vpc_id           = aws_vpc.vpc.id
  


  ingress {
    description      = "MSSQL access"
    from_port        = 1433
    to_port          = 1433
    protocol         = "tcp"
    security_groups = [aws_security_group.subnet_security_group.id]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = -1
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags   = {
    Name = "${var.vpc_name}-db-sg-${random_id.backend_id.dec}"
  }

}



