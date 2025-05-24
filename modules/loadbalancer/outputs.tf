output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = aws_lb.hyfer-alb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.hyfer-alb.zone_id
}

