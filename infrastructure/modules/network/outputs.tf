
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

#  SUBNETS IDs

output "public_subnet_id" {
  description = "ID of the VPC public subnet"
  value       = aws_subnet.public_subnet-1.id
}

output "private_subnet_id" {
  description = "ID of the VPC private subnet"
  value       = aws_subnet.private_subnet-1.id
}

output "public_subnet_id" {
  description = "ID of the VPC public subnet"
  value       = aws_subnet.public_subnet-2.id
}

output "private_subnet_id" {
  description = "ID of the VPC private subnet"
  value       = aws_subnet.private_subnet-2.id
}