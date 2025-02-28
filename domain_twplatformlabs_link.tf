locals {
  domain_twplatformlabs_link = "twplatformlabs.link"
}

provider "aws" {
  alias  = "domain_twplatformlabs_link"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.prod_account_id}:role/${var.assume_role}"
  }
}

# zone id for the top-level-zone
data "aws_route53_zone" "zone_id_twplatformlabs_link" {
  provider = aws.domain_twplatformlabs_link
  name     = local.domain_twplatformlabs_link
}
