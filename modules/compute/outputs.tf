output "public_vm_id" {
  value = aws_instance.public_vm.id
}

output "webfront_vm_1_id" {
  description = "EC2 instance ID for webfront 1"
  value       = aws_instance.webfront_vm_1.id
}

output "webfront_vm_2_id" {
  description = "EC2 instance ID for webfront 2"
  value       = aws_instance.webfront_vm_2.id
}

output "public_vm_public_ip" {
  description = "Public IP address of the public VM"
  value       = aws_instance.public_vm.public_ip
}

output "webfront_vm_1_private_ip" {
  value = aws_instance.webfront_vm_1.private_ip
}

output "webfront_vm_2_private_ip" {
  value = aws_instance.webfront_vm_2.private_ip
}

