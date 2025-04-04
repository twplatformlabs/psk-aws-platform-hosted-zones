terraform {
  required_version = "~> 1.9"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.94"
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
