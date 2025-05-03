variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.80.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.80.10.0/24"
}

variable "private_subnet_cidr_1" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.80.20.0/24"
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.80.25.0/24"
}

variable "availability_zone_1" {
  description = "Primary Availability Zone"
  type        = string
  default     = "us-east-1a"
}

variable "availability_zone_2" {
  description = "Secondary Availability Zone"
  type        = string
  default     = "us-east-1b"
}

variable "tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
  default = {
    Environment = "Practice"
    Owner       = "Hyfer"
    CreatedBy   = "Terraform"
  }
}

variable "allowed_ip" {
  description = "IP address allowed to access SSH (22) and LDAP (389)"
  type        = string
  default     = "0.0.0.0/32"  # Replace with your real IP or leave to override in Terraform Cloud
}
