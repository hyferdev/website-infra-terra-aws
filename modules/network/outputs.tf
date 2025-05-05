output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}

output "private_subnet_id_1" {
  value = aws_subnet.private_1.id
}

output "private_subnet_id_2" {
  value = aws_subnet.private_2.id
}

output "security_group_id" {
  value = aws_security_group.hyfer_sg.id
}

