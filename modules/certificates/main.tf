resource "aws_acm_certificate" "cert" {
  domain_name       = var.full_domain
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
  tags = var.tags
}
resource "aws_acm_certificate_validation" "cert_validation" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = var.validation_record_fqdns
}
