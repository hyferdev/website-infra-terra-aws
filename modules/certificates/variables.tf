variable "full_domain" {
  description = "The full domain name for the certificate (e.g., quotestorm.desire-projects.com)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the certificate"
  type        = map(string)
  default     = {}
}

variable "validation_record_fqdns" {
  description = "FQDNs of Route 53 validation records"
  type        = list(string)
}

