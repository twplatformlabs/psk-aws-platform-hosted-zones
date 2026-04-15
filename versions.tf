terraform {
  required_version = "~> 1.14"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.40"
    }
  }

  # The backend cloud store is managed using the terraform orb tfc-backend command.
  # this command will generate the appropriate template for the tf workspace:
  #
  # terraform {
  #   cloud {
  #     organization = "${TFC_ORGANIZATION}"
  #     hostname = "app.terraform.io"

  #     workspaces {
  #       name = "${TFC_WORKSPACE}"
  #     }
  #   }
  # }
}
