terraform {
  required_version = "~> 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "twplatformlabs"
    workspaces {
      prefix = "psk-aws-platform-hosted-zones-"
    }
  }
}
