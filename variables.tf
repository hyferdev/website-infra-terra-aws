variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
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

variable "key_name" {
  description = "SSH Key Pair name for EC2 instances"
  type        = string
  default     = "RedKeys"
}
