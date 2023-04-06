
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

