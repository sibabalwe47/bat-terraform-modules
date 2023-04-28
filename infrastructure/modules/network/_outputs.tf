
# vpc ID
output "vpc_id" {
  value = aws_vpc.vpc.id
}

# gateway ID
output "gateway_id" {
  value = aws_internet_gateway.internet_gateway.id
}

# route table ID
output "route_table_id" {
  value = aws_route_table.public_route_table.id
}

output "alb_security_group" {
  value = aws_security_group.alb_security_group.id
}

output "security_group" {
  value = aws_security_group.subnet_security_group.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "load_balancer_dns_name" {
  value = aws_lb.alb.dns_name
}

output "load_balancer_name" {
  value = aws_lb.alb.name
}

output "load_balancer_target_group_arn" {
  value = aws_lb_target_group.target_group.arn
}

output "database_security_group" {
  value = aws_security_group.database_security_group.id
}

output "local_azs" {
  value = data.aws_availability_zones.available.names

}

output "aws_lb_id" {
  value = aws_lb.alb.id
}

output "db_subnet_group" {
  value = aws_db_subnet_group.db_subnet_group
}


output "db_security_group_id" {
  value = aws_security_group.db_security_group.id
}