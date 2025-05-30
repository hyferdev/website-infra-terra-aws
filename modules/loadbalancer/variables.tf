variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs to attach the load balancer"
  type        = list(string)
}

variable "target_instance_ids" {
  description = "List of instance IDs to attach to the Target Group"
  type        = map(string)
}

variable "tags" {
  description = "Common tags to apply to resources in this module"
  type        = map(string)
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate to use for HTTPS"
  type        = string
}

