output "load_balancer_dns_name" {
  value = module.network_module.load_balancer_dns_name
}

output "certificate_arn" {
  value = module.acm.certificate_arn
  
}
# 