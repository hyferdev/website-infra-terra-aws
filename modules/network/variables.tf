variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_cidr_1" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "public_subnet_cidr_2" {
  description = "CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr_1" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "private_subnet_cidr_2" {
  description = "CIDR block for the private subnet"
  type        = string
}

variable "availability_zone_1" {
  description = "Primary Availability Zone"
  type        = string
}

variable "availability_zone_2" {
  description = "Secondary Availability Zone"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to resources"
  type        = map(string)
}

variable "allowed_ip" {
  description = "IP address allowed to access SSH (22) and LDAP (389)"
  type        = string
}
