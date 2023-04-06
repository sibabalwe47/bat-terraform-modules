
# vpc ID

output "vpc_id"{
    description = "VPC ID"
    value =aws_vpc.vpc.id
} 

# gateway ID

output "gateway_id" {
  description = "ID of the internet gateway"
  value       = aws_internet_gateway.gw.id
}
# route table ID

output "route_table_id" {
  description = "ID route table"
  value       = aws_route_table.vaya_route.id
}
