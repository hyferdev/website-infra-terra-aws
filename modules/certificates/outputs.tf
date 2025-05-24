output "certificate_arn" {
  description = "ARN of the requested ACM certificate"
  value       = aws_acm_certificate.cert.arn
}

output "domain_validation_options" {
  description = "Domain validation options for Route 53 DNS validation"
  value       = aws_acm_certificate.cert.domain_validation_options
}

