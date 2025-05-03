terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "Hyfer"

    workspaces {
      name = "website-infra-aws"
    }
  }
}
