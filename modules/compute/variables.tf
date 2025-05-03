variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}

variable "private_subnet_id_1" {
  description = "ID of the private subnet"
  type        = string
}

variable "private_subnet_id_2" {
  description = "ID of the private subnet"
  type        = string
}

variable "security_group_id" {
  description = "ID of the security group to assign to instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for Ubuntu VMs"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "SSH key pair name for the instances"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to resources in this module"
  type        = map(string)
}

