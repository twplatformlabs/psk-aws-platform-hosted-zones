terraform {
  required_version = "~> 0.15.3"
  required_providers {
    aws        = ">= 3.40"
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "twdps"
    workspaces {
      prefix = "lab-platform-hosted-zones-"
    }
  }
}

