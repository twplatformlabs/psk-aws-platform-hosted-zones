# define a provider for the managing account of the subdomain
provider "aws" {
  alias  = "sandbox_account"
  region = "us-east-2"
  assume_role {
    role_arn     = "arn:aws:iam::${var.nonprod_account_id}:role/${var.assume_role}"
    session_name = "lab-platform-hosted-zones"
  }
}

#create the subdomain
module "sandbox_subdomain" {
  source  = "terraform-aws-modules/route53/aws//modules/zones"
  version = "2.0.0"

  providers = {
    aws = aws.sandbox_account
  }

  zones = {
    "sandbox.${var.top_level_domain}" = {
      comment = "subdomain hosted zone for dps lab sandbox cluster"
    }
  }

  tags = {
    cluster        = "sandbox"
    pipeline       = "lab-platform-hosted-zones"
  }
}

module "sandbox_zone_delegation" {
  source  = "terraform-aws-modules/route53/aws//modules/records"
  version = "~> 2.0"

  providers = {
    aws = aws.top_level_domain
  }

  zone_name = var.top_level_domain
  records = [
    {
      name            = "sandbox"
      type            = "NS"
      ttl             = 172800
      zone_id         = data.aws_route53_zone.top_level_zone.id
      allow_overwrite = true
      records         = lookup(module.sandbox_subdomain.route53_zone_name_servers,"sandbox.${var.top_level_domain}")
    }
  ]

  depends_on = [module.sandbox_subdomain]
}
