
provider "aws" {
  alias  = "top_level_domain"
  region = "us-east-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.prod_account_id}:role/${var.assume_role}"
  }
}

# zone id for the top-level-zone
data "aws_route53_zone" "top_level_zone" {
  provider = aws.top_level_domain
  name     = var.top_level_domain
}
