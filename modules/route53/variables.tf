variable "domain_name" {
  description = "The root domain name (e.g., desire-projects.com)"
  type        = string
}

variable "domain_validation_options" {
  description = "Validation options from the ACM certificate"
  type = list(object({
    domain_name           = string
    resource_record_name  = string
    resource_record_type  = string
    resource_record_value = string
  }))
}

variable "alias_record_name" {
  description = "The subdomain to point to the ALB (e.g., quotestorm.desire-projects.com)"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "Zone ID of the ALB"
  type        = string
}

