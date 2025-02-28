locals {
  domain_twplatformlabs_org = "twplatformlabs.org"
}

provider "aws" {
  alias  = "domain_twplatformlabs_org"
  region = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.prod_account_id}:role/${var.assume_role}"
  }
}

# zone id for the top-level-zone
data "aws_route53_zone" "zone_id_twplatformlabs_org" {
  provider = aws.domain_twplatformlabs_org
  name     = local.domain_twplatformlabs_org
}
