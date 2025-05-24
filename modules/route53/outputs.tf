output "validation_record_fqdns" {
  description = "Fully-qualified domain names for validation records"
  value       = [for record in aws_route53_record.validation : record.fqdn]
}

