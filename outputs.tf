output "public_vm_public_ip" {
  value = module.compute.public_vm_public_ip
}

output "webfront_vm_1_private_ip" {
  value = module.compute.webfront_vm_1_private_ip
}

output "webfront_vm_2_private_ip" {
  value = module.compute.webfront_vm_2_private_ip
}

output "alb_dns_name" {
  value = module.loadbalancer.alb_dns_name
}
